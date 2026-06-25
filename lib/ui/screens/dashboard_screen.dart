// lib/ui/screens/dashboard_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/app_theme.dart';
import '../../providers/feed_log_provider.dart';
import '../widgets/add_feed_bottom_sheet.dart';
import '../widgets/digital_clock_header.dart';
import '../widgets/glass_card.dart';
import '../widgets/glass_card_widget.dart';

/// Main Dashboard Screen with Earthy Glassmorphism aesthetics and offline fallback handling.
class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(feedLogProvider.notifier).loadLogs();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Listen for fallback state and show neat SnackBar
    ref.listen<FeedLogState>(feedLogProvider, (previous, next) {
      if (next.isFallback && (previous == null || !previous.isFallback)) {
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                const Icon(
                  Icons.cloud_off_rounded,
                  color: AppColors.accentOrange,
                  size: 20,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Server offline/paused. Menampilkan data lokal.',
                    style: GoogleFonts.poppins(
                      color: AppColors.textLight,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            backgroundColor: const Color(0xFF201E18),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: const BorderSide(color: AppColors.glassBorder),
            ),
            duration: const Duration(seconds: 4),
          ),
        );
      }
    });

    final logs = ref.watch(filteredFeedLogsProvider);
    final activeFilter = ref.watch(feedLogFilterProvider);

    return Scaffold(
      body: Stack(
        children: [
          // Background Gradient (Earthy Dark Olive)
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.bgGradientStart, AppColors.bgGradientEnd],
              ),
            ),
          ),

          // Ambient glowing spheres for rich glassmorphism refractions
          Positioned(
            top: -50,
            right: -30,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accentOlive.withValues(alpha: 0.35),
              ),
            ),
          ),
          Positioned(
            top: 280,
            left: -60,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accentOrange.withValues(alpha: 0.18),
              ),
            ),
          ),
          Positioned(
            bottom: 40,
            right: -40,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.accentGreen.withValues(alpha: 0.2),
              ),
            ),
          ),

          // Main Content
          SafeArea(
            child: RefreshIndicator(
              color: AppColors.accentGreen,
              backgroundColor: const Color(0xFF201E18),
              onRefresh: () => ref.read(feedLogProvider.notifier).loadLogs(),
              child: CustomScrollView(
                physics: const AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
                slivers: [
                  // App Bar / Spacing
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
                    sliver: SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Digital Clock Header
                          const DigitalClockHeader(),
                          const SizedBox(height: 24),

                          // Section Title & Filter Chips
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Jadwal Pemberian Pakan',
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textLight,
                                ),
                              ),
                              Text(
                                '${logs.length} Log',
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: AppColors.accentGreen,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),

                          // Filter Chips (Visual Chips per PRD)
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                _buildFilterChip(
                                  label: 'Semua',
                                  filter: FeedLogFilter.all,
                                  isSelected: activeFilter == FeedLogFilter.all,
                                ),
                                const SizedBox(width: 8),
                                _buildFilterChip(
                                  label: 'Hari Ini',
                                  filter: FeedLogFilter.today,
                                  isSelected:
                                      activeFilter == FeedLogFilter.today,
                                ),
                                const SizedBox(width: 8),
                                _buildFilterChip(
                                  label: 'Terjadwal',
                                  filter: FeedLogFilter.upcoming,
                                  isSelected:
                                      activeFilter == FeedLogFilter.upcoming,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Feed Log List or Empty State
                  if (logs.isEmpty)
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      sliver: SliverToBoxAdapter(
                        child: GlassCard(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 24,
                            vertical: 36,
                          ),
                          child: Column(
                            children: [
                              Icon(
                                Icons.event_busy_rounded,
                                size: 48,
                                color: AppColors.textMuted.withValues(
                                  alpha: 0.7,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Belum Ada Jadwal',
                                style: GoogleFonts.poppins(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.textLight,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Tekan tombol di bawah untuk menambah jadwal baru.',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  color: AppColors.textMuted,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  else
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 90),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          final log = logs[index];
                          return GlassCardWidget(
                            log: log,
                            onToggle: () {
                              ref
                                  .read(feedLogProvider.notifier)
                                  .toggleStatus(log.id);
                            },
                            onDelete: () {
                              ref
                                  .read(feedLogProvider.notifier)
                                  .deleteFeedLog(log.id);
                            },
                          );
                        }, childCount: logs.length),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),

      // Pill-shaped Floating Action Button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SizedBox(
          width: double.infinity,
          height: 54,
          child: ElevatedButton.icon(
            onPressed: () => AddFeedBottomSheet.show(context),
            icon: const Icon(Icons.add_alarm_rounded, size: 20),
            label: Text(
              'Tambah Jadwal Pakan',
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accentGreen,
              foregroundColor: const Color(0xFF14130E),
              elevation: 8,
              shadowColor: AppColors.accentGreen.withValues(alpha: 0.5),
              shape: const StadiumBorder(),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required FeedLogFilter filter,
    required bool isSelected,
  }) {
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) {
        ref.read(feedLogFilterProvider.notifier).setFilter(filter);
      },
      selectedColor: AppColors.accentGreen,
      backgroundColor: AppColors.glassBackground,
      labelStyle: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
        color: isSelected ? const Color(0xFF14130E) : AppColors.textLight,
      ),
      side: BorderSide(
        color: isSelected ? AppColors.accentGreen : AppColors.glassBorder,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    );
  }
}
