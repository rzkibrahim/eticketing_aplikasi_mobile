class NotificationModel {
  final String id;
  final String title;
  final String body;
  final String ticketId;
  final String type; // status_update, new_comment, assigned, resolved
  bool isRead;
  final String? userId;
  final DateTime createdAt;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.ticketId,
    required this.type,
    this.isRead = false,
    this.userId,
    required this.createdAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      ticketId: json['ticket_id'] ?? '',
      type: json['type'] ?? '',
      isRead: json['is_read'] ?? false,
      userId: json['user_id'],
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'body': body,
      'ticket_id': ticketId,
      'type': type,
      'is_read': isRead,
      'user_id': userId,
    };
  }
}
