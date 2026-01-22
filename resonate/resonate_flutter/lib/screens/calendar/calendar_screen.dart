import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/shared_widgets.dart';
import '../../providers/app_providers.dart';
import '../../data/models/models.dart';

class CalendarScreen extends ConsumerStatefulWidget {
  const CalendarScreen({super.key});

  @override
  ConsumerState<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends ConsumerState<CalendarScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  
  VoiceEntry? _getEntryForDay(DateTime day, List<VoiceEntry> entries) {
    for (final entry in entries) {
      if (entry.recordedAt.year == day.year &&
          entry.recordedAt.month == day.month &&
          entry.recordedAt.day == day.day) {
        return entry;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final entries = ref.watch(entriesProvider);
    final selectedEntry = _selectedDay != null 
        ? _getEntryForDay(_selectedDay!, entries) 
        : null;
    
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Calendar',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Calendar
          Container(
            margin: EdgeInsets.all(16.w),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: isDark ? AppColors.cardDark : Colors.white,
              borderRadius: BorderRadius.circular(24.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: TableCalendar(
              firstDay: DateTime.utc(2024, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              calendarFormat: _calendarFormat,
              daysOfWeekStyle: DaysOfWeekStyle(
                weekdayStyle: TextStyle(color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary),
                weekendStyle: TextStyle(color: isDark ? AppColors.textTertiaryDark : AppColors.textLight),
              ),
              onFormatChanged: (format) {
                setState(() => _calendarFormat = format);
              },
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
              calendarStyle: CalendarStyle(
                outsideDaysVisible: false,
                weekendTextStyle: TextStyle(color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary),
                defaultTextStyle: TextStyle(color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary),
                selectedDecoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  shape: BoxShape.circle,
                ),
                todayDecoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                markerSize: 8.w,
                markersMaxCount: 1,
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: true,
                titleCentered: true,
                formatButtonShowsNext: false,
                formatButtonDecoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                formatButtonTextStyle: TextStyle(
                  color: AppColors.primary,
                  fontSize: 12.sp,
                ),
                titleTextStyle: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w600,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                ),
                leftChevronIcon: Icon(
                  Icons.chevron_left,
                  color: AppColors.primary,
                ),
                rightChevronIcon: Icon(
                  Icons.chevron_right,
                  color: AppColors.primary,
                ),
              ),
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, date, events) {
                  final entry = _getEntryForDay(date, entries);
                  if (entry != null) {
                    return Positioned(
                      bottom: 4,
                      child: Container(
                        width: 8.w,
                        height: 8.w,
                        decoration: BoxDecoration(
                          color: AppColors.getMoodColor(entry.finalMoodScore),
                          shape: BoxShape.circle,
                        ),
                      ),
                    );
                  }
                  return null;
                },
              ),
            ),
          ).animate().fadeIn().slideY(begin: -0.1, end: 0),
          
          // Legend
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLegendItem('Low', AppColors.moodLow),
                SizedBox(width: 16.w),
                _buildLegendItem('Neutral', AppColors.moodNeutral),
                SizedBox(width: 16.w),
                _buildLegendItem('Good', AppColors.moodGood),
                SizedBox(width: 16.w),
                _buildLegendItem('Great', AppColors.moodGreat),
              ],
            ),
          ).animate().fadeIn(delay: 200.ms),
          
          SizedBox(height: 16.h),
          
          // Selected day entry or empty state
          Expanded(
            child: _selectedDay != null
                ? selectedEntry != null
                    ? _buildSelectedEntry(selectedEntry)
                        .animate()
                        .fadeIn()
                        .slideY(begin: 0.1, end: 0)
                    : _buildNoEntry()
                        .animate()
                        .fadeIn()
                : _buildSelectDayPrompt()
                    .animate()
                    .fadeIn(delay: 300.ms),
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 10.w,
          height: 10.w,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 4.w),
        Text(
          label,
          style: TextStyle(
            fontSize: 11.sp,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildSelectedEntry(VoiceEntry entry) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        children: [
          MoodCard(
            moodScore: entry.finalMoodScore,
            recordedAt: entry.recordedAt,
            transcript: entry.transcript,
            tags: entry.tags,
          ),
          SizedBox(height: 16.h),
          // Quick stats
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Entry Details',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 12.h),
                _buildDetailRow('Duration', '${entry.durationSeconds.round()} seconds'),
                _buildDetailRow('Language', entry.language == 'en' ? 'English' : 'Bengali'),
                _buildDetailRow('Confidence', '${(entry.confidence * 100).round()}%'),
                if (entry.detectedEmotions.isNotEmpty)
                  _buildDetailRow('Emotions', entry.detectedEmotions.join(', ')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.textSecondary,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoEntry() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '📝',
            style: TextStyle(fontSize: 48.sp),
          ),
          SizedBox(height: 16.h),
          Text(
            'No entry for this day',
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSelectDayPrompt() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '📅',
            style: TextStyle(fontSize: 48.sp),
          ),
          SizedBox(height: 16.h),
          Text(
            'Select a day to view entry',
            style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
