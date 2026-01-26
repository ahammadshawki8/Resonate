import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/app_providers.dart';

class TrendsScreen extends ConsumerStatefulWidget {
  const TrendsScreen({super.key});

  @override
  ConsumerState<TrendsScreen> createState() => _TrendsScreenState();
}

class _TrendsScreenState extends ConsumerState<TrendsScreen> {
  String _selectedPeriod = 'Week';
  final List<String> _periods = ['Week', 'Month', '3 Months'];

  @override
  Widget build(BuildContext context) {
    final entries = ref.watch(entriesProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Trends',
          style: TextStyle(
            fontSize: 20.sp,
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
            // Period selector
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: isDark ? AppColors.cardDark : Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                children: _periods.map((period) {
                  final isSelected = period == _selectedPeriod;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedPeriod = period),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(
                          gradient: isSelected ? AppColors.primaryGradient : null,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          period,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: isSelected ? Colors.white : AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ).animate().fadeIn(),
            
            SizedBox(height: 24.h),
            
            // Mood trend chart
            _buildMoodTrendCard(entries)
                .animate()
                .fadeIn(delay: 100.ms)
                .slideY(begin: 0.1, end: 0),
            
            SizedBox(height: 24.h),
            
            // Stats overview
            _buildStatsOverview(entries)
                .animate()
                .fadeIn(delay: 200.ms)
                .slideY(begin: 0.1, end: 0),
            
            SizedBox(height: 24.h),
            
            // Mood distribution
            _buildMoodDistribution(entries)
                .animate()
                .fadeIn(delay: 300.ms)
                .slideY(begin: 0.1, end: 0),
            
            SizedBox(height: 24.h),
            
            // Time of day analysis
            _buildTimeOfDayAnalysis(entries)
                .animate()
                .fadeIn(delay: 400.ms)
                .slideY(begin: 0.1, end: 0),
            
            SizedBox(height: 24.h),
            
            // Patterns detected
            _buildPatterns()
                .animate()
                .fadeIn(delay: 500.ms)
                .slideY(begin: 0.1, end: 0),
            
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _getDataForPeriod(List entries) {
    final now = DateTime.now();
    final days = _selectedPeriod == 'Week' ? 7 : _selectedPeriod == 'Month' ? 30 : 90;
    final dayLabels = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    
    return List.generate(days, (index) {
      final date = now.subtract(Duration(days: days - 1 - index));
      final dayEntries = entries.where((e) =>
        e.recordedAt.year == date.year &&
        e.recordedAt.month == date.month &&
        e.recordedAt.day == date.day
      ).toList();
      
      return {
        'day': _selectedPeriod == 'Week' ? dayLabels[date.weekday - 1] : '${date.day}',
        'hasEntry': dayEntries.isNotEmpty,
        'score': dayEntries.isNotEmpty ? dayEntries.first.finalMoodScore : 0.5,
      };
    });
  }

  Widget _buildMoodTrendCard(List entries) {
    final data = _getDataForPeriod(entries);
    // ignore: unused_local_variable
    final entriesWithData = data.where((d) => d['hasEntry'] as bool).toList();
    
    return Builder(
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Container(
          padding: EdgeInsets.all(20.w),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Mood Trend',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.trending_up, size: 14.sp, color: AppColors.success),
                    SizedBox(width: 4.w),
                    Text(
                      '+8%',
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
            height: 200.h,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: 0.25,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: AppColors.divider,
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 32,
                      interval: _selectedPeriod == 'Week' ? 1 : 7,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (_selectedPeriod == 'Week' && index < data.length) {
                          return Padding(
                            padding: EdgeInsets.only(top: 8.h),
                            child: Text(
                              data[index]['day'] as String,
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          );
                        } else if (_selectedPeriod != 'Week') {
                          return Padding(
                            padding: EdgeInsets.only(top: 8.h),
                            child: Text(
                              '${index + 1}',
                              style: TextStyle(
                                fontSize: 11.sp,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      interval: 0.25,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          '${(value * 100).toInt()}%',
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: AppColors.textSecondary,
                          ),
                        );
                      },
                    ),
                  ),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                borderData: FlBorderData(show: false),
                minX: 0,
                maxX: (data.length - 1).toDouble(),
                minY: 0,
                maxY: 1,
                lineBarsData: [
                  LineChartBarData(
                    spots: data.asMap().entries
                        .where((e) => (e.value['hasEntry'] as bool?) ?? true)
                        .map((e) => FlSpot(
                          e.key.toDouble(), 
                          e.value['score'] as double,
                        ))
                        .toList(),
                    isCurved: true,
                    gradient: AppColors.primaryGradient,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      show: true,
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 4,
                          color: Colors.white,
                          strokeWidth: 2,
                          strokeColor: AppColors.primary,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primary.withOpacity(0.3),
                          AppColors.primary.withOpacity(0.0),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
      }
    );
  }

  Widget _buildStatsOverview(List entries) {
    // Calculate stats from entries
    double avgMood = 0.5;
    String bestDay = 'N/A';
    double bestDayAvg = 0;
    
    if (entries.isNotEmpty) {
      avgMood = entries.map((e) => e.finalMoodScore as double).reduce((a, b) => a + b) / entries.length;
      
      // Find best day of week
      final dayScores = <int, List<double>>{};
      for (final entry in entries) {
        final weekday = entry.recordedAt.weekday;
        dayScores.putIfAbsent(weekday, () => []).add(entry.finalMoodScore);
      }
      
      final dayNames = ['', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
      dayScores.forEach((day, scores) {
        final avg = scores.reduce((a, b) => a + b) / scores.length;
        if (avg > bestDayAvg) {
          bestDayAvg = avg;
          bestDay = dayNames[day];
        }
      });
    }
    
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            'Average Mood',
            '${(avgMood * 100).round()}%',
            Icons.mood,
            AppColors.primary,
            'this period',
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildStatCard(
            'Check-ins',
            '${entries.length}',
            Icons.check_circle_outline,
            AppColors.success,
            'this period',
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: _buildStatCard(
            'Best Day',
            bestDay,
            Icons.star_outline,
            AppColors.warning,
            bestDayAvg > 0 ? '${(bestDayAvg * 100).round()}% avg' : '',
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color, String subtitle) {
    return Builder(
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: isDark ? AppColors.cardDark : Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            children: [
              Icon(icon, color: color, size: 24.sp),
              SizedBox(height: 8.h),
              Text(
                value,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                title,
                style: TextStyle(
                  fontSize: 11.sp,
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 2.h),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 10.sp,
                  color: color,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMoodDistribution(List entries) {
    // Calculate distribution from entries
    int great = 0, good = 0, neutral = 0, low = 0;
    
    for (final entry in entries) {
      final score = entry.finalMoodScore as double;
      if (score >= 0.8) great++;
      else if (score >= 0.6) good++;
      else if (score >= 0.4) neutral++;
      else low++;
    }
    
    final total = entries.length.clamp(1, double.infinity);
    final distribution = [
      {'label': 'Great', 'value': great / total, 'color': AppColors.moodGreat},
      {'label': 'Good', 'value': good / total, 'color': AppColors.moodGood},
      {'label': 'Neutral', 'value': neutral / total, 'color': AppColors.moodNeutral},
      {'label': 'Low', 'value': low / total, 'color': AppColors.moodLow},
    ];
    
    return Builder(
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Container(
          padding: EdgeInsets.all(20.w),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mood Distribution',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                ),
              ),
          SizedBox(height: 20.h),
          Row(
            children: [
              // Pie chart
              SizedBox(
                width: 100.w,
                height: 100.w,
                child: PieChart(
                  PieChartData(
                    sectionsSpace: 2,
                    centerSpaceRadius: 24.r,
                    sections: distribution.map((item) {
                      return PieChartSectionData(
                        value: item['value'] as double,
                        color: item['color'] as Color,
                        radius: 24.r,
                        showTitle: false,
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(width: 24.w),
              // Legend
              Expanded(
                child: Column(
                  children: distribution.map((item) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 4.h),
                      child: Row(
                        children: [
                          Container(
                            width: 12.w,
                            height: 12.w,
                            decoration: BoxDecoration(
                              color: item['color'] as Color,
                              borderRadius: BorderRadius.circular(3.r),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            item['label'] as String,
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${((item['value'] as double) * 100).toInt()}%',
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
      }
    );
  }

  Widget _buildTimeOfDayAnalysis(List entries) {
    // Calculate mood by time of day from entries
    final timeScores = <String, List<double>>{
      'Morning': [],
      'Afternoon': [],
      'Evening': [],
      'Night': [],
    };
    
    for (final entry in entries) {
      final hour = entry.recordedAt.hour;
      String timeOfDay;
      if (hour >= 5 && hour < 12) timeOfDay = 'Morning';
      else if (hour >= 12 && hour < 17) timeOfDay = 'Afternoon';
      else if (hour >= 17 && hour < 21) timeOfDay = 'Evening';
      else timeOfDay = 'Night';
      
      timeScores[timeOfDay]!.add(entry.finalMoodScore);
    }
    
    final timeData = [
      {
        'time': 'Morning', 
        'score': timeScores['Morning']!.isNotEmpty 
            ? timeScores['Morning']!.reduce((a, b) => a + b) / timeScores['Morning']!.length 
            : 0.5, 
        'emoji': '🌅'
      },
      {
        'time': 'Afternoon', 
        'score': timeScores['Afternoon']!.isNotEmpty 
            ? timeScores['Afternoon']!.reduce((a, b) => a + b) / timeScores['Afternoon']!.length 
            : 0.5, 
        'emoji': '☀️'
      },
      {
        'time': 'Evening', 
        'score': timeScores['Evening']!.isNotEmpty 
            ? timeScores['Evening']!.reduce((a, b) => a + b) / timeScores['Evening']!.length 
            : 0.5, 
        'emoji': '🌆'
      },
      {
        'time': 'Night', 
        'score': timeScores['Night']!.isNotEmpty 
            ? timeScores['Night']!.reduce((a, b) => a + b) / timeScores['Night']!.length 
            : 0.5, 
        'emoji': '🌙'
      },
    ];
    
    return Builder(
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Container(
          padding: EdgeInsets.all(20.w),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Mood by Time of Day',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                ),
              ),
          SizedBox(height: 20.h),
          ...timeData.map((item) {
            final score = item['score'] as double;
            return Padding(
              padding: EdgeInsets.only(bottom: 16.h),
              child: Row(
                children: [
                  Text(
                    item['emoji'] as String,
                    style: TextStyle(fontSize: 24.sp),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              item['time'] as String,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              '${(score * 100).toInt()}%',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: AppColors.getMoodColor(score),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 6.h),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(4.r),
                          child: LinearProgressIndicator(
                            value: score,
                            backgroundColor: AppColors.divider,
                            valueColor: AlwaysStoppedAnimation(AppColors.getMoodColor(score)),
                            minHeight: 8.h,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
      }
    );
  }

  Widget _buildPatterns() {
    // Mock patterns for now - will be generated by AI in backend
    final patterns = [
      {'description': 'Your mood tends to be higher on weekends', 'confidence': 0.85},
      {'description': 'Morning check-ins show more positive emotions', 'confidence': 0.78},
      {'description': 'You mention "work" more often on lower mood days', 'confidence': 0.72},
    ];
    
    return Builder(
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Container(
          padding: EdgeInsets.all(20.w),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Patterns Detected',
                    style: TextStyle(
                      fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  '${patterns.length} found',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          ...patterns.map((pattern) {
            return Padding(
              padding: EdgeInsets.only(bottom: 12.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: AppColors.accent.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      Icons.insights,
                      color: AppColors.accent,
                      size: 20.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          pattern['description'] as String,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                            height: 1.4,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          'Confidence: ${((pattern['confidence'] as double) * 100).toInt()}%',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
      }
    );
  }
}
