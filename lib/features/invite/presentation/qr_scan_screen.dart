import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import '../../../core/providers/qr_providers.dart';
import '../../../core/services/qr_scan_service.dart';
import '../../../core/providers/feedback_providers.dart';
import '../../../core/services/feedback_service.dart';

/// Screen for scanning QR codes to join projects
class QRScanScreen extends ConsumerStatefulWidget {
  const QRScanScreen({super.key});

  @override
  ConsumerState<QRScanScreen> createState() => _QRScanScreenState();
}

class _QRScanScreenState extends ConsumerState<QRScanScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? _controller;
  bool _hasScanned = false;
  bool _flashOn = false;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      _controller?.pauseCamera();
    }
    _controller?.resumeCamera();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    _controller = controller;
    final qrScanService = ref.read(qrScanServiceProvider);
    qrScanService.initialize(controller);

    controller.scannedDataStream.listen((scanData) {
      if (_hasScanned) return; // Prevent multiple scans

      final code = scanData.code;
      if (code == null || code.isEmpty) return;

      _handleScan(code);
    });
  }

  Future<void> _handleScan(String data) async {
    if (_hasScanned) return;

    setState(() {
      _hasScanned = true;
    });

    final qrScanService = ref.read(qrScanServiceProvider);
    await qrScanService.pauseScanning();

    // Validate invite link
    if (!qrScanService.isValidInviteLink(data)) {
      // Invalid QR code - show error
      await ref.read(feedbackServiceProvider).trigger(FeedbackType.error);
      
      if (!mounted) return;
      
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Invalid QR Code'),
          content: const Text('This QR code is not a valid project invite.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Try Again'),
            ),
          ],
        ),
      );

      setState(() {
        _hasScanned = false;
      });
      await qrScanService.startScanning();
      return;
    }

    // Valid invite - trigger success feedback
    await ref.read(feedbackServiceProvider).trigger(FeedbackType.success);

    // Parse invite data
    final inviteData = qrScanService.parseInviteLink(data);
    if (inviteData == null || !mounted) {
      setState(() {
        _hasScanned = false;
      });
      await qrScanService.startScanning();
      return;
    }

    // Return invite data to caller
    Navigator.pop(context, inviteData);
  }

  Future<void> _toggleFlash() async {
    if (_controller == null) return;

    await _controller!.toggleFlash();
    final flashStatus = await _controller!.getFlashStatus();

    setState(() {
      _flashOn = flashStatus ?? false;
    });

    await ref.read(feedbackServiceProvider).trigger(FeedbackType.lightTap);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Camera preview
          QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
            overlay: QrScannerOverlayShape(
              borderColor: theme.colorScheme.primary,
              borderRadius: 16,
              borderLength: 40,
              borderWidth: 8,
              cutOutSize: MediaQuery.of(context).size.width * 0.7,
            ),
          ),

          // Top bar with back button
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      ref.read(feedbackServiceProvider).trigger(
                            FeedbackType.lightTap,
                          );
                      Navigator.pop(context);
                    },
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Spacer(),
                  // Flash toggle
                  IconButton(
                    onPressed: _toggleFlash,
                    icon: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _flashOn ? Icons.flash_on : Icons.flash_off,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom instruction text
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.black.withOpacity(0.8),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.qr_code_scanner,
                    size: 48,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Scan Project Invite',
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Position the QR code within the frame',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
