import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';

class WorkoutSessionScreen extends StatefulWidget {
  final String workoutType;
  final String emoji;
  final Color color;
  final int durationMinutes;

  const WorkoutSessionScreen({
    super.key,
    required this.workoutType,
    required this.emoji,
    required this.color,
    required this.durationMinutes,
  });

  @override
  State<WorkoutSessionScreen> createState() => _WorkoutSessionScreenState();
}

class _WorkoutSessionScreenState extends State<WorkoutSessionScreen> {
  late Timer _timer;
  late int _secondsRemaining;
  int _currentExerciseIndex = 0;
  bool _isPaused = false;
  bool _isResting = false;
  int _restSeconds = 0;
  
  late List<Map<String, dynamic>> _exercises;

  @override
  void initState() {
    super.initState();
    _exercises = _getExercisesForType(widget.workoutType);
    _secondsRemaining = widget.durationMinutes * 60;
    _startTimer();
  }

  List<Map<String, dynamic>> _getExercisesForType(String type) {
    switch (type) {
      case 'Gentle Stretching':
        return [
          {'name': 'Neck Rolls', 'duration': 30, 'emoji': '🙆', 'instruction': 'Slowly roll your head in circles, 5 times each direction'},
          {'name': 'Shoulder Shrugs', 'duration': 30, 'emoji': '💪', 'instruction': 'Raise shoulders to ears, hold, release. Repeat 10 times'},
          {'name': 'Arm Circles', 'duration': 30, 'emoji': '🔄', 'instruction': 'Extend arms and make small circles, gradually increasing size'},
          {'name': 'Side Stretch', 'duration': 45, 'emoji': '🌊', 'instruction': 'Reach one arm overhead and lean to the opposite side'},
          {'name': 'Forward Fold', 'duration': 45, 'emoji': '🧘', 'instruction': 'Slowly bend forward, letting arms hang. Breathe deeply'},
          {'name': 'Cat-Cow Stretch', 'duration': 45, 'emoji': '🐱', 'instruction': 'On hands and knees, alternate arching and rounding back'},
          {'name': 'Child\'s Pose', 'duration': 60, 'emoji': '🙏', 'instruction': 'Kneel and stretch arms forward, resting forehead on floor'},
          {'name': 'Gentle Twist', 'duration': 45, 'emoji': '🔃', 'instruction': 'Seated, twist gently to each side, hold for 5 breaths'},
        ];
      case 'Dance Break':
        return [
          {'name': 'Warm Up Sway', 'duration': 30, 'emoji': '🎵', 'instruction': 'Sway side to side, loosening up your body'},
          {'name': 'Step Touch', 'duration': 45, 'emoji': '👟', 'instruction': 'Step to the side and bring feet together, alternate sides'},
          {'name': 'Arm Waves', 'duration': 30, 'emoji': '🌊', 'instruction': 'Flow your arms like waves while stepping'},
          {'name': 'Hip Circles', 'duration': 45, 'emoji': '💃', 'instruction': 'Circle your hips while keeping upper body stable'},
          {'name': 'Free Style!', 'duration': 90, 'emoji': '🎉', 'instruction': 'Let loose! Move however feels good to you'},
          {'name': 'Grapevine', 'duration': 45, 'emoji': '🍇', 'instruction': 'Step side, behind, side, touch - alternate directions'},
          {'name': 'Shimmy Shake', 'duration': 45, 'emoji': '✨', 'instruction': 'Shake your shoulders and have fun with it!'},
          {'name': 'Cool Down Sway', 'duration': 30, 'emoji': '😌', 'instruction': 'Slow it down, gentle movements to cool off'},
        ];
      case 'Quick HIIT':
        return [
          {'name': 'Jumping Jacks', 'duration': 30, 'emoji': '⭐', 'instruction': 'Classic jumping jacks - go at your own pace!'},
          {'name': 'High Knees', 'duration': 30, 'emoji': '🦵', 'instruction': 'March or run in place, bringing knees up high'},
          {'name': 'Squats', 'duration': 30, 'emoji': '🏋️', 'instruction': 'Feet shoulder-width, sit back like sitting in a chair'},
          {'name': 'Mountain Climbers', 'duration': 30, 'emoji': '🏔️', 'instruction': 'Plank position, alternate driving knees to chest'},
          {'name': 'Burpees (Modified OK!)', 'duration': 30, 'emoji': '💥', 'instruction': 'Squat, hands down, step or jump back, return, stand'},
          {'name': 'Plank Hold', 'duration': 30, 'emoji': '🧱', 'instruction': 'Hold plank position - on knees if needed'},
          {'name': 'Lunges', 'duration': 30, 'emoji': '🦿', 'instruction': 'Alternate stepping forward into lunges'},
          {'name': 'Cool Down Stretch', 'duration': 60, 'emoji': '😮‍💨', 'instruction': 'Slow stretches - you did amazing!'},
        ];
      default: // Default gentle workout
        return [
          {'name': 'Deep Breathing', 'duration': 60, 'emoji': '🌬️', 'instruction': 'Stand tall, breathe deeply through your nose'},
          {'name': 'Gentle March', 'duration': 60, 'emoji': '🚶', 'instruction': 'March in place at a comfortable pace'},
          {'name': 'Arm Reaches', 'duration': 45, 'emoji': '🙌', 'instruction': 'Reach arms up overhead alternately'},
          {'name': 'Side Steps', 'duration': 60, 'emoji': '👟', 'instruction': 'Step side to side, swinging arms gently'},
          {'name': 'Ankle Circles', 'duration': 30, 'emoji': '🦶', 'instruction': 'Lift one foot and rotate ankle, switch sides'},
          {'name': 'Final Stretch', 'duration': 45, 'emoji': '🧘', 'instruction': 'Stretch however feels good to your body'},
        ];
    }
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isPaused) {
        setState(() {
          if (_isResting) {
            _restSeconds--;
            if (_restSeconds <= 0) {
              _isResting = false;
              _currentExerciseIndex++;
            }
          } else {
            _secondsRemaining--;
          }
          
          if (_secondsRemaining <= 0) {
            _timer.cancel();
            _showCompletionDialog();
          }
        });
      }
    });
  }

  void _nextExercise() {
    if (_currentExerciseIndex < _exercises.length - 1) {
      setState(() {
        _isResting = true;
        _restSeconds = 10;
      });
    }
  }

  void _previousExercise() {
    if (_currentExerciseIndex > 0) {
      setState(() {
        _currentExerciseIndex--;
        _isResting = false;
      });
    }
  }

  void _togglePause() {
    setState(() {
      _isPaused = !_isPaused;
    });
  }

  void _showCompletionDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return AlertDialog(
          backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('🎉', style: TextStyle(fontSize: 64.sp))
                  .animate(onPlay: (c) => c.repeat())
                  .shimmer(duration: 1200.ms, color: widget.color),
              SizedBox(height: 16.h),
              Text(
                'Workout Complete!',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Amazing job completing your ${widget.workoutType}! 💪',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: widget.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStat('Duration', '${widget.durationMinutes} min', Icons.timer),
                    _buildStat('Exercises', '${_exercises.length}', Icons.fitness_center),
                  ],
                ),
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: widget.color,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                  ),
                  child: const Text('Done', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStat(String label, String value, IconData icon) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Icon(icon, color: widget.color, size: 24.sp),
        SizedBox(height: 4.h),
        Text(value, style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold, color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary)),
        Text(label, style: TextStyle(fontSize: 12.sp, color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary)),
      ],
    );
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final currentExercise = _currentExerciseIndex < _exercises.length 
        ? _exercises[_currentExerciseIndex] 
        : _exercises.last;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => _showExitDialog(),
                    child: Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: isDark ? AppColors.cardDark : Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(Icons.close, color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary),
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        widget.workoutType,
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 48.w),
                ],
              ),
            ),
            
            // Timer
            Container(
              margin: EdgeInsets.symmetric(horizontal: 24.w),
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: widget.color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(24.r),
              ),
              child: Column(
                children: [
                  Text(
                    'Time Remaining',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    _formatTime(_secondsRemaining),
                    style: TextStyle(
                      fontSize: 48.sp,
                      fontWeight: FontWeight.bold,
                      color: widget.color,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  LinearProgressIndicator(
                    value: 1 - (_secondsRemaining / (widget.durationMinutes * 60)),
                    backgroundColor: widget.color.withOpacity(0.2),
                    valueColor: AlwaysStoppedAnimation<Color>(widget.color),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 24.h),
            
            // Current Exercise
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 24.w),
                padding: EdgeInsets.all(32.w),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.cardDark : Colors.white,
                  borderRadius: BorderRadius.circular(24.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: _isResting
                    ? _buildRestScreen()
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            currentExercise['emoji'] as String,
                            style: TextStyle(fontSize: 72.sp),
                          ).animate(onPlay: (c) => c.repeat(reverse: true))
                              .scale(begin: const Offset(1, 1), end: const Offset(1.1, 1.1), duration: 1000.ms),
                          SizedBox(height: 24.h),
                          Text(
                            currentExercise['name'] as String,
                            style: TextStyle(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.bold,
                              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 16.h),
                          Text(
                            currentExercise['instruction'] as String,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                              height: 1.5,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: 24.h),
                          Text(
                            'Exercise ${_currentExerciseIndex + 1} of ${_exercises.length}',
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: widget.color,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            
            SizedBox(height: 24.h),
            
            // Controls
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildControlButton(
                    Icons.skip_previous,
                    'Previous',
                    _previousExercise,
                    enabled: _currentExerciseIndex > 0,
                  ),
                  GestureDetector(
                    onTap: _togglePause,
                    child: Container(
                      width: 80.w,
                      height: 80.w,
                      decoration: BoxDecoration(
                        color: widget.color,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: widget.color.withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: Icon(
                        _isPaused ? Icons.play_arrow : Icons.pause,
                        color: Colors.white,
                        size: 40.sp,
                      ),
                    ),
                  ),
                  _buildControlButton(
                    Icons.skip_next,
                    'Next',
                    _nextExercise,
                    enabled: _currentExerciseIndex < _exercises.length - 1,
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 64.h),
          ],
        ),
      ),
    );
  }

  Widget _buildRestScreen() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('💨', style: TextStyle(fontSize: 64.sp))
            .animate(onPlay: (c) => c.repeat(reverse: true))
            .scale(duration: 500.ms),
        SizedBox(height: 24.h),
        Text(
          'Rest',
          style: TextStyle(
            fontSize: 32.sp,
            fontWeight: FontWeight.bold,
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          '$_restSeconds seconds',
          style: TextStyle(
            fontSize: 48.sp,
            fontWeight: FontWeight.bold,
            color: widget.color,
          ),
        ),
        SizedBox(height: 16.h),
        Text(
          'Next: ${_exercises[_currentExerciseIndex + 1]['name']}',
          style: TextStyle(
            fontSize: 16.sp,
            color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildControlButton(IconData icon, String label, VoidCallback onTap, {bool enabled = true}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Column(
        children: [
          Container(
            width: 56.w,
            height: 56.w,
            decoration: BoxDecoration(
              color: enabled
                  ? (isDark ? AppColors.cardDark : Colors.white)
                  : Colors.grey.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: enabled
                  ? (isDark ? AppColors.textPrimaryDark : AppColors.textPrimary)
                  : Colors.grey,
              size: 28.sp,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            label,
            style: TextStyle(
              fontSize: 12.sp,
              color: enabled
                  ? (isDark ? AppColors.textSecondaryDark : AppColors.textSecondary)
                  : Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  void _showExitDialog() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
        title: Text(
          'End Workout?',
          style: TextStyle(color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary),
        ),
        content: Text(
          'Are you sure you want to end this workout session?',
          style: TextStyle(color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text('Continue', style: TextStyle(color: widget.color)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              Navigator.of(context).pop();
            },
            child: const Text('End', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
