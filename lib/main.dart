// lib/main.dart

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/app_theme.dart';
import 'core/supabase_config.dart';
import 'ui/screens/dashboard_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables from .env
  try {
    await dotenv.load(fileName: '.env');
  } catch (_) {
    // Fallback jika file .env belum ada / environment test
  }

  // Edge-to-edge transparent system bars
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.bgGradientEnd,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );

  try {
    if (SupabaseConfig.isConfigured) {
      await Supabase.initialize(
        url: SupabaseConfig.supabaseUrl,
        // ignore: deprecated_member_use
        anonKey: SupabaseConfig.supabaseAnonKey,
      );
    }
  } catch (e) {
    // Graceful fallback jika network/offline saat startup
    // ignore: avoid_print
    print('Supabase init error: $e');
  }

  runApp(const ProviderScope(child: IoTPetFeederApp()));
}

class IoTPetFeederApp extends StatelessWidget {
  const IoTPetFeederApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'IoT Pet Feeder',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const DashboardScreen(),
    );
  }
}
