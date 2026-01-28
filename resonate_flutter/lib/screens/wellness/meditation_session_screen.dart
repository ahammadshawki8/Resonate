import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';

class MeditationSessionScreen extends StatefulWidget {
  final String meditationType;
  final int durationMinutes;
  final IconData icon;
  final Color color;

  const MeditationSessionScreen({
    super.key,
    required this.meditationType,
    required this.durationMinutes,
    required this.icon,
    required this.color,
  });

  @override
  State<MeditationSessionScreen> createState() => _MeditationSessionScreenState();
}

class _MeditationSessionScreenState extends State<MeditationSessionScreen>
    with TickerProviderStateMixin {
  late Timer _timer;
  late int _secondsRemaining;
  bool _isPaused = false;
  bool _isStarted = false;
  int _currentPhaseIndex = 0;
  late AnimationController _breathController;
  late Animation<double> _breathAnimation;
  
  late List<Map<String, dynamic>> _phases;

  @override
  void initState() {
    super.initState();
    _phases = _getPhasesForType(widget.meditationType);
    _secondsRemaining = widget.durationMinutes * 60;
    
    _breathController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    );
    
    _breathAnimation = Tween<double>(begin: 1.0, end: 1.4).animate(
      CurvedAnimation(parent: _breathController, curve: Curves.easeInOut),
    );
  }

  List<Map<String, dynamic>> _getPhasesForType(String type) {
    switch (type) {
      case 'Quick Reset':
        return [
          {'text': 'Find a comfortable position...', 'duration': 20, 'breathe': false},
          {'text': 'Close your eyes and take a deep breath...', 'duration': 15, 'breathe': true},
          {'text': 'Let go of any tension in your body...', 'duration': 20, 'breathe': true},
          {'text': 'Focus only on this present moment...', 'duration': 20, 'breathe': true},
          {'text': 'With each breath, feel more centered...', 'duration': 25, 'breathe': true},
          {'text': 'You are calm. You are present.', 'duration': 20, 'breathe': true},
          {'text': 'Slowly bring awareness back...', 'duration': 20, 'breathe': false},
          {'text': 'When ready, gently open your eyes.', 'duration': 20, 'breathe': false},
        ];
      case 'Body Scan':
        return [
          {'text': 'Lie down or sit comfortably...', 'duration': 20, 'breathe': false},
          {'text': 'Take three deep breaths...', 'duration': 25, 'breathe': true},
          {'text': 'Bring awareness to your feet...', 'duration': 30, 'breathe': true},
          {'text': 'Notice any sensations in your legs...', 'duration': 35, 'breathe': true},
          {'text': 'Scan up through your hips and abdomen...', 'duration': 35, 'breathe': true},
          {'text': 'Feel your chest rise and fall...', 'duration': 30, 'breathe': true},
          {'text': 'Relax your shoulders and arms...', 'duration': 30, 'breathe': true},
          {'text': 'Release tension in your neck and face...', 'duration': 30, 'breathe': true},
          {'text': 'Feel your whole body at peace...', 'duration': 35, 'breathe': true},
          {'text': 'Gently wiggle your fingers and toes...', 'duration': 20, 'breathe': false},
        ];
      case 'Loving Kindness':
        return [
          {'text': 'Settle into a comfortable position...', 'duration': 30, 'breathe': false},
          {'text': 'Place a hand on your heart...', 'duration': 25, 'breathe': false},
          {'text': 'May I be happy...', 'duration': 40, 'breathe': true},
          {'text': 'May I be healthy...', 'duration': 40, 'breathe': true},
          {'text': 'May I be safe...', 'duration': 40, 'breathe': true},
          {'text': 'May I live with ease...', 'duration': 40, 'breathe': true},
          {'text': 'Think of someone you love...', 'duration': 30, 'breathe': false},
          {'text': 'May they be happy...', 'duration': 40, 'breathe': true},
          {'text': 'May they be healthy...', 'duration': 40, 'breathe': true},
          {'text': 'May they be safe...', 'duration': 40, 'breathe': true},
          {'text': 'Extend this love to all beings...', 'duration': 50, 'breathe': true},
          {'text': 'May all beings be happy and free.', 'duration': 45, 'breathe': true},
          {'text': 'Rest in this feeling of love...', 'duration': 40, 'breathe': true},
        ];
      case 'Deep Relaxation':
        return [
          {'text': 'Find a quiet, comfortable space...', 'duration': 30, 'breathe': false},
          {'text': 'Let your body sink into the surface below...', 'duration': 40, 'breathe': true},
          {'text': 'Breathe in relaxation...', 'duration': 35, 'breathe': true},
          {'text': 'Breathe out tension...', 'duration': 35, 'breathe': true},
          {'text': 'Your body is becoming heavier...', 'duration': 45, 'breathe': true},
          {'text': 'Let every muscle relax completely...', 'duration': 50, 'breathe': true},
          {'text': 'There is nothing to do right now...', 'duration': 45, 'breathe': true},
          {'text': 'Just be. Just breathe.', 'duration': 60, 'breathe': true},
          {'text': 'You are safe. You are at peace.', 'duration': 50, 'breathe': true},
          {'text': 'Let this peace fill every cell...', 'duration': 50, 'breathe': true},
          {'text': 'Drift deeper into relaxation...', 'duration': 60, 'breathe': true},
          {'text': 'Pure tranquility surrounds you...', 'duration': 60, 'breathe': true},
          {'text': 'When ready, slowly return...', 'duration': 40, 'breathe': false},
          {'text': 'Carry this peace with you.', 'duration': 40, 'breathe': false},
        ];
      default:
        return [
          {'text': 'Find a comfortable position...', 'duration': 30, 'breathe': false},
          {'text': 'Focus on your breath...', 'duration': 40, 'breathe': true},
          {'text': 'Let thoughts come and go...', 'duration': 50, 'breathe': true},
          {'text': 'Return to your breath...', 'duration': 50, 'breathe': true},
          {'text': 'You are present. You are calm.', 'duration': 50, 'breathe': true},
        ];
    }
  }

  void _startMeditation() {
    setState(() {
      _isStarted = true;
    });
    _breathController.repeat(reverse: true);
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!_isPaused) {
        setState(() {
          _secondsRemaining--;
          
          // Calculate which phase we should be in
          int elapsed = (widget.durationMinutes * 60) - _secondsRemaining;
          int totalPhaseTime = 0;
          for (int i = 0; i < _phases.length; i++) {
            totalPhaseTime += _phases[i]['duration'] as int;
            if (elapsed < totalPhaseTime) {
              if (_currentPhaseIndex != i) {
                _currentPhaseIndex = i;
              }
              break;
            }
          }
          
          if (_secondsRemaining <= 0) {
            _timer.cancel();
            _showCompletionDialog();
          }
        });
      }
    });
  }

  void _togglePause() {
    setState(() {
      _isPaused = !_isPaused;
      if (_isPaused) {
        _breathController.stop();
      } else {
        _breathController.repeat(reverse: true);
      }
    });
  }

  void _showCompletionDialog() {
    _breathController.stop();
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
              Text('🧘', style: TextStyle(fontSize: 64.sp))
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .scale(delay: 200.ms),
              SizedBox(height: 16.h),
              Text(
                'Namaste 🙏',
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Your meditation is complete.\nCarry this peace with you.',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                  height: 1.5,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.self_improvement, color: widget.color, size: 24.sp),
                    SizedBox(width: 12.w),
                    Text(
                      '${widget.durationMinutes} minutes of mindfulness',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: widget.color,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    if (_isStarted) _timer.cancel();
    _breathController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    if (!_isStarted) {
      return _buildStartScreen(isDark);
    }

    final currentPhase = _currentPhaseIndex < _phases.length 
        ? _phases[_currentPhaseIndex] 
        : _phases.last;
    final showBreathGuide = currentPhase['breathe'] as bool;

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1a1a2e) : const Color(0xFFF5F3FF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top - MediaQuery.of(context).padding.bottom,
            ),
            child: Column(
              children: [
                // Header
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => _showExitDialog(),
                        child: Container(
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                            color: isDark ? Colors.white.withOpacity(0.1) : Colors.white,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          child: Icon(Icons.close, size: 20.sp, color: isDark ? Colors.white70 : AppColors.textPrimary),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            widget.meditationType,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: isDark ? Colors.white : AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 40.w),
                    ],
                  ),
                ),
                
                // Timer
                Padding(
                  padding: EdgeInsets.only(top: 4.h),
                  child: Text(
                    _formatTime(_secondsRemaining),
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w300,
                      color: isDark ? Colors.white60 : AppColors.textSecondary,
                    ),
                  ),
                ),
                
                // Main Content
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Breathing Circle
                        if (showBreathGuide) ...[
                          AnimatedBuilder(
                            animation: _breathAnimation,
                            builder: (context, child) {
                              return Container(
                                width: 150.w * _breathAnimation.value,
                                height: 150.w * _breathAnimation.value,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: RadialGradient(
                                    colors: [
                                      widget.color.withOpacity(0.4),
                                      widget.color.withOpacity(0.1),
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: widget.color.withOpacity(0.3),
                                      blurRadius: 40,
                                      spreadRadius: 10,
                                    ),
                                  ],
                                ),
                                child: Center(
                                  child: Container(
                                    width: 100.w * _breathAnimation.value,
                                    height: 100.w * _breathAnimation.value,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: widget.color.withOpacity(0.2),
                                    ),
                                    child: Center(
                                      child: Text(
                                        _breathAnimation.value > 1.2 ? 'Breathe In' : 'Breathe Out',
                                        style: TextStyle(
                                          fontSize: 13.sp,
                                          color: isDark ? Colors.white : widget.color,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                          SizedBox(height: 32.h),
                        ] else ...[
                          Icon(
                            widget.icon,
                            size: 64.sp,
                            color: widget.color.withOpacity(0.6),
                          ).animate(onPlay: (c) => c.repeat(reverse: true))
                              .scale(begin: const Offset(1, 1), end: const Offset(1.1, 1.1), duration: 2000.ms),
                          SizedBox(height: 32.h),
                        ],
                        
                        // Guidance Text
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 28.w),
                          child: Text(
                            currentPhase['text'] as String,
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w300,
                              color: isDark ? Colors.white : AppColors.textPrimary,
                              height: 1.3,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ).animate(key: ValueKey(_currentPhaseIndex))
                              .fadeIn(duration: 800.ms),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Controls
                Padding(
                  padding: EdgeInsets.only(top: 16.h, bottom: 24.h),
                  child: GestureDetector(
                    onTap: _togglePause,
                    child: Container(
                      width: 64.w,
                      height: 64.w,
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
                        size: 32.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStartScreen(bool isDark) {
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1a1a2e) : const Color(0xFFF5F3FF),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: isDark ? Colors.white.withOpacity(0.1) : Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Icon(Icons.arrow_back, size: 20.sp, color: isDark ? Colors.white70 : AppColors.textPrimary),
                      ),
                    ),
                  ],
                ),
              ),
              
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 20.h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100.w,
                      height: 100.w,
                      decoration: BoxDecoration(
                        color: widget.color.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(widget.icon, size: 50.sp, color: widget.color),
                    ).animate().fadeIn(duration: 600.ms).scale(delay: 200.ms),
                    
                    SizedBox(height: 24.h),
                    
                    Text(
                      widget.meditationType,
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : AppColors.textPrimary,
                      ),
                    ).animate().fadeIn(delay: 200.ms),
                    
                    SizedBox(height: 6.h),
                    
                    Text(
                      '${widget.durationMinutes} minutes',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: isDark ? Colors.white60 : AppColors.textSecondary,
                      ),
                    ).animate().fadeIn(delay: 300.ms),
                    
                    SizedBox(height: 24.h),
                    
                    Container(
                      padding: EdgeInsets.all(20.w),
                      decoration: BoxDecoration(
                        color: isDark ? Colors.white.withOpacity(0.05) : Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Column(
                        children: [
                          Text(
                            'Before you begin:',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: isDark ? Colors.white : AppColors.textPrimary,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          ...[
                            '🔇 Find a quiet space',
                            '🪑 Sit or lie comfortably',
                            '👁️ You may close your eyes',
                            '🌬️ Follow the breathing guide',
                          ].map((tip) => Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.h),
                            child: Text(
                              tip,
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: isDark ? Colors.white70 : AppColors.textSecondary,
                              ),
                            ),
                          )),
                        ],
                      ),
                    ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1, end: 0),
                    
                    SizedBox(height: 32.h),
                    
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _startMeditation,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: widget.color,
                          padding: EdgeInsets.symmetric(vertical: 18.h),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                        ),
                        child: Text(
                          'Begin Meditation',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ).animate().fadeIn(delay: 500.ms).slideY(begin: 0.2, end: 0),
                    
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ],
          ),
        ),
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
          'End Meditation?',
          style: TextStyle(color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary),
        ),
        content: Text(
          'Are you sure you want to end this session?',
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
