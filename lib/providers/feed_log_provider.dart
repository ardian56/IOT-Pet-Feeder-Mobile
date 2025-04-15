// lib/providers/feed_log_provider.dart

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../models/feed_log.dart';
import '../repositories/log_repository.dart';

/// Filter options for feed log list
enum FeedLogFilter { all, today, upcoming }

/// Repository provider
final logRepositoryProvider = Provider<LogRepository>((ref) {
  return LogRepository();
});
final feedLogRepositoryProvider = logRepositoryProvider;

/// 5 Initial dummy data FeedLog (April 2025)
final List<FeedLog> initialDummyFeedLogs = [
  FeedLog(
    id: 'dummy-1',
    tanggal: '2025-04-10',
    jam: '07:00',
    isCompleted: true,
  ),
  FeedLog(
    id: 'dummy-2',
    tanggal: '2025-04-15',
    jam: '12:30',
    isCompleted: true,
  ),
  FeedLog(
    id: 'dummy-3',
    tanggal: '2025-04-20',
    jam: '18:00',
    isCompleted: true,
  ),
  FeedLog(
    id: 'dummy-4',
    tanggal: '2025-04-25',
    jam: '07:30',
    isCompleted: false,
  ),
  FeedLog(
    id: 'dummy-5',
    tanggal: '2025-04-28',
    jam: '19:00',
    isCompleted: false,
  ),
];

/// State holding feed logs and fallback indicator
class FeedLogState {
  final List<FeedLog> logs;
  final bool isFallback;

  const FeedLogState({
    required this.logs,
    this.isFallback = false,
  });

  FeedLogState copyWith({
    List<FeedLog>? logs,
    bool? isFallback,
  }) {
    return FeedLogState(
      logs: logs ?? this.logs,
      isFallback: isFallback ?? this.isFallback,
    );
  }
}

/// Notifier to manage FeedLog list reactively
class FeedLogNotifier extends Notifier<FeedLogState> {
  LogRepository get _repository => ref.read(logRepositoryProvider);

  @override
  FeedLogState build() {
    return FeedLogState(
      logs: initialDummyFeedLogs,
      isFallback: false,
    );
  }

  /// Load logs from Supabase or fallback to dummy
  Future<void> loadLogs() async {
    final fetched = await _repository.getLogs();
    state = FeedLogState(
      logs: fetched,
      isFallback: _repository.isFallback,
    );
  }

  /// Add new feed log
  Future<void> addFeedLog({required String tanggal, required String jam}) async {
    final newLog = await _repository.addLog(tanggal, jam);
    state = FeedLogState(
      logs: [newLog, ...state.logs.where((l) => l.id != newLog.id)],
      isFallback: _repository.isFallback,
    );
  }

  /// Delete feed log
  Future<void> deleteFeedLog(String id) async {
    state = state.copyWith(
      logs: state.logs.where((log) => log.id != id).toList(),
    );
    await _repository.deleteLog(id);
  }

  /// Toggle completed status
  void toggleStatus(String id) {
    state = state.copyWith(
      logs: state.logs.map((log) {
        if (log.id == id) {
          return log.copyWith(isCompleted: !log.isCompleted);
        }
        return log;
      }).toList(),
    );
  }
}

/// Provider for FeedLogNotifier
final feedLogProvider =
    NotifierProvider<FeedLogNotifier, FeedLogState>(FeedLogNotifier.new);

/// Filter selection Notifier
class FeedLogFilterNotifier extends Notifier<FeedLogFilter> {
  @override
  FeedLogFilter build() => FeedLogFilter.all;

  void setFilter(FeedLogFilter filter) {
    state = filter;
  }
}

/// Filter selection provider
final feedLogFilterProvider =
    NotifierProvider<FeedLogFilterNotifier, FeedLogFilter>(
  FeedLogFilterNotifier.new,
);

/// Filtered logs provider based on selected chip filter
final filteredFeedLogsProvider = Provider<List<FeedLog>>((ref) {
  final feedState = ref.watch(feedLogProvider);
  final logs = feedState.logs;
  final filter = ref.watch(feedLogFilterProvider);
  final todayStr = DateFormat('yyyy-MM-dd').format(DateTime.now());

  switch (filter) {
    case FeedLogFilter.today:
      return logs.where((log) => log.tanggal == todayStr).toList();
    case FeedLogFilter.upcoming:
      return logs.where((log) => !log.isCompleted).toList();
    case FeedLogFilter.all:
      return logs;
  }
});
