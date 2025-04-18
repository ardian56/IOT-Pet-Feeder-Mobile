// lib/ui/widgets/glass_card_widget.dart

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/app_theme.dart';
import '../../models/feed_log.dart';

/// Glassmorphic Card Widget displaying a FeedLog item with ClipRRect & BackdropFilter.
class GlassCardWidget extends StatelessWidget {
  final FeedLog log;
  final VoidCallback? onToggle;
  final VoidCallback? onDelete;

  const GlassCardWidget({
    super.key,
    required this.log,
    this.onToggle,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isCompleted = log.isCompleted;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
            decoration: BoxDecoration(
              color: AppColors.glassBackground,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(
                color: AppColors.glassBorder,
                width: 1.0,
              ),
            ),
            child: Row(
              children: [
                // Icon indicator & toggle
                GestureDetector(
                  onTap: onToggle,
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isCompleted
                          ? AppColors.accentGreen.withValues(alpha: 0.2)
                          : AppColors.accentOrange.withValues(alpha: 0.15),
                      border: Border.all(
                        color: isCompleted
                            ? AppColors.accentGreen.withValues(alpha: 0.6)
                            : AppColors.accentOrange.withValues(alpha: 0.5),
                        width: 1.5,
                      ),
                    ),
                    child: Icon(
                      isCompleted
                          ? Icons.check_rounded
                          : Icons.restaurant_rounded,
                      color: isCompleted
                          ? AppColors.accentGreen
                          : AppColors.accentOrange,
                      size: 22,
                    ),
                  ),
                ),
                const SizedBox(width: 14),

                // Time & Date details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            log.formattedTime,
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.2,
                              color: AppColors.textLight,
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Status Pill
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: isCompleted
                                  ? AppColors.accentGreen.withValues(alpha: 0.15)
                                  : AppColors.accentOlive.withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Text(
                              isCompleted ? 'Terlaksana' : 'Terjadwal',
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: isCompleted
                                    ? AppColors.accentGreen
                                    : AppColors.textLight,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        log.formattedDate,
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),

                // Delete action
                if (onDelete != null)
                  IconButton(
                    icon: const Icon(
                      Icons.delete_outline_rounded,
                      size: 20,
                      color: AppColors.textMuted,
                    ),
                    onPressed: onDelete,
                    tooltip: 'Hapus Jadwal',
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
