class CommentModel {
  final String id;
  final String ticketId;
  final String authorId;
  final String authorName;
  final String authorRole;
  final String content;
  final DateTime createdAt;

  CommentModel({
    required this.id,
    required this.ticketId,
    required this.authorId,
    required this.authorName,
    required this.authorRole,
    required this.content,
    required this.createdAt,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'] ?? '',
      ticketId: json['ticket_id'] ?? '',
      authorId: json['author_id'] ?? '',
      authorName: json['author_name'] ?? '',
      authorRole: json['author_role'] ?? '',
      content: json['content'] ?? '',
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ticket_id': ticketId,
      'author_id': authorId,
      'author_name': authorName,
      'author_role': authorRole,
      'content': content,
    };
  }
}

class TicketHistoryModel {
  final String id;
  final String ticketId;
  final String action;
  final String performedBy;
  final String performedByRole;
  final DateTime timestamp;

  TicketHistoryModel({
    required this.id,
    required this.ticketId,
    required this.action,
    required this.performedBy,
    required this.performedByRole,
    required this.timestamp,
  });

  factory TicketHistoryModel.fromJson(Map<String, dynamic> json) {
    return TicketHistoryModel(
      id: json['id'] ?? '',
      ticketId: json['ticket_id'] ?? '',
      action: json['action'] ?? '',
      performedBy: json['performed_by'] ?? '',
      performedByRole: json['performed_by_role'] ?? '',
      timestamp: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ticket_id': ticketId,
      'action': action,
      'performed_by': performedBy,
      'performed_by_role': performedByRole,
    };
  }
}

class TicketModel {
  final String id;
  final String title;
  final String description;
  final String category;
  final String priority; // low, medium, high
  final String status; // open, in progress, closed
  final String createdById;
  final String createdByName;
  final String? assignedToId;
  final String? assignedToName;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? attachmentUrl;
  final List<String> attachments;
  final List<CommentModel> comments;
  final List<TicketHistoryModel> history;

  TicketModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.priority,
    required this.status,
    required this.createdById,
    required this.createdByName,
    this.assignedToId,
    this.assignedToName,
    required this.createdAt,
    required this.updatedAt,
    this.attachmentUrl,
    this.attachments = const [],
    this.comments = const [],
    this.history = const [],
  });

  factory TicketModel.fromJson(Map<String, dynamic> json, {
    List<CommentModel> comments = const [],
    List<TicketHistoryModel> history = const [],
  }) {
    return TicketModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      priority: json['priority'] ?? 'medium',
      status: json['status'] ?? 'open',
      createdById: json['created_by_id'] ?? '',
      createdByName: json['created_by_name'] ?? '',
      assignedToId: json['assigned_to_id'],
      assignedToName: json['assigned_to_name'],
      createdAt: DateTime.parse(json['created_at'] ?? DateTime.now().toIso8601String()),
      updatedAt: DateTime.parse(json['updated_at'] ?? DateTime.now().toIso8601String()),
      attachmentUrl: json['attachment_url'],
      comments: comments,
      history: history,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'priority': priority,
      'status': status,
      'created_by_id': createdById,
      'created_by_name': createdByName,
      'assigned_to_id': assignedToId,
      'assigned_to_name': assignedToName,
      'updated_at': DateTime.now().toIso8601String(),
    };
  }

  TicketModel copyWith({
    String? title,
    String? description,
    String? category,
    String? priority,
    String? status,
    String? assignedToId,
    String? assignedToName,
    DateTime? updatedAt,
    String? attachmentUrl,
    List<String>? attachments,
    List<CommentModel>? comments,
    List<TicketHistoryModel>? history,
  }) {
    return TicketModel(
      id: id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      createdById: createdById,
      createdByName: createdByName,
      assignedToId: assignedToId ?? this.assignedToId,
      assignedToName: assignedToName ?? this.assignedToName,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      attachmentUrl: attachmentUrl ?? this.attachmentUrl,
      attachments: attachments ?? this.attachments,
      comments: comments ?? this.comments,
      history: history ?? this.history,
    );
  }
}
