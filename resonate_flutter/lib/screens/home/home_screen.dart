import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/shared_widgets.dart';
import '../../providers/app_providers.dart';
import '../../data/models/models.dart';
import '../wellness/workout_session_screen.dart';
import '../wellness/meditation_session_screen.dart';
import '../wellness/music_player_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  final String? initialAction;
  
  const HomeScreen({super.key, this.initialAction});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool _actionTriggered = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Trigger initial action after frame is built
    if (widget.initialAction != null && !_actionTriggered) {
      _actionTriggered = true;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _triggerAction(widget.initialAction!);
      });
    }
  }

  void _triggerAction(String actionType) {
    switch (actionType) {
      case 'breathing':
        _showBreathingExercise(context);
        break;
      case 'journal':
        _showJournalPrompt(context, ref);
        break;
      case 'gratitude':
        _showGratitudePrompt(context, ref);
        break;
      case 'music':
        _showMusicSuggestion(context);
        break;
      case 'call':
        _showCallSuggestion(context, ref);
        break;
      case 'meditate':
        _showMeditationGuide(context);
        break;
      case 'workout':
        _showWorkoutSuggestion(context);
        break;
      case 'goals':
        _showGoalsSetting(context, ref);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    final entries = ref.watch(entriesProvider);
    final insights = ref.watch(insightsProvider);

    // Get today's entry
    final now = DateTime.now();
    final todayEntry = entries
        .where((e) =>
            e.recordedAt.year == now.year &&
            e.recordedAt.month == now.month &&
            e.recordedAt.day == now.day)
        .firstOrNull;

    // Get recent entries (last 7 days)
    final recentEntries = entries.take(5).toList();

    // Calculate weekly mood data
    final weeklyData = _calculateWeeklyData(entries);
    final latestInsight = insights.isNotEmpty ? insights.first : null;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header with greeting
              _buildHeader(context, user?.name ?? 'Friend')
                  .animate()
                  .fadeIn(duration: 400.ms),

              SizedBox(height: 24.h),

              // Today's mood card or prompt to record
              if (todayEntry != null)
                _buildTodayMoodCard(todayEntry)
                    .animate()
                    .fadeIn(delay: 100.ms)
                    .slideY(begin: 0.1, end: 0)
              else
                _buildRecordPrompt(context)
                    .animate()
                    .fadeIn(delay: 100.ms)
                    .slideY(begin: 0.1, end: 0),

              SizedBox(height: 24.h),

              // Stats row
              Row(
                children: [
                  Expanded(
                    child: StatCard(
                      title: 'Current Streak',
                      value: '${user?.currentStreak ?? 0}',
                      icon: Icons.local_fire_department_rounded,
                      color: AppColors.warning,
                      subtitle: 'days',
                    )
                        .animate()
                        .fadeIn(delay: 200.ms)
                        .slideX(begin: -0.1, end: 0),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: StatCard(
                      title: 'Total Check-ins',
                      value: '${entries.length}',
                      icon: Icons.check_circle_outline,
                      color: AppColors.success,
                      subtitle: 'entries',
                    )
                        .animate()
                        .fadeIn(delay: 300.ms)
                        .slideX(begin: 0.1, end: 0),
                  ),
                ],
              ),

              SizedBox(height: 24.h),

              // Weekly overview chart
              _buildWeeklyChart(weeklyData)
                  .animate()
                  .fadeIn(delay: 400.ms)
                  .slideY(begin: 0.1, end: 0),

              SizedBox(height: 24.h),

              // Quick Actions section
              _buildSectionTitle('Quick Actions', onSeeAll: () => context.push('/wellness-history')),
              SizedBox(height: 12.h),
              _buildQuickActionsGrid(context, ref)
                  .animate()
                  .fadeIn(delay: 450.ms)
                  .slideY(begin: 0.1, end: 0),

              SizedBox(height: 24.h),

              // Latest insight
              if (latestInsight != null) ...[
                _buildSectionTitle('Latest Insight',
                    onSeeAll: () => context.push('/insights')),
                SizedBox(height: 12.h),
                InsightCard(
                  insightText: latestInsight.insightText,
                  insightType: latestInsight.insightType,
                  generatedAt: latestInsight.generatedAt,
                  isRead: latestInsight.isRead,
                  onTap: () {
                    ref
                        .read(insightsProvider.notifier)
                        .markAsRead(latestInsight.id);
                    context.push('/insights');
                  },
                ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1, end: 0),
                SizedBox(height: 24.h),
              ],

              // Recent entries
              _buildSectionTitle('Recent Entries',
                  onSeeAll: () => context.push('/calendar')),
              SizedBox(height: 12.h),
              if (recentEntries.isEmpty)
                Center(
                  child: Padding(
                    padding: EdgeInsets.all(32.w),
                    child: Column(
                      children: [
                        Text('🎤', style: TextStyle(fontSize: 48.sp)),
                        SizedBox(height: 16.h),
                        Text(
                          'No entries yet',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Start your wellness journey!',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.textTertiary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ).animate().fadeIn(delay: 600.ms)
              else
                ...recentEntries.asMap().entries.map((entry) {
                  final index = entry.key;
                  final voiceEntry = entry.value;
                  return Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: MoodCard(
                      moodScore: voiceEntry.finalMoodScore,
                      recordedAt: voiceEntry.recordedAt,
                      transcript: voiceEntry.transcript,
                      tags: voiceEntry.tags,
                      onTap: () => _showEntryDetail(context, ref, voiceEntry),
                    )
                        .animate()
                        .fadeIn(delay: (600 + index * 100).ms)
                        .slideY(begin: 0.1, end: 0),
                  );
                }),

              SizedBox(height: 80.h), // Space for FAB
            ],
          ),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _calculateWeeklyData(List<dynamic> entries) {
    final days = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));

    return List.generate(7, (index) {
      final date = weekStart.add(Duration(days: index));
      final dayEntries = entries
          .where((e) =>
              e.recordedAt.year == date.year &&
              e.recordedAt.month == date.month &&
              e.recordedAt.day == date.day)
          .toList();

      return {
        'day': days[index],
        'hasEntry': dayEntries.isNotEmpty,
        'score': dayEntries.isNotEmpty ? dayEntries.first.finalMoodScore : 0.5,
      };
    });
  }

  void _showEntryDetail(BuildContext context, WidgetRef ref, dynamic entry) {
    final color = AppColors.getMoodColor(entry.finalMoodScore);

    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.cardDark : Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: isDark ? AppColors.dividerDark : AppColors.divider,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                MoodIndicator(moodScore: entry.finalMoodScore, size: 60),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppColors.getMoodLabel(entry.finalMoodScore),
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: color,
                        ),
                      ),
                      Text(
                        _formatDate(entry.recordedAt),
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            if ((entry.transcript ?? '').isNotEmpty) ...[
              Text(
                'What you said:',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondary,
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.surfaceVariantDark
                      : AppColors.background,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  '"${entry.transcript}"',
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimary,
                    fontStyle: FontStyle.italic,
                    height: 1.5,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
            ],
            if (entry.tags.isNotEmpty) ...[
              Text(
                'Tags:',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondary,
                ),
              ),
              SizedBox(height: 8.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: entry.tags
                    .map<Widget>((tag) => Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.w, vertical: 6.h),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Text(
                            '#${tag.name}',
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ))
                    .toList(),
              ),
              SizedBox(height: 16.h),
            ],
            SizedBox(height: 8.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Navigator.pop(context);
                      _confirmDelete(context, ref, entry);
                    },
                    icon: const Icon(Icons.delete_outline),
                    label: const Text('Delete'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.error,
                      side: const BorderSide(color: AppColors.error),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: const Text('Close'),
                  ),
                ),
              ],
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, dynamic entry) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        title: const Text('Delete Entry?'),
        content: const Text('This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(entriesProvider.notifier).deleteEntry(entry.id);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Entry deleted'),
                  behavior: SnackBarBehavior.floating,
                  duration: const Duration(seconds: 5),
                  margin: EdgeInsets.only(bottom: 16.h, left: 16.w, right: 16.w),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r)),
                ),
              );
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.error),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays == 0) {
      return 'Today at ${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
    } else if (diff.inDays == 1) {
      return 'Yesterday';
    } else {
      final months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ];
      return '${months[date.month - 1]} ${date.day}';
    }
  }

  Widget _buildHeader(BuildContext context, String name) {
    final hour = DateTime.now().hour;
    String greeting;
    String emoji;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (hour < 12) {
      greeting = 'Good Morning';
      emoji = '🌅';
    } else if (hour < 17) {
      greeting = 'Good Afternoon';
      emoji = '☀️';
    } else {
      greeting = 'Good Evening';
      emoji = '🌙';
    }

    return Row(
      children: [
        // Brand Logo
        Container(
          width: 44.w,
          height: 44.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: ClipOval(
            child: Image.asset(
              'assets/images/brand_logo_dark.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$greeting $emoji',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondary,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                name,
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () => context.push('/profile'),
          child: Container(
            width: 48.w,
            height: 48.w,
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                name[0].toUpperCase(),
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTodayMoodCard(dynamic entry) {
    final color = AppColors.getMoodColor(entry.finalMoodScore);

    return Builder(builder: (context) {
      final isDark = Theme.of(context).brightness == Brightness.dark;
      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [color.withOpacity(0.15), color.withOpacity(0.05)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Today's Check-in",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimary,
                  ),
                ),
                const Spacer(),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    'Done ✓',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            MoodIndicator(
              moodScore: entry.finalMoodScore,
              size: 100,
            ),
            SizedBox(height: 16.h),
            if (entry.transcript != null)
              Text(
                '"${entry.transcript}"',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondary,
                  fontStyle: FontStyle.italic,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
      );
    });
  }

  Widget _buildRecordPrompt(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            '🎤',
            style: TextStyle(fontSize: 48.sp),
          ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(
                begin: const Offset(1, 1),
                end: const Offset(1.1, 1.1),
                duration: 1000.ms,
              ),
          SizedBox(height: 16.h),
          Text(
            'How are you feeling?',
            style: TextStyle(
              fontSize: 22.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Take a moment to check in with yourself',
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.white.withOpacity(0.9),
            ),
          ),
          SizedBox(height: 20.h),
          SizedBox(
            width: 160.w,
            child: ElevatedButton(
              onPressed: () => context.push('/record'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: AppColors.primary,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              child: Text(
                'Start Recording',
                style: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyChart(List<Map<String, dynamic>> data) {
    return Builder(builder: (context) {
      final isDark = Theme.of(context).brightness == Brightness.dark;
      return Container(
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
            Row(
              children: [
                Text(
                  'This Week',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimary,
                  ),
                ),
                const Spacer(),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.trending_up,
                          size: 14.sp, color: AppColors.success),
                      SizedBox(width: 4.w),
                      Text(
                        '+12%',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.success,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            SizedBox(
              height: 160.h,
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  maxY: 1,
                  barTouchData: BarTouchData(enabled: false),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index >= 0 && index < data.length) {
                            return Padding(
                              padding: EdgeInsets.only(top: 8.h),
                              child: Text(
                                data[index]['day'] as String,
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                        reservedSize: 32,
                      ),
                    ),
                    leftTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    topTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                    rightTitles: const AxisTitles(
                        sideTitles: SideTitles(showTitles: false)),
                  ),
                  gridData: const FlGridData(show: false),
                  borderData: FlBorderData(show: false),
                  barGroups: data.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;
                    final hasEntry = item['hasEntry'] as bool;
                    final score = (item['score'] as double);

                    return BarChartGroupData(
                      x: index,
                      barRods: [
                        BarChartRodData(
                          toY: hasEntry ? score : 0.1,
                          color: hasEntry
                              ? AppColors.getMoodColor(score)
                              : AppColors.divider,
                          width: 32.w,
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(8.r),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildSectionTitle(String title, {VoidCallback? onSeeAll}) {
    return Builder(
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Row(
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color:
                    isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
              ),
            ),
            const Spacer(),
            if (onSeeAll != null)
              GestureDetector(
                onTap: onSeeAll,
                child: Text(
                  'See All',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }

  Widget _buildQuickActionsGrid(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final quickActions = [
      QuickAction(
          id: '1',
          label: 'Breathe',
          emoji: '🌬️',
          actionType: 'breathing',
          color: Colors.blue),
      QuickAction(
          id: '2',
          label: 'Journal',
          emoji: '📓',
          actionType: 'journal',
          color: Colors.purple),
      QuickAction(
          id: '3',
          label: 'Meditate',
          emoji: '🧘',
          actionType: 'meditate',
          color: Colors.indigo),
      QuickAction(
          id: '4',
          label: 'Music',
          emoji: '🎵',
          actionType: 'music',
          color: Colors.pink),
      QuickAction(
          id: '5',
          label: 'Call',
          emoji: '📞',
          actionType: 'call',
          color: Colors.green),
      QuickAction(
          id: '6',
          label: 'Workout',
          emoji: '💪',
          actionType: 'workout',
          color: Colors.orange),
      QuickAction(
          id: '7',
          label: 'Gratitude',
          emoji: '🙏',
          actionType: 'gratitude',
          color: Colors.amber),
      QuickAction(
          id: '8',
          label: 'Goals',
          emoji: '🎯',
          actionType: 'goals',
          color: Colors.teal),
    ];

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
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 12.h,
          crossAxisSpacing: 12.w,
          childAspectRatio: 0.85,
        ),
        itemCount: quickActions.length,
        itemBuilder: (context, index) {
          final action = quickActions[index];
          return _buildQuickActionItem(context, ref, action, isDark);
        },
      ),
    );
  }

  Widget _buildQuickActionItem(
      BuildContext context, WidgetRef ref, QuickAction action, bool isDark) {
    return GestureDetector(
      onTap: () => _handleQuickAction(context, ref, action),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 52.w,
            height: 52.w,
            decoration: BoxDecoration(
              color: action.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Center(
              child: Text(action.emoji, style: TextStyle(fontSize: 24.sp)),
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            action.label,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              color: isDark
                  ? AppColors.textSecondaryDark
                  : AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  void _handleQuickAction(BuildContext context, WidgetRef ref, QuickAction action) {
    switch (action.actionType) {
      case 'breathing':
        _showBreathingExercise(context);
        break;
      case 'journal':
        _showJournalPrompt(context, ref);
        break;
      case 'gratitude':
        _showGratitudePrompt(context, ref);
        break;
      case 'music':
        _showMusicSuggestion(context);
        break;
      case 'call':
        _showCallSuggestion(context, ref);
        break;
      case 'meditate':
        _showMeditationGuide(context);
        break;
      case 'workout':
        _showWorkoutSuggestion(context);
        break;
      case 'goals':
        _showGoalsSetting(context, ref);
        break;
    }
  }

  void _showBreathingExercise(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          children: [
            SizedBox(height: 12.h),
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              '🌬️ Breathing Exercise',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color:
                    isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Follow the circle to calm your mind',
              style: TextStyle(
                fontSize: 14.sp,
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondary,
              ),
            ),
            const Spacer(),
            _BreathingAnimation(),
            const Spacer(),
            Padding(
              padding: EdgeInsets.only(left: 24.w, right: 24.w, bottom: 60.h),
              child: SizedBox(
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
                  child:
                      const Text('Done', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showJournalPrompt(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final TextEditingController journalController = TextEditingController();
    final prompts = [
      'What are you grateful for today?',
      'What made you smile recently?',
      'What\'s on your mind right now?',
      'What would make today great?',
      'How are you really feeling?',
    ];
    final prompt = prompts[DateTime.now().millisecond % prompts.length];

    final rootContext = context;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (modalContext) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(modalContext).viewInsets.bottom),
        child: Container(
          height: MediaQuery.of(modalContext).size.height * 0.6,
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Center(
                child: Text(
                  '📓 Quick Journal',
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimary,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Text('💭', style: TextStyle(fontSize: 24.sp)),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        prompt,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: TextField(
                  controller: journalController,
                  maxLines: null,
                  expands: true,
                  textAlignVertical: TextAlignVertical.top,
                  decoration: InputDecoration(
                    hintText: 'Start writing...',
                    hintStyle: TextStyle(
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondary),
                    filled: true,
                    fillColor: isDark ? AppColors.cardDark : AppColors.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimary,
                    height: 1.5,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (journalController.text.trim().isNotEmpty) {
                      final entry = JournalEntry(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        createdAt: DateTime.now(),
                        content: journalController.text.trim(),
                        prompt: prompt,
                      );
                      ref.read(journalProvider.notifier).addEntry(entry);
                      Navigator.pop(modalContext);
                      ScaffoldMessenger.of(rootContext).showSnackBar(
                        SnackBar(
                          content: const Text('📓 Journal entry saved!'),
                          backgroundColor: AppColors.success,
                          behavior: SnackBarBehavior.floating,
                          duration: const Duration(seconds: 5),
                          margin: EdgeInsets.only(bottom: 16.h, left: 16.w, right: 16.w),
                        ),
                      );
                    } else {
                      Navigator.pop(modalContext);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r)),
                  ),
                  child: const Text('Save Entry',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600)),
                ),
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  void _showGratitudePrompt(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final List<TextEditingController> controllers =
        List.generate(3, (_) => TextEditingController());
    final rootContext = context;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (modalContext) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(modalContext).viewInsets.bottom),
        child: Container(
          height: MediaQuery.of(modalContext).size.height * 0.6,
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          padding: EdgeInsets.all(24.w),
          child: Column(
            children: [
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
              SizedBox(height: 20.h),
              Text(
                '🙏 Gratitude Practice',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'List 3 things you\'re grateful for today',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondary,
                ),
              ),
              SizedBox(height: 24.h),
              Expanded(
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: TextField(
                      controller: controllers[index],
                      decoration: InputDecoration(
                        prefixIcon: Text('${index + 1}.',
                            style: TextStyle(
                                fontSize: 18.sp, color: AppColors.primary)),
                        prefixIconConstraints: BoxConstraints(minWidth: 40.w),
                        hintText: 'I\'m grateful for...',
                        hintStyle: TextStyle(
                            color: isDark
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondary),
                        filled: true,
                        fillColor:
                            isDark ? AppColors.cardDark : AppColors.surface,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: TextStyle(
                          color: isDark
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimary),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final items = controllers
                        .map((c) => c.text.trim())
                        .where((t) => t.isNotEmpty)
                        .toList();
                    if (items.isNotEmpty) {
                      final entry = GratitudeEntry(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        createdAt: DateTime.now(),
                        items: items,
                      );
                      ref.read(gratitudeProvider.notifier).addEntry(entry);
                      Navigator.pop(modalContext);
                      ScaffoldMessenger.of(rootContext).showSnackBar(
                        SnackBar(
                          content: const Text(
                              '🙏 Gratitude saved! Keep up the positive mindset!'),
                          backgroundColor: AppColors.success,
                          duration: const Duration(seconds: 5),
                          behavior: SnackBarBehavior.floating,
                          margin: EdgeInsets.only(bottom: 16.h, left: 16.w, right: 16.w),
                        ),
                      );
                    } else {
                      Navigator.pop(modalContext);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.r)),
                  ),
                  child: const Text('Save Gratitude',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600)),
                ),
              ),
              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  void _showMusicSuggestion(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final musicOptions = [
      {
        'emoji': '😌',
        'title': 'Calm & Peaceful',
        'subtitle': 'Ambient sounds, soft piano',
        'color': Colors.blue
      },
      {
        'emoji': '😊',
        'title': 'Uplifting & Happy',
        'subtitle': 'Feel-good songs',
        'color': Colors.orange
      },
      {
        'emoji': '🧘',
        'title': 'Meditation & Focus',
        'subtitle': 'Binaural beats, lo-fi',
        'color': Colors.purple
      },
      {
        'emoji': '💪',
        'title': 'Energizing',
        'subtitle': 'Upbeat tracks',
        'color': Colors.red
      },
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (modalContext) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7,
        ),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        padding: EdgeInsets.all(24.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.3),
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              '🎵 Music Therapy',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color:
                    isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Choose a mood and start listening',
              style: TextStyle(
                fontSize: 14.sp,
                color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
              ),
            ),
            SizedBox(height: 20.h),
            ...musicOptions.map((option) => Container(
                  margin: EdgeInsets.only(bottom: 12.h),
                  child: ListTile(
                    leading: Container(
                      width: 44.w,
                      height: 44.w,
                      decoration: BoxDecoration(
                        color: (option['color'] as Color).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Center(
                          child: Text(option['emoji'] as String,
                              style: TextStyle(fontSize: 22.sp))),
                    ),
                    title: Text(option['title'] as String,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: isDark
                                ? AppColors.textPrimaryDark
                                : AppColors.textPrimary)),
                    subtitle: Text(option['subtitle'] as String,
                        style: TextStyle(
                            color: isDark
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondary)),
                    trailing: Icon(Icons.play_circle_fill,
                        color: option['color'] as Color, size: 32.sp),
                    onTap: () {
                      Navigator.pop(modalContext);
                      Future.microtask(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MusicPlayerScreen(
                              category: option['title'] as String,
                              emoji: option['emoji'] as String,
                              color: option['color'] as Color,
                            ),
                          ),
                        );
                      });
                    },
                    tileColor: isDark ? AppColors.cardDark : AppColors.surface,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r)),
                  ),
                )),
            SizedBox(height: 8.h),
          ],
        ),
        ),
      ),
    );
  }

  void _showCallSuggestion(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final allContacts = ref.read(favoriteContactProvider);
    // Limit to 6 contacts max
    final contacts = allContacts.take(6).toList();
    final rootContext = context;
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (modalContext) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.55,
        ),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
        child: ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: SingleChildScrollView(
            child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(2.r))),
              SizedBox(height: 12.h),
              Text('📞 Call Someone',
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimary)),
              SizedBox(height: 4.h),
              Text('Connecting with loved ones can help',
                  style: TextStyle(
                      fontSize: 12.sp,
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondary),
                  textAlign: TextAlign.center),
              SizedBox(height: 12.h),
              
              // Section header with manage link
              Row(
              children: [
                Text('Your Contacts',
                    style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w600,
                        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary)),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(modalContext);
                    rootContext.push('/wellness-history');
                  },
                  child: Text('Manage',
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary)),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            
            // Contacts grid - compact, 2 rows of 3 (max 6)
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 10.h,
                crossAxisSpacing: 10.w,
                childAspectRatio: 1.0,
              ),
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.pop(modalContext);
                    ScaffoldMessenger.of(rootContext).showSnackBar(SnackBar(
                        content: Text('📞 Calling ${contact.name}${contact.phone != null ? ' (${contact.phone})' : ''}...'),
                        backgroundColor: Colors.green,
                        behavior: SnackBarBehavior.floating,
                        duration: const Duration(seconds: 5),
                        margin: EdgeInsets.only(bottom: 16.h, left: 16.w, right: 16.w)));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDark ? AppColors.cardDark : AppColors.surface,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.green.withOpacity(0.3)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 36.w,
                          height: 36.w,
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(contact.emoji, style: TextStyle(fontSize: 18.sp)),
                          ),
                        ),
                        SizedBox(height: 6.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: Text(contact.name,
                              style: TextStyle(
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w600,
                                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                        ),
                        Icon(Icons.call, color: Colors.green, size: 14.sp),
                      ],
                    ),
                  ),
                );
              },
            ),
            
            SizedBox(height: 12.h),
            
            // Crisis line info
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  Icon(Icons.emergency, color: Colors.red, size: 16.sp),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'In crisis? Call 988 (Suicide & Crisis Lifeline)',
                      style: TextStyle(fontSize: 11.sp, color: Colors.red, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 80.h),
          ],
        ),
        ),
        ),
      ),
    );
  }

  void _showMeditationGuide(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final meditations = [
      {
        'duration': 3,
        'title': 'Quick Reset',
        'icon': Icons.bolt,
        'color': Colors.amber
      },
      {
        'duration': 5,
        'title': 'Body Scan',
        'icon': Icons.accessibility_new,
        'color': Colors.blue
      },
      {
        'duration': 10,
        'title': 'Loving Kindness',
        'icon': Icons.favorite,
        'color': Colors.pink
      },
      {
        'duration': 15,
        'title': 'Deep Relaxation',
        'icon': Icons.spa,
        'color': Colors.green
      },
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (modalContext) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.6,
        ),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        padding: EdgeInsets.all(20.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(2.r))),
              SizedBox(height: 20.h),
              Text('🧘 Guided Meditation',
                style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimary)),
            SizedBox(height: 8.h),
            Text('Choose a session and find your peace',
                style: TextStyle(
                    fontSize: 14.sp,
                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary)),
            SizedBox(height: 20.h),
            ...meditations.map((m) => Container(
                  margin: EdgeInsets.only(bottom: 12.h),
                  child: ListTile(
                    leading: Container(
                      width: 44.w,
                      height: 44.w,
                      decoration: BoxDecoration(
                          color: (m['color'] as Color).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12.r)),
                      child: Icon(m['icon'] as IconData,
                          color: m['color'] as Color),
                    ),
                    title: Row(children: [
                      Flexible(
                        child: Text(m['title'] as String,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: isDark
                                    ? AppColors.textPrimaryDark
                                    : AppColors.textPrimary)),
                      ),
                      SizedBox(width: 8.w),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 8.w, vertical: 2.h),
                        decoration: BoxDecoration(
                            color: (m['color'] as Color).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8.r)),
                        child: Text('${m['duration']} min',
                            style: TextStyle(
                                fontSize: 10.sp,
                                color: m['color'] as Color,
                                fontWeight: FontWeight.w600)),
                      ),
                    ]),
                    trailing:
                        Icon(Icons.play_arrow, color: m['color'] as Color),
                    onTap: () {
                      Navigator.pop(modalContext);
                      Future.microtask(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MeditationSessionScreen(
                              meditationType: m['title'] as String,
                              durationMinutes: m['duration'] as int,
                              icon: m['icon'] as IconData,
                              color: m['color'] as Color,
                            ),
                          ),
                        );
                      });
                    },
                    tileColor: isDark ? AppColors.cardDark : AppColors.surface,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r)),
                  ),
                )),
            ],
          ),
        ),
      ),
    );
  }


  void _showWorkoutSuggestion(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final workouts = [
      {
        'emoji': '🧘',
        'title': 'Gentle Stretching',
        'duration': 5,
        'intensity': 'Low',
        'color': Colors.blue
      },
      {
        'emoji': '�',
        'title': 'Walking',
        'duration': 10,
        'intensity': 'Low',
        'color': Colors.green
      },
      {
        'emoji': '�💃',
        'title': 'Dance Break',
        'duration': 5,
        'intensity': 'Medium',
        'color': Colors.pink
      },
      {
        'emoji': '🏋️',
        'title': 'Quick HIIT',
        'duration': 7,
        'intensity': 'High',
        'color': Colors.orange
      },
    ];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (modalContext) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7,
        ),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        padding: EdgeInsets.all(24.w),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(2.r))),
              SizedBox(height: 20.h),
              Text('💪 Movement Therapy',
                style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimary)),
            SizedBox(height: 8.h),
            Text('Choose a workout and get moving!',
                style: TextStyle(
                    fontSize: 14.sp,
                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary)),
            SizedBox(height: 20.h),
            ...workouts.map((w) => Container(
                  margin: EdgeInsets.only(bottom: 12.h),
                  child: ListTile(
                    leading: Container(
                      width: 44.w,
                      height: 44.w,
                      decoration: BoxDecoration(
                          color: (w['color'] as Color).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12.r)),
                      child: Center(
                          child: Text(w['emoji'] as String,
                              style: TextStyle(fontSize: 22.sp))),
                    ),
                    title: Text(w['title'] as String,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: isDark
                                ? AppColors.textPrimaryDark
                                : AppColors.textPrimary)),
                    subtitle: Row(
                      children: [
                        Text('${w['duration']} min',
                            style: TextStyle(
                                fontSize: 12.sp,
                                color: isDark
                                    ? AppColors.textSecondaryDark
                                    : AppColors.textSecondary)),
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                          decoration: BoxDecoration(
                            color: (w['color'] as Color).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Text(w['intensity'] as String,
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  color: w['color'] as Color,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.arrow_forward_ios,
                        color: w['color'] as Color, size: 18.sp),
                    onTap: () {
                      Navigator.pop(modalContext);
                      Future.microtask(() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => WorkoutSessionScreen(
                              workoutType: w['title'] as String,
                              emoji: w['emoji'] as String,
                              color: w['color'] as Color,
                              durationMinutes: w['duration'] as int,
                            ),
                          ),
                        );
                      });
                    },
                    tileColor: isDark ? AppColors.cardDark : AppColors.surface,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r)),
                  ),
                )),
            ],
          ),
        ),
      ),
    );
  }

  void _showGoalsSetting(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final rootContext = context;
    final customGoalController = TextEditingController();
    final goals = [
      {'emoji': '💧', 'title': 'Drink more water'},
      {'emoji': '😴', 'title': 'Sleep 8 hours'},
      {'emoji': '🚶', 'title': 'Walk 10 min daily'},
      {'emoji': '📵', 'title': 'Less screen time'},
      {'emoji': '🧘', 'title': 'Meditate daily'},
      {'emoji': '📓', 'title': 'Journal nightly'},
    ];
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (modalContext) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(modalContext).viewInsets.bottom),
        child: Container(
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.7,
          ),
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          padding: EdgeInsets.all(24.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('🎯 Set a Wellness Goal',
                    style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: isDark
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimary)),
                SizedBox(height: 8.h),
                Text('Choose a preset or create your own',
                    style: TextStyle(
                        fontSize: 14.sp,
                        color: isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondary)),
                SizedBox(height: 20.h),
                
                // Custom goal input
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(16.r),
                    border: Border.all(color: AppColors.primary.withOpacity(0.2)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('✨ Custom Goal',
                          style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primary)),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: customGoalController,
                              decoration: InputDecoration(
                                hintText: 'Enter your own goal...',
                                hintStyle: TextStyle(
                                    color: isDark
                                        ? AppColors.textSecondaryDark
                                        : AppColors.textSecondary),
                                filled: true,
                                fillColor: isDark ? AppColors.cardDark : Colors.white,
                                contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              style: TextStyle(
                                  color: isDark
                                      ? AppColors.textPrimaryDark
                                      : AppColors.textPrimary),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          ElevatedButton(
                            onPressed: () {
                              if (customGoalController.text.trim().isNotEmpty) {
                                final goal = WellnessGoal(
                                  id: DateTime.now().millisecondsSinceEpoch.toString(),
                                  createdAt: DateTime.now(),
                                  title: customGoalController.text.trim(),
                                  emoji: '⭐',
                                );
                                ref.read(wellnessGoalProvider.notifier).addGoal(goal);
                                Navigator.pop(modalContext);
                                ScaffoldMessenger.of(rootContext).showSnackBar(SnackBar(
                                    content: Text('🎯 Goal set: ⭐ ${customGoalController.text.trim()}'),
                                    backgroundColor: AppColors.success,
                                    behavior: SnackBarBehavior.floating,
                                    duration: const Duration(seconds: 5),
                                    margin: EdgeInsets.only(bottom: 16.h, left: 16.w, right: 16.w)));
                              }
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primary,
                              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.r)),
                            ),
                            child: const Text('Add', style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                SizedBox(height: 20.h),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text('📝 Preset Goals',
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondary)),
                ),
                SizedBox(height: 12.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: goals
                      .map((g) => GestureDetector(
                            onTap: () {
                              final goal = WellnessGoal(
                                id: DateTime.now().millisecondsSinceEpoch.toString(),
                                createdAt: DateTime.now(),
                                title: g['title']!,
                                emoji: g['emoji']!,
                              );
                              ref.read(wellnessGoalProvider.notifier).addGoal(goal);
                              Navigator.pop(modalContext);
                              ScaffoldMessenger.of(rootContext).showSnackBar(SnackBar(
                                  content: Text('🎯 Goal set: ${g['emoji']} ${g['title']}'),
                                  backgroundColor: AppColors.success,
                                  behavior: SnackBarBehavior.floating,
                                  duration: const Duration(seconds: 5),
                                  margin: EdgeInsets.only(bottom: 16.h, left: 16.w, right: 16.w)));
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 16.w, vertical: 10.h),
                              decoration: BoxDecoration(
                                  color: AppColors.primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20.r),
                                  border: Border.all(
                                      color: AppColors.primary.withOpacity(0.3))),
                              child: Text('${g['emoji']} ${g['title']}',
                                  style: TextStyle(
                                      fontSize: 13.sp,
                                      color: AppColors.primary,
                                      fontWeight: FontWeight.w500)),
                            ),
                          ))
                      .toList(),
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

}

// Breathing animation widget for home screen
class _BreathingAnimation extends StatefulWidget {
  @override
  State<_BreathingAnimation> createState() => _BreathingAnimationState();
}

class _BreathingAnimationState extends State<_BreathingAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final List<String> _phases = ['Breathe In', 'Hold', 'Breathe Out', 'Hold'];
  int _currentPhase = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          setState(() => _currentPhase = (_currentPhase + 1) % 4);
          _controller.forward(from: 0);
        }
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            double scale = 1.0;
            if (_currentPhase == 0)
              scale = 1.0 + (_controller.value * 0.5);
            else if (_currentPhase == 1)
              scale = 1.5;
            else if (_currentPhase == 2)
              scale = 1.5 - (_controller.value * 0.5);
            else
              scale = 1.0;

            return Container(
              width: 120.w * scale,
              height: 120.w * scale,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.primary.withOpacity(0.3),
                    AppColors.primary.withOpacity(0.1)
                  ],
                ),
                border: Border.all(color: AppColors.primary, width: 3),
              ),
            );
          },
        ),
        SizedBox(height: 24.h),
        Text(
          _phases[_currentPhase],
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.primary,
          ),
        ),
      ],
    );
  }
}
