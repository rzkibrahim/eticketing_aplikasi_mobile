import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseService {
  static const String supabaseUrl = 'https://onphaqtfgljduatmuzkt.supabase.co';
  static const String supabaseAnonKey =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9ucGhhcXRmZ2xqZHVhdG11emt0Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3ODA1MjMxMDIsImV4cCI6MjA5NjA5OTEwMn0.pcm6z-PsQN-IPZIHhUsaRpR_qPLS1neM708GwW92hiQ';

  static SupabaseClient get client => Supabase.instance.client;

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
  }
}
