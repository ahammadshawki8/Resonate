import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../data/models/models.dart';

class EntryDetailScreen extends ConsumerWidget {
  final VoiceEntry entry;

  const EntryDetailScreen({super.key, required this.entry});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final moodColor = AppColors.getMoodColor(entry.finalMoodScore);

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
          ),
          onPressed: () => context.pop(),
        ),
        title: Text(
          _formatDate(entry.recordedAt),
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.bold,
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mood Score Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    moodColor.withOpacity(0.8),
                    moodColor,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24.r),
                boxShadow: [
                  BoxShadow(
                    color: moodColor.withOpacity(0.4),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Text(
                    _getMoodEmoji(entry.finalMoodScore),
                    style: TextStyle(fontSize: 64.sp),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    _getMoodLabel(entry.finalMoodScore),
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    'Mood Score: ${entry.finalMoodScore.toStringAsFixed(1)}',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    _formatTime(entry.recordedAt),
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn().scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1)),

            SizedBox(height: 24.h),

            // Transcript Section
            _buildSection(
              title: '📝 What You Said',
              isDark: isDark,
              child: Text(
                (entry.transcript?.isNotEmpty == true) ? entry.transcript! : 'No transcript available',
                style: TextStyle(
                  fontSize: 15.sp,
                  height: 1.6,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                ),
              ),
            ).animate().fadeIn(delay: 100.ms).slideY(begin: 0.1, end: 0),

            SizedBox(height: 16.h),

            // Emotions Detected
            if (entry.detectedEmotions.isNotEmpty)
              _buildSection(
                title: '💭 Emotions Detected',
                isDark: isDark,
                child: Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: entry.detectedEmotions.map((emotion) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: moodColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(color: moodColor.withOpacity(0.3)),
                      ),
                      child: Text(
                        emotion,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: moodColor,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ).animate().fadeIn(delay: 200.ms).slideY(begin: 0.1, end: 0),

            SizedBox(height: 16.h),

            // Tags
            if (entry.tags.isNotEmpty)
              _buildSection(
                title: '🏷️ Tags',
                isDark: isDark,
                child: Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: entry.tags.map((tag) {
                    return Container(
                      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.cardDark : AppColors.surface,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Text(
                        '#${tag.name}',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1, end: 0),

            SizedBox(height: 16.h),

            // Entry Details
            _buildSection(
              title: '📊 Entry Details',
              isDark: isDark,
              child: Column(
                children: [
                  _buildDetailRow('Duration', '${entry.durationSeconds.round()} seconds', isDark),
                  _buildDetailRow('Language', entry.language == 'en' ? 'English' : 'Bengali', isDark),
                  _buildDetailRow('Confidence', '${(entry.confidence * 100).round()}%', isDark),
                  _buildDetailRow('Acoustic Score', entry.acousticMoodScore.toStringAsFixed(1), isDark),
                  if (entry.semanticMoodScore != null)
                    _buildDetailRow('Semantic Score', entry.semanticMoodScore!.toStringAsFixed(1), isDark),
                ],
              ),
            ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1, end: 0),

            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSection({
    required String title,
    required bool isDark,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 12.h),
          child,
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, bool isDark) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  String _getMoodEmoji(double score) {
    if (score >= 0.7) return '😊';
    if (score >= 0.5) return '🙂';
    if (score >= 0.3) return '😐';
    if (score >= 0.1) return '😔';
    return '😢';
  }

  String _getMoodLabel(double score) {
    if (score >= 0.7) return 'Feeling Great!';
    if (score >= 0.5) return 'Feeling Good';
    if (score >= 0.3) return 'Feeling Okay';
    if (score >= 0.1) return 'Feeling Low';
    return 'Feeling Down';
  }

  String _formatDate(DateTime date) {
    final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return '${weekdays[date.weekday - 1]}, ${months[date.month - 1]} ${date.day}, ${date.year}';
  }

  String _formatTime(DateTime date) {
    final hour = date.hour > 12 ? date.hour - 12 : (date.hour == 0 ? 12 : date.hour);
    final period = date.hour >= 12 ? 'PM' : 'AM';
    return '$hour:${date.minute.toString().padLeft(2, '0')} $period';
  }
}
