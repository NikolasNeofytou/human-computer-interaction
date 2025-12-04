enum RequestStatus { pending, accepted, rejected, sent }

class Request {
  const Request({
    required this.id,
    required this.title,
    required this.status,
    required this.createdAt,
  });

  final String id;
  final String title;
  final RequestStatus status;
  final DateTime createdAt;
}
