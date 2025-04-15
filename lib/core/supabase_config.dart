// lib/core/supabase_config.dart

import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Configuration for Supabase loaded from environment variables (.env / --dart-define).
class SupabaseConfig {
  static String get supabaseUrl =>
      dotenv.env['SUPABASE_URL'] ??
      const String.fromEnvironment(
        'SUPABASE_URL',
        defaultValue: 'https://bnohnwaewyhlctftcpqz.supabase.co',
      );

  static String get supabaseAnonKey =>
      dotenv.env['SUPABASE_ANON_KEY'] ??
      const String.fromEnvironment(
        'SUPABASE_ANON_KEY',
        defaultValue:
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJub2hud2Fld3lobGN0ZnRjcHF6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzM5NzExMTIsImV4cCI6MjA0OTU0NzExMn0.gnElfIw4eLBUFRMLWovUY1ayalD4lJiSkSSt5WtgD2I',
      );

  static bool get isConfigured =>
      supabaseUrl.isNotEmpty &&
      supabaseAnonKey.isNotEmpty &&
      supabaseUrl.startsWith('http');
}
