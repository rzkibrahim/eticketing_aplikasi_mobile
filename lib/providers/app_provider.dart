import 'dart:io';
import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../models/ticket_model.dart';
import '../models/notification_model.dart';
import '../services/supabase_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AppProvider extends ChangeNotifier {
  UserModel? _currentUser;
  List<TicketModel> _tickets = [];
  List<UserModel> _users = [];
  List<NotificationModel> _notifications = [];
  bool _isDarkMode = false;
  bool _isLoading = false;
  String? _error;

  UserModel? get currentUser => _currentUser;
  List<TicketModel> get tickets => _tickets;
  List<UserModel> get users => _users;
  List<NotificationModel> get notifications => _notifications;
  bool get isDarkMode => _isDarkMode;
  bool get isLoading => _isLoading;
  String? get error => _error;

  final _client = SupabaseService.client;

  // ============================================================
  // INITIALIZATION — Load all data from Supabase
  // ============================================================
  Future<void> loadData() async {
    _isLoading = true;
    notifyListeners();
    try {
      await Future.wait([
        _loadUsers(),
        _loadTickets(),
        _loadNotifications(),
      ]);
      _error = null;
    } catch (e) {
      _error = e.toString();
      debugPrint('Error loading data: $e');
    }
    _isLoading = false;
    notifyListeners();
  }

  Future<void> _loadUsers() async {
    final data = await _client.from('users').select().order('created_at');
    _users = data.map<UserModel>((json) => UserModel.fromJson(json)).toList();
  }

  Future<void> _loadTickets() async {
    final ticketData = await _client.from('tickets').select().order('created_at', ascending: false);
    final commentData = await _client.from('comments').select().order('created_at');
    final historyData = await _client.from('ticket_history').select().order('created_at');

    _tickets = ticketData.map<TicketModel>((json) {
      final ticketId = json['id'];
      final comments = commentData
          .where((c) => c['ticket_id'] == ticketId)
          .map<CommentModel>((c) => CommentModel.fromJson(c))
          .toList();
      final history = historyData
          .where((h) => h['ticket_id'] == ticketId)
          .map<TicketHistoryModel>((h) => TicketHistoryModel.fromJson(h))
          .toList();
      return TicketModel.fromJson(json, comments: comments, history: history);
    }).toList();
  }

  Future<void> _loadNotifications() async {
    final data = await _client.from('notifications').select().order('created_at', ascending: false);
    _notifications = data.map<NotificationModel>((json) => NotificationModel.fromJson(json)).toList();
  }

  // ============================================================
  // Filtered notifications for current user
  // ============================================================
  List<NotificationModel> get userNotifications {
    if (_currentUser == null) return [];
    if (_currentUser!.role != 'user') return _notifications;
    return _notifications.where((n) => n.userId == _currentUser!.id).toList();
  }

  int get unreadCount => userNotifications.where((n) => !n.isRead).length;

  // ============================================================
  // AUTH
  // ============================================================
  Future<bool> login(String username, String password) async {
    _error = null;
    try {
      final data = await _client
          .from('users')
          .select()
          .eq('username', username)
          .eq('password', password)
          .maybeSingle();

      if (data != null) {
        final user = UserModel.fromJson(data);
        if (!user.isActive) {
          _error = 'Akun Anda telah dinonaktifkan. Hubungi admin.';
          return false;
        }
        _currentUser = user;
        await loadData();
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Login error: $e');
      return false;
    }
  }

  void logout() {
    _currentUser = null;
    _tickets = [];
    _notifications = [];
    notifyListeners();
  }

  Future<bool> register(String name, String email, String username, String password, String department, String phone) async {
    try {
      // Check if username or email already exists
      final existing = await _client
          .from('users')
          .select('id')
          .or('username.eq.$username,email.eq.$email');

      if (existing.isNotEmpty) return false;

      await _client.from('users').insert({
        'name': name,
        'email': email,
        'username': username,
        'password': password,
        'role': 'user',
        'department': department,
        'avatar': name.substring(0, 2).toUpperCase(),
        'phone': phone,
      });

      await _loadUsers();
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Register error: $e');
      return false;
    }
  }

  Future<bool> resetPassword(String name, String email, String newPassword) async {
    try {
      final data = await _client
          .from('users')
          .select('id')
          .eq('email', email)
          .eq('name', name)
          .maybeSingle();

      if (data == null) return false;

      await _client
          .from('users')
          .update({'password': newPassword})
          .eq('email', email);

      await _loadUsers();
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Reset password error: $e');
      return false;
    }
  }

  Future<void> updateProfile(String name, String email, String phone, String department) async {
    if (_currentUser == null) return;
    try {
      await _client.from('users').update({
        'name': name,
        'email': email,
        'phone': phone,
        'department': department,
        'avatar': name.substring(0, 2).toUpperCase(),
      }).eq('id', _currentUser!.id);

      await _loadUsers();
      _currentUser = _users.firstWhere((u) => u.id == _currentUser!.id);
      notifyListeners();
    } catch (e) {
      debugPrint('Update profile error: $e');
    }
  }

  Future<void> toggleUserActive(String userId) async {
    try {
      final user = _users.firstWhere((u) => u.id == userId);
      final newStatus = !user.isActive;
      await _client.from('users').update({
        'is_active': newStatus,
      }).eq('id', userId);

      await _loadUsers();
      notifyListeners();
    } catch (e) {
      debugPrint('Toggle user active error: $e');
    }
  }

  // ============================================================
  // TICKETS
  // ============================================================
  List<TicketModel> get userTickets {
    if (_currentUser == null) return [];
    if (_currentUser!.role == 'user') {
      return _tickets.where((t) => t.createdById == _currentUser!.id).toList();
    }
    if (_currentUser!.role == 'helpdesk') {
      return _tickets.where((t) => t.assignedToId == _currentUser!.id).toList();
    }
    return _tickets;
  }

  // Helpdesk: all assigned tickets
  List<TicketModel> get helpdeskAssignedTickets {
    if (_currentUser == null || _currentUser!.role != 'helpdesk') return [];
    return _tickets.where((t) => t.assignedToId == _currentUser!.id).toList();
  }

  // Admin: filter tickets by helpdesk
  List<TicketModel> getTicketsByHelpdesk(String helpdeskId) {
    return _tickets.where((t) => t.assignedToId == helpdeskId).toList();
  }

  TicketModel? getTicketById(String id) {
    try {
      return _tickets.firstWhere((t) => t.id == id);
    } catch (_) {
      return null;
    }
  }

  Future<String?> uploadFile(File file, String ticketId) async {
    try {
      final fileName = '${ticketId}_${DateTime.now().millisecondsSinceEpoch}.${file.path.split('.').last}';
      final bytes = await file.readAsBytes();
      await _client.storage.from('ticket-attachments').uploadBinary(
        fileName,
        bytes,
        fileOptions: FileOptions(cacheControl: '3600', upsert: false),
      );
      final url = _client.storage.from('ticket-attachments').getPublicUrl(fileName);
      return url;
    } catch (e) {
      debugPrint('Upload file error: $e');
      return null;
    }
  }

  Future<void> createTicket({
    required String title,
    required String description,
    required String category,
    required String priority,
    File? attachment,
  }) async {
    if (_currentUser == null) return;
    try {
      // Generate ticket ID
      final countData = await _client.from('tickets').select('id');
      final ticketNumber = countData.length + 1;
      final id = 'TKT-${ticketNumber.toString().padLeft(3, '0')}';

      // Upload attachment if provided
      String? attachmentUrl;
      if (attachment != null) {
        attachmentUrl = await uploadFile(attachment, id);
      }

      final insertData = <String, dynamic>{
        'id': id,
        'title': title,
        'description': description,
        'category': category,
        'priority': priority,
        'status': 'open',
        'created_by_id': _currentUser!.id,
        'created_by_name': _currentUser!.name,
      };
      if (attachmentUrl != null) {
        insertData['attachment_url'] = attachmentUrl;
      }

      await _client.from('tickets').insert(insertData);

      // Add history
      await _client.from('ticket_history').insert({
        'ticket_id': id,
        'action': 'Tiket dibuat',
        'performed_by': _currentUser!.name,
        'performed_by_role': _currentUser!.role,
      });

      // Add notification
      await _addNotification(
        title: 'Tiket baru dibuat',
        body: 'Tiket "$title" berhasil dibuat',
        ticketId: id,
        type: 'new_ticket',
      );

      await _loadTickets();
      await _loadNotifications();
      notifyListeners();
    } catch (e) {
      debugPrint('Create ticket error: $e');
    }
  }

  Future<void> updateTicketStatus(String ticketId, String newStatus) async {
    try {
      await _client.from('tickets').update({
        'status': newStatus,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('id', ticketId);

      await _client.from('ticket_history').insert({
        'ticket_id': ticketId,
        'action': 'Status diubah menjadi ${_statusLabel(newStatus)}',
        'performed_by': _currentUser?.name ?? 'System',
        'performed_by_role': _currentUser?.role ?? 'system',
      });

      final ticket = getTicketById(ticketId);
      await _addNotification(
        title: 'Status tiket diperbarui',
        body: 'Status "${ticket?.title}" diubah menjadi ${_statusLabel(newStatus)}',
        ticketId: ticketId,
        type: 'status_update',
      );

      await _loadTickets();
      await _loadNotifications();
      notifyListeners();
    } catch (e) {
      debugPrint('Update ticket status error: $e');
    }
  }

  Future<void> closeTicket(String ticketId) async {
    try {
      await _client.from('tickets').update({
        'status': 'closed',
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('id', ticketId);

      await _client.from('ticket_history').insert({
        'ticket_id': ticketId,
        'action': 'Tiket diselesaikan dan ditutup',
        'performed_by': _currentUser?.name ?? 'Helpdesk',
        'performed_by_role': _currentUser?.role ?? 'helpdesk',
      });

      final ticket = getTicketById(ticketId);
      await _addNotification(
        title: 'Tiket selesai',
        body: 'Tiket "${ticket?.title}" telah diselesaikan',
        ticketId: ticketId,
        type: 'status_update',
      );

      await _loadTickets();
      await _loadNotifications();
      notifyListeners();
    } catch (e) {
      debugPrint('Close ticket error: $e');
    }
  }

  Future<void> assignTicket(String ticketId, String helpdeskId) async {
    try {
      final helpdesk = _users.firstWhere((u) => u.id == helpdeskId);

      await _client.from('tickets').update({
        'assigned_to_id': helpdeskId,
        'assigned_to_name': helpdesk.name,
        'status': 'in progress',
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('id', ticketId);

      await _client.from('ticket_history').insert({
        'ticket_id': ticketId,
        'action': 'Tiket di-assign ke ${helpdesk.name}',
        'performed_by': _currentUser?.name ?? 'Admin',
        'performed_by_role': _currentUser?.role ?? 'admin',
      });

      await _loadTickets();
      notifyListeners();
    } catch (e) {
      debugPrint('Assign ticket error: $e');
    }
  }

  Future<void> updateTicket({
    required String ticketId,
    required String title,
    required String description,
    required String category,
    required String priority,
  }) async {
    try {
      await _client.from('tickets').update({
        'title': title,
        'description': description,
        'category': category,
        'priority': priority,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('id', ticketId);

      await _client.from('ticket_history').insert({
        'ticket_id': ticketId,
        'action': 'Tiket diperbarui',
        'performed_by': _currentUser?.name ?? 'User',
        'performed_by_role': _currentUser?.role ?? 'user',
      });

      await _loadTickets();
      notifyListeners();
    } catch (e) {
      debugPrint('Update ticket error: $e');
    }
  }

  Future<void> deleteTicket(String ticketId) async {
    try {
      // Delete related data first (comments, history, notifications)
      await _client.from('notifications').delete().eq('ticket_id', ticketId);
      await _client.from('comments').delete().eq('ticket_id', ticketId);
      await _client.from('ticket_history').delete().eq('ticket_id', ticketId);
      await _client.from('tickets').delete().eq('id', ticketId);

      _tickets.removeWhere((t) => t.id == ticketId);
      _notifications.removeWhere((n) => n.ticketId == ticketId);
      notifyListeners();
    } catch (e) {
      debugPrint('Delete ticket error: $e');
    }
  }

  Future<void> addComment(String ticketId, String content) async {
    if (_currentUser == null) return;
    try {
      await _client.from('comments').insert({
        'ticket_id': ticketId,
        'author_id': _currentUser!.id,
        'author_name': _currentUser!.name,
        'author_role': _currentUser!.role,
        'content': content,
      });

      await _client.from('ticket_history').insert({
        'ticket_id': ticketId,
        'action': 'Komentar ditambahkan oleh ${_currentUser!.name}',
        'performed_by': _currentUser!.name,
        'performed_by_role': _currentUser!.role,
      });

      await _client.from('tickets').update({
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('id', ticketId);

      final ticket = getTicketById(ticketId);
      await _addNotification(
        title: 'Komentar baru',
        body: '${_currentUser!.name} menambahkan komentar pada tiket "${ticket?.title}"',
        ticketId: ticketId,
        type: 'new_comment',
      );

      await _loadTickets();
      await _loadNotifications();
      notifyListeners();
    } catch (e) {
      debugPrint('Add comment error: $e');
    }
  }

  // ============================================================
  // USERS (admin only)
  // ============================================================
  Future<void> createUser({
    required String name,
    required String email,
    required String username,
    required String password,
    required String role,
    required String department,
    required String phone,
  }) async {
    try {
      await _client.from('users').insert({
        'name': name,
        'email': email,
        'username': username,
        'password': password,
        'role': role,
        'department': department,
        'avatar': name.substring(0, 2).toUpperCase(),
        'phone': phone,
      });

      await _loadUsers();
      notifyListeners();
    } catch (e) {
      debugPrint('Create user error: $e');
    }
  }

  Future<void> deleteUser(String userId) async {
    try {
      await _client.from('users').delete().eq('id', userId);
      _users.removeWhere((u) => u.id == userId);
      notifyListeners();
    } catch (e) {
      debugPrint('Delete user error: $e');
    }
  }

  // ============================================================
  // NOTIFICATIONS
  // ============================================================
  Future<void> _addNotification({
    required String title,
    required String body,
    required String ticketId,
    required String type,
  }) async {
    try {
      // Add notification for all admins and helpdesk users
      final targetUsers = _users.where((u) => u.role != 'user').toList();
      // Also add for the ticket creator
      final ticket = _tickets.where((t) => t.id == ticketId).toList();
      if (ticket.isNotEmpty) {
        final creatorId = ticket.first.createdById;
        if (!targetUsers.any((u) => u.id == creatorId)) {
          final creator = _users.where((u) => u.id == creatorId).toList();
          if (creator.isNotEmpty) targetUsers.add(creator.first);
        }
      }

      for (final user in targetUsers) {
        await _client.from('notifications').insert({
          'title': title,
          'body': body,
          'ticket_id': ticketId,
          'type': type,
          'user_id': user.id,
        });
      }
    } catch (e) {
      debugPrint('Add notification error: $e');
    }
  }

  Future<void> markNotificationRead(String id) async {
    try {
      await _client.from('notifications').update({'is_read': true}).eq('id', id);
      final idx = _notifications.indexWhere((n) => n.id == id);
      if (idx != -1) {
        _notifications[idx].isRead = true;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Mark notification read error: $e');
    }
  }

  Future<void> markAllRead() async {
    try {
      if (_currentUser == null) return;
      await _client
          .from('notifications')
          .update({'is_read': true})
          .eq('user_id', _currentUser!.id);

      for (var n in userNotifications) {
        n.isRead = true;
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Mark all read error: $e');
    }
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }

  String _statusLabel(String status) {
    switch (status) {
      case 'open': return 'Open';
      case 'in progress': return 'In Progress';
      case 'closed': return 'Closed';
      default: return status;
    }
  }

  // Stats
  Map<String, int> get ticketStats {
    final relevant = _currentUser?.role == 'helpdesk'
        ? helpdeskAssignedTickets
        : _currentUser?.role == 'user'
            ? userTickets
            : _tickets;
    return {
      'total': relevant.length,
      'open': relevant.where((t) => t.status == 'open').length,
      'in_progress': relevant.where((t) => t.status == 'in progress').length,
      'closed': relevant.where((t) => t.status == 'closed').length,
    };
  }

  // Global stats for admin (always all tickets)
  Map<String, int> get globalTicketStats {
    return {
      'total': _tickets.length,
      'open': _tickets.where((t) => t.status == 'open').length,
      'in_progress': _tickets.where((t) => t.status == 'in progress').length,
      'closed': _tickets.where((t) => t.status == 'closed').length,
    };
  }

  List<UserModel> get helpdeskUsers =>
      _users.where((u) => u.role == 'helpdesk').toList();
}
