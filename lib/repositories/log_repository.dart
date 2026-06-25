// lib/repositories/log_repository.dart

import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/feed_log.dart';
import '../providers/feed_log_provider.dart' show initialDummyFeedLogs;

/// Repository handling data operations on Supabase `feed_logs` with Graceful Degradation.
class LogRepository {
  bool isFallback = false;

  /// Mengambil semua log dari tabel 'feed_logs'
  Future<List<FeedLog>> getLogs() async {
    try {
      final response = await Supabase.instance.client
          .from('feed_logs')
          .select()
          .order('tanggal', ascending: false)
          .order('jam', ascending: false);

      isFallback = false;
      return (response as List)
          .map((item) => FeedLog.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      // ignore: avoid_print
      print('Error getLogs Supabase: $e');
      isFallback = true;
      return initialDummyFeedLogs;
    }
  }

  /// Menambahkan jadwal baru ke tabel 'feed_logs'
  Future<FeedLog> addLog(String tanggal, String jam) async {
    try {
      final response = await Supabase.instance.client
          .from('feed_logs')
          .insert({'tanggal': tanggal, 'jam': jam})
          .select()
          .single();

      isFallback = false;
      return FeedLog.fromJson(response);
    } catch (e) {
      // ignore: avoid_print
      print('Error addLog Supabase: $e');
      isFallback = true;
      return FeedLog(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        tanggal: tanggal,
        jam: jam,
        createdAt: DateTime.now(),
        isCompleted: false,
      );
    }
  }

  /// Menghapus log berdasarkan ID
  Future<bool> deleteLog(String id) async {
    try {
      await Supabase.instance.client.from('feed_logs').delete().eq('id', id);
      return true;
    } catch (e) {
      // ignore: avoid_print
      print('Error deleteLog Supabase: $e');
      return false;
    }
  }
}
