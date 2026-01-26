import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/shared_widgets.dart';
import '../../providers/app_providers.dart';
import '../../data/models/models.dart';

class InsightsScreen extends ConsumerWidget {
  const InsightsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final insights = ref.watch(insightsProvider);
    final unreadCount = insights.where((i) => !i.isRead).length;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Insights',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
        actions: [
          if (unreadCount > 0)
            GestureDetector(
              onTap: () {
                // Mark all as read
                for (final insight in insights) {
                  ref.read(insightsProvider.notifier).markAsRead(insight.id);
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('All insights marked as read'),
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                  ),
                );
              },
              child: Container(
                margin: EdgeInsets.only(right: 16.w),
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  '$unreadCount new',
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
      body: insights.isEmpty
          ? EmptyState(
              title: 'No Insights Yet',
              subtitle: 'Keep checking in and we will provide personalized insights based on your patterns.',
              icon: Icons.lightbulb_outline,
            )
          : ListView.builder(
              padding: EdgeInsets.all(20.w),
              itemCount: insights.length,
              itemBuilder: (context, index) {
                final insight = insights[index];
                return Padding(
                  padding: EdgeInsets.only(bottom: 16.h),
                  child: InsightCard(
                    insightText: insight.insightText,
                    insightType: insight.insightType,
                    generatedAt: insight.generatedAt,
                    isRead: insight.isRead,
                    onTap: () {
                      // Mark as read and show detail
                      ref.read(insightsProvider.notifier).markAsRead(insight.id);
                      _showInsightDetail(context, insight);
                    },
                  ).animate().fadeIn(delay: (index * 100).ms).slideY(begin: 0.1, end: 0),
                );
              },
            ),
    );
  }

  void _showInsightDetail(BuildContext context, Insight insight) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        margin: EdgeInsets.all(16.w),
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.divider,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 24.h),
            // Icon
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Icon(
                Icons.lightbulb_outline,
                color: AppColors.primary,
                size: 32.sp,
              ),
            ),
            SizedBox(height: 20.h),
            // Title
            Text(
              _getInsightTitle(insight.insightType),
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 12.h),
            // Content
            Text(
              insight.insightText,
              style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.textSecondary,
                height: 1.6,
              ),
            ),
            SizedBox(height: 24.h),
            // Action button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                ),
                child: Text(
                  'Got it!',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  String _getInsightTitle(String type) {
    switch (type) {
      case 'weekly_summary':
        return 'Weekly Summary';
      case 'pattern_alert':
        return 'Pattern Detected';
      case 'achievement':
        return 'Achievement Unlocked!';
      case 'tip':
        return 'Tip for You';
      default:
        return 'Insight';
    }
  }
}
