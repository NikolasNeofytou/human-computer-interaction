import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/analytics/analytics_service.dart';
import '../../../core/providers/data_providers.dart';
import '../../../theme/tokens.dart';
import '../models/chat_message.dart';
import '../widgets/voice_message_widgets.dart';
import '../widgets/file_attachment_widgets.dart';
import '../widgets/file_reference_widgets.dart';
import '../widgets/chat_files_gallery.dart';

/// Enhanced chat controller with support for voice, files, and references
final chatThreadsProvider =
    StateNotifierProvider<EnhancedChatController, Map<String, List<ChatMessage>>>(
  (ref) => EnhancedChatController(ref.read(analyticsProvider)),
);

class EnhancedChatController extends StateNotifier<Map<String, List<ChatMessage>>> {
  EnhancedChatController(this._analytics)
      : super({
          'all': [
            ChatMessage(
              id: '1',
              author: 'Alex',
              timestamp: DateTime.now().subtract(const Duration(hours: 2)),
              isMe: false,
              type: MessageType.text,
              text: 'Let\'s finalize the tasks for Project X.',
            ),
            ChatMessage(
              id: '2',
              author: 'You',
              timestamp: DateTime.now().subtract(const Duration(hours: 1)),
              isMe: true,
              type: MessageType.text,
              text: 'On it. Adding deadlines now.',
            ),
          ],
        });

  final AnalyticsService _analytics;
  int _messageIdCounter = 3;

  void sendTextMessage(String channelId, String text) {
    if (text.trim().isEmpty) return;

    final hasReferences = FileReferenceParser.hasReferences(text);
    final references = hasReferences ? FileReferenceParser.parse(text) : <FileReference>[];

    final msg = ChatMessage(
      id: (_messageIdCounter++).toString(),
      author: 'You',
      timestamp: DateTime.now(),
      isMe: true,
      type: hasReferences ? MessageType.textWithReferences : MessageType.text,
      text: text.trim(),
      fileReferences: references,
    );

    final list = state[channelId] ?? [];
    state = {
      ...state,
      channelId: [...list, msg],
    };

    _analytics.logEvent('chat_send_text', parameters: {'length': text.trim().length});
  }

  void sendVoiceMessage(String channelId, String voicePath, Duration duration) {
    final msg = ChatMessage(
      id: (_messageIdCounter++).toString(),
      author: 'You',
      timestamp: DateTime.now(),
      isMe: true,
      type: MessageType.voice,
      voicePath: voicePath,
      voiceDuration: duration,
    );

    final list = state[channelId] ?? [];
    state = {
      ...state,
      channelId: [...list, msg],
    };

    _analytics.logEvent('chat_send_voice', parameters: {'duration': duration.inSeconds});
  }

  void sendFileMessage(
    String channelId,
    String filePath,
    String fileName,
    int fileSize,
    FileAttachmentType fileType,
  ) {
    final msg = ChatMessage(
      id: (_messageIdCounter++).toString(),
      author: 'You',
      timestamp: DateTime.now(),
      isMe: true,
      type: MessageType.file,
      filePath: filePath,
      fileName: fileName,
      fileSize: fileSize,
      fileType: fileType,
    );

    final list = state[channelId] ?? [];
    state = {
      ...state,
      channelId: [...list, msg],
    };

    _analytics.logEvent('chat_send_file', parameters: {'type': fileType.name});
  }
}

/// Enhanced chat screen with voice and file support
class EnhancedChatScreen extends ConsumerWidget {
  const EnhancedChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final threads = ref.watch(chatThreadsProvider);
    final projectsAsync = ref.watch(projectsProvider);

    // Build channel list
    final channels = <_ChannelView>[
      _ChannelView(
        id: 'all',
        label: 'All projects',
        messages: threads['all'] ?? const [],
      ),
    ];

    projectsAsync.whenData((projects) {
      for (final p in projects) {
        channels.add(
          _ChannelView(
            id: p.id,
            label: p.name,
            messages: threads[p.id] ?? const [],
          ),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(title: const Text('Chat')),
      body: ListView.separated(
        padding: const EdgeInsets.all(AppSpacing.lg),
        itemCount: channels.length,
        separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
        itemBuilder: (context, index) {
          final channel = channels[index];
          final last = channel.messages.isNotEmpty ? channel.messages.last : null;
          final subtitle = _getMessagePreview(last);
          final accent = Theme.of(context).colorScheme.primary.withOpacity(0.15);

          return ListTile(
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            leading: CircleAvatar(
              backgroundColor: accent,
              child: Text(channel.label.isNotEmpty ? channel.label[0].toUpperCase() : '?'),
            ),
            title: Text(channel.label, style: Theme.of(context).textTheme.titleMedium),
            subtitle: Text(
              subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            onTap: () {
              context.go('/chat/${channel.id}', extra: channel.label);
            },
          );
        },
      ),
    );
  }

  String _getMessagePreview(ChatMessage? msg) {
    if (msg == null) return 'No messages yet';

    switch (msg.type) {
      case MessageType.text:
      case MessageType.textWithReferences:
        return msg.text ?? 'Message';
      case MessageType.voice:
        return '🎤 Voice message';
      case MessageType.file:
        return '📎 ${msg.fileName ?? 'File'}';
    }
  }
}

/// Enhanced chat thread screen with voice, files, and references
class EnhancedChatThreadScreen extends ConsumerStatefulWidget {
  const EnhancedChatThreadScreen({
    super.key,
    required this.channelId,
    required this.label,
  });

  final String channelId;
  final String label;

  @override
  ConsumerState<EnhancedChatThreadScreen> createState() => _EnhancedChatThreadScreenState();
}

class _EnhancedChatThreadScreenState extends ConsumerState<EnhancedChatThreadScreen> {
  final _controller = TextEditingController();
  bool _sending = false;
  bool _isRecordingVoice = false;
  InputMode _inputMode = InputMode.text;
  String _currentText = '';

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _currentText = _controller.text;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _sendText() async {
    if (_controller.text.trim().isEmpty || _sending) return;

    setState(() => _sending = true);
    ref.read(chatThreadsProvider.notifier).sendTextMessage(
          widget.channelId,
          _controller.text,
        );
    _controller.clear();
    await Future.delayed(const Duration(milliseconds: 250));
    if (mounted) setState(() => _sending = false);
  }

  void _sendVoice(String path, Duration duration) {
    ref.read(chatThreadsProvider.notifier).sendVoiceMessage(
          widget.channelId,
          path,
          duration,
        );
    setState(() => _isRecordingVoice = false);
  }

  void _sendFile(FileAttachment file) {
    ref.read(chatThreadsProvider.notifier).sendFileMessage(
          widget.channelId,
          file.path,
          file.name,
          file.size,
          file.type,
        );
  }

  void _showFileAttachmentSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) => FileAttachmentSheet(
        onImagePicked: _sendFile,
        onDocumentPicked: _sendFile,
        onFilePicked: _sendFile,
      ),
    );
  }

  void _showFilesGallery() {
    final messages = ref.read(chatThreadsProvider)[widget.channelId] ?? [];
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatFilesGallery(messages: messages),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final threads = ref.watch(chatThreadsProvider);
    final messages = threads[widget.channelId] ?? const [];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.label),
        actions: [
          IconButton(
            icon: const Icon(Icons.folder_open),
            onPressed: _showFilesGallery,
            tooltip: 'View shared files',
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(AppSpacing.lg),
              reverse: true,
              itemCount: messages.length,
              separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
              itemBuilder: (context, index) {
                final msg = messages[messages.length - 1 - index];
                return _EnhancedChatMessage(message: msg);
              },
            ),
          ),
          const Divider(height: 1),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    if (_isRecordingVoice) {
      return Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: VoiceRecorder(
          onRecordingComplete: _sendVoice,
          onCancel: () => setState(() => _isRecordingVoice = false),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Row(
        children: [
          // Attach file button
          IconButton(
            onPressed: _showFileAttachmentSheet,
            icon: const Icon(Icons.attach_file),
            tooltip: 'Attach file',
          ),
          // Voice button
          IconButton(
            onPressed: () => setState(() => _isRecordingVoice = true),
            icon: const Icon(Icons.mic),
            tooltip: 'Voice message',
          ),
          const SizedBox(width: AppSpacing.xs),
          // Text input
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Type here...',
                border: OutlineInputBorder(),
              ),
              onSubmitted: (_) => _sendText(),
              maxLines: null,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          // Send button
          FilledButton(
            onPressed: _currentText.trim().isNotEmpty && !_sending ? _sendText : null,
            child: _sending
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Icon(Icons.send, size: 18),
          ),
        ],
      ),
    );
  }
}

enum InputMode { text, voice }

/// Enhanced message bubble supporting voice, files, and references
class _EnhancedChatMessage extends StatelessWidget {
  const _EnhancedChatMessage({required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final alignment = message.isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start;
    final bg = message.isMe
        ? AppColors.primary.withOpacity(0.18)
        : colorScheme.surfaceContainerHighest;
    final border = message.isMe ? AppColors.primary : colorScheme.outline.withOpacity(0.35);

    return Column(
      crossAxisAlignment: alignment,
      children: [
        Text(
          message.author,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.75,
          ),
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(AppRadii.md),
            border: Border.all(color: border),
          ),
          child: _buildMessageContent(),
        ),
      ],
    );
  }

  Widget _buildMessageContent() {
    switch (message.type) {
      case MessageType.text:
        return Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: Text(
            message.text ?? '',
            style: TextStyle(
              color: message.isMe ? Colors.white : null,
            ),
          ),
        );

      case MessageType.textWithReferences:
        return Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: MessageTextWithReferences(
            text: message.text ?? '',
            references: message.fileReferences,
            isMe: message.isMe,
          ),
        );

      case MessageType.voice:
        return VoiceMessagePlayer(
          voicePath: message.voicePath ?? '',
          duration: message.voiceDuration ?? Duration.zero,
          isMe: message.isMe,
        );

      case MessageType.file:
        return FileAttachmentPreview(
          fileName: message.fileName ?? 'File',
          fileSize: message.fileSize ?? 0,
          fileType: message.fileType ?? FileAttachmentType.other,
          filePath: message.filePath ?? '',
          isMe: message.isMe,
        );
    }
  }
}

class _ChannelView {
  const _ChannelView({
    required this.id,
    required this.label,
    required this.messages,
  });

  final String id;
  final String label;
  final List<ChatMessage> messages;
}
