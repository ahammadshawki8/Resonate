import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../core/theme/app_colors.dart';
import '../data/models/models.dart';

/// Gradient Button with kawaii style
class GradientButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final double? width;
  final double? height;
  
  const GradientButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.icon,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? 56.h,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: isLoading ? null : onPressed,
          borderRadius: BorderRadius.circular(16.r),
          child: Center(
            child: isLoading
                ? SizedBox(
                    width: 24.w,
                    height: 24.h,
                    child: const CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2.5,
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (icon != null) ...[
                        Icon(icon, color: Colors.white, size: 22.sp),
                        SizedBox(width: 8.w),
                      ],
                      Text(
                        text,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 0.5,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

/// Secondary outline button
class OutlineButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color? color;
  
  const OutlineButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    final buttonColor = color ?? AppColors.primary;
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: buttonColor, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null) ...[
              Icon(icon, color: buttonColor, size: 22.sp),
              SizedBox(width: 8.w),
            ],
            Text(
              text,
              style: TextStyle(
                color: buttonColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Animated mood emoji display
class AnimatedMoodEmoji extends StatelessWidget {
  final double moodScore;
  final double size;
  final bool animate;
  
  const AnimatedMoodEmoji({
    super.key,
    required this.moodScore,
    this.size = 80,
    this.animate = true,
  });
  
  String get emoji {
    if (moodScore >= 0.8) return '😊';
    if (moodScore >= 0.6) return '🙂';
    if (moodScore >= 0.4) return '😐';
    if (moodScore >= 0.2) return '😔';
    return '😢';
  }

  @override
  Widget build(BuildContext context) {
    final widget = Text(
      emoji,
      style: TextStyle(fontSize: size.sp),
    );
    
    if (!animate) return widget;
    
    return widget
        .animate(onPlay: (controller) => controller.repeat(reverse: true))
        .scale(
          begin: const Offset(1, 1),
          end: const Offset(1.1, 1.1),
          duration: 1500.ms,
          curve: Curves.easeInOut,
        );
  }
}

/// Mood indicator circle with gradient
class MoodIndicator extends StatelessWidget {
  final double moodScore;
  final double size;
  final bool showLabel;
  
  const MoodIndicator({
    super.key,
    required this.moodScore,
    this.size = 120,
    this.showLabel = true,
  });

  @override
  Widget build(BuildContext context) {
    final color = AppColors.getMoodColor(moodScore);
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: size.w,
          height: size.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                color.withOpacity(0.3),
                color.withOpacity(0.1),
              ],
            ),
            border: Border.all(color: color, width: 3),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 20,
                spreadRadius: 5,
              ),
            ],
          ),
          child: Center(
            child: AnimatedMoodEmoji(
              moodScore: moodScore,
              size: size * 0.4,
            ),
          ),
        ),
        if (showLabel) ...[
          SizedBox(height: 12.h),
          Text(
            _getMoodLabel(moodScore),
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ],
    );
  }
  
  String _getMoodLabel(double score) {
    if (score >= 0.8) return 'Excellent';
    if (score >= 0.6) return 'Good';
    if (score >= 0.4) return 'Neutral';
    if (score >= 0.2) return 'Low';
    return 'Difficult';
  }
}

/// Stat card for displaying metrics
class StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color? color;
  final String? subtitle;
  
  const StatCard({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.color,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    final cardColor = color ?? AppColors.primary;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      padding: EdgeInsets.all(16.w),
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
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: cardColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(icon, color: cardColor, size: 24.sp),
          ),
          SizedBox(height: 12.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 13.sp,
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
            ),
          ),
          if (subtitle != null) ...[
            SizedBox(height: 4.h),
            Text(
              subtitle!,
              style: TextStyle(
                fontSize: 11.sp,
                color: cardColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Mood card for displaying a voice entry summary
class MoodCard extends StatelessWidget {
  final double moodScore;
  final DateTime recordedAt;
  final String? transcript;
  final List<Tag> tags;
  final VoidCallback? onTap;
  
  const MoodCard({
    super.key,
    required this.moodScore,
    required this.recordedAt,
    this.transcript,
    this.tags = const [],
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final color = AppColors.getMoodColor(moodScore);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isDark ? AppColors.cardDark : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: color.withOpacity(0.3), width: 2),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(isDark ? 0.2 : 0.1),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Mood emoji
            Container(
              width: 56.w,
              height: 56.w,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: AnimatedMoodEmoji(
                  moodScore: moodScore,
                  size: 28,
                  animate: false,
                ),
              ),
            ),
            SizedBox(width: 14.w),
            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        _formatTime(recordedAt),
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10.w,
                          vertical: 4.h,
                        ),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          '${(moodScore * 100).round()}%',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: color,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (transcript != null) ...[
                    SizedBox(height: 6.h),
                    Text(
                      transcript!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                        height: 1.4,
                      ),
                    ),
                  ],
                  if (tags.isNotEmpty) ...[
                    SizedBox(height: 8.h),
                    Wrap(
                      spacing: 6.w,
                      children: tags.take(3).map((tag) => _buildTag(tag)).toList(),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Widget _buildTag(Tag tag) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: AppColors.accent.withOpacity(0.15),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Text(
        tag.name,
        style: TextStyle(
          fontSize: 11.sp,
          color: AppColors.accent,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
  
  String _formatTime(DateTime dt) {
    final hour = dt.hour > 12 ? dt.hour - 12 : dt.hour;
    final period = dt.hour >= 12 ? 'PM' : 'AM';
    return '$hour:${dt.minute.toString().padLeft(2, '0')} $period';
  }
}

/// Insight card widget
class InsightCard extends StatelessWidget {
  final String insightText;
  final String insightType;
  final DateTime generatedAt;
  final bool isRead;
  final VoidCallback? onTap;
  
  const InsightCard({
    super.key,
    required this.insightText,
    required this.insightType,
    required this.generatedAt,
    this.isRead = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final typeInfo = _getTypeInfo(insightType);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isDark ? AppColors.cardDark : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: isRead 
              ? null 
              : Border.all(color: typeInfo['color'] as Color, width: 2),
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
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: (typeInfo['color'] as Color).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Icon(
                    typeInfo['icon'] as IconData,
                    color: typeInfo['color'] as Color,
                    size: 20.sp,
                  ),
                ),
                SizedBox(width: 10.w),
                Text(
                  typeInfo['label'] as String,
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: typeInfo['color'] as Color,
                  ),
                ),
                const Spacer(),
                if (!isRead)
                  Container(
                    width: 8.w,
                    height: 8.w,
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      shape: BoxShape.circle,
                    ),
                  ),
              ],
            ),
            SizedBox(height: 12.h),
            Text(
              insightText,
              style: TextStyle(
                fontSize: 14.sp,
                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                height: 1.5,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              _formatDate(generatedAt),
              style: TextStyle(
                fontSize: 12.sp,
                color: isDark ? AppColors.textSecondaryDark : AppColors.textLight,
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Map<String, dynamic> _getTypeInfo(String type) {
    switch (type) {
      case 'weekly_summary':
        return {
          'icon': Icons.analytics_outlined,
          'color': AppColors.primary,
          'label': 'Weekly Summary',
        };
      case 'pattern_alert':
        return {
          'icon': Icons.lightbulb_outline,
          'color': AppColors.warning,
          'label': 'Pattern Detected',
        };
      case 'achievement':
        return {
          'icon': Icons.emoji_events_outlined,
          'color': AppColors.success,
          'label': 'Achievement',
        };
      case 'tip':
        return {
          'icon': Icons.tips_and_updates_outlined,
          'color': AppColors.accent,
          'label': 'Tip for You',
        };
      default:
        return {
          'icon': Icons.info_outline,
          'color': AppColors.primary,
          'label': 'Insight',
        };
    }
  }
  
  String _formatDate(DateTime dt) {
    final now = DateTime.now();
    final diff = now.difference(dt);
    
    if (diff.inDays == 0) return 'Today';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays} days ago';
    return '${dt.day}/${dt.month}/${dt.year}';
  }
}

/// Floating record button
class RecordButton extends StatelessWidget {
  final VoidCallback? onTap;
  final bool isRecording;
  
  const RecordButton({
    super.key,
    this.onTap,
    this.isRecording = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 72.w,
        height: 72.w,
        decoration: BoxDecoration(
          gradient: isRecording 
              ? LinearGradient(
                  colors: [Colors.red.shade400, Colors.red.shade600],
                )
              : AppColors.primaryGradient,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: (isRecording ? Colors.red : AppColors.primary).withOpacity(0.4),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Center(
          child: Icon(
            isRecording ? Icons.stop_rounded : Icons.mic_rounded,
            color: Colors.white,
            size: 32.sp,
          ),
        ),
      ).animate(
        onPlay: isRecording ? (c) => c.repeat() : null,
      ).scale(
        begin: const Offset(1, 1),
        end: const Offset(1.1, 1.1),
        duration: 600.ms,
        curve: Curves.easeInOut,
      ),
    );
  }
}

/// Empty state widget
class EmptyState extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Widget? action;
  
  const EmptyState({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 48.sp,
                color: AppColors.primary.withOpacity(0.5),
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              subtitle,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
            if (action != null) ...[
              SizedBox(height: 24.h),
              action!,
            ],
          ],
        ),
      ),
    );
  }
}

/// Loading shimmer effect
class ShimmerLoading extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  
  const ShimmerLoading({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(borderRadius.r),
      ),
    ).animate(
      onPlay: (controller) => controller.repeat(),
    ).shimmer(
      duration: 1200.ms,
      color: Colors.grey.shade100,
    );
  }
}
