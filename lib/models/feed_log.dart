// lib/models/feed_log.dart

import 'package:intl/intl.dart';

/// Model representing a feeding schedule/log in `feed_logs` table.
class FeedLog {
  final String id;
  final String tanggal; // Format: YYYY-MM-DD
  final String jam; // Format: HH:mm or HH:mm:ss
  final DateTime? createdAt;
  final bool isCompleted;

  const FeedLog({
    required this.id,
    required this.tanggal,
    required this.jam,
    this.createdAt,
    this.isCompleted = false,
  });

  /// Parse feed log from Supabase JSON response
  factory FeedLog.fromJson(Map<String, dynamic> json) {
    return FeedLog(
      id: json['id']?.toString() ?? '',
      tanggal: json['tanggal']?.toString() ?? '',
      jam: json['jam']?.toString() ?? '',
      createdAt: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'].toString())
          : null,
      isCompleted: json['is_completed'] as bool? ?? false,
    );
  }

  /// Serialize to Supabase table schema
  Map<String, dynamic> toJson() {
    return {
      if (id.isNotEmpty) 'id': id,
      'tanggal': tanggal,
      'jam': jam,
      if (createdAt != null) 'created_at': createdAt!.toIso8601String(),
    };
  }

  /// Formatted date string for UI display (e.g. "Senin, 09 Sep 2026")
  String get formattedDate {
    try {
      final parsed = DateTime.parse(tanggal);
      return DateFormat('EEEE, d MMM yyyy').format(parsed);
    } catch (_) {
      return tanggal;
    }
  }

  /// Formatted time string for UI display (e.g. "07:30 WIB")
  String get formattedTime {
    if (jam.length >= 5) {
      return jam.substring(0, 5);
    }
    return jam;
  }

  FeedLog copyWith({
    String? id,
    String? tanggal,
    String? jam,
    DateTime? createdAt,
    bool? isCompleted,
  }) {
    return FeedLog(
      id: id ?? this.id,
      tanggal: tanggal ?? this.tanggal,
      jam: jam ?? this.jam,
      createdAt: createdAt ?? this.createdAt,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
