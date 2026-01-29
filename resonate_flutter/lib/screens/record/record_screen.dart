import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../core/services/audio_service.dart';
import '../../data/repositories/repositories.dart';
import '../../data/models/models.dart';
import '../../providers/app_providers.dart';

class RecordScreen extends ConsumerStatefulWidget {
  const RecordScreen({super.key});

  @override
  ConsumerState<RecordScreen> createState() => _RecordScreenState();
}

class _RecordScreenState extends ConsumerState<RecordScreen>
    with TickerProviderStateMixin {
  bool _isRecording = false;
  bool _isAnalyzing = false;
  int _recordingSeconds = 0;
  Timer? _timer;
  final List<double> _waveformData = [];
  // Removed unused _random
  String _selectedLanguage = 'English';

  // Transcripts and analysis now come from backend

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startRecording() async {
    debugPrint('Starting recording...');
    
    // Start actual audio recording
    final path = await AudioService.startRecording();
    
    if (path == null) {
      debugPrint('Failed to start recording - no path returned');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Failed to start recording. Please check microphone permissions.'),
          backgroundColor: AppColors.error,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
      );
      return;
    }
    
    debugPrint('Recording started at: $path');
    
    ref.read(recordingProvider.notifier).startRecording();
    setState(() {
      _isRecording = true;
      _recordingSeconds = 0;
      _waveformData.clear();
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _recordingSeconds++;
        // Generate realistic waveform data based on time
        // Simulate varying audio levels
        final random = Random();
        for (int i = 0; i < 5; i++) {
          // Create more natural looking waveform
          final baseLevel = 0.3 + (random.nextDouble() * 0.4);
          final variation = (random.nextDouble() - 0.5) * 0.2;
          _waveformData.add((baseLevel + variation).clamp(0.1, 0.9));
        }
        // Keep only last 150 data points for smooth animation
        if (_waveformData.length > 150) {
          _waveformData.removeRange(0, _waveformData.length - 150);
        }
      });

      // Auto-stop after 60 seconds
      if (_recordingSeconds >= 60) {
        _stopRecording();
      }
    });
  }

  void _stopRecording() {
    _timer?.cancel();

    if (_recordingSeconds < 5) {
      // Too short - cancel the recording
      AudioService.cancelRecording();
      ref.read(recordingProvider.notifier).stopRecording();
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Please record for at least 5 seconds'),
          backgroundColor: AppColors.warning,
          behavior: SnackBarBehavior.floating,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        ),
      );
      setState(() {
        _isRecording = false;
        _recordingSeconds = 0;
        _waveformData.clear();
      });
      return;
    }

    setState(() {
      _isRecording = false;
      _isAnalyzing = true;
    });

    // Perform analysis
    _performAnalysis();
  }

  Future<void> _performAnalysis() async {
    try {
      // Stop recording and get file path
      final audioPath = await AudioService.stopRecording();
      
      // Update provider state
      ref.read(recordingProvider.notifier).stopRecording();
      
      if (audioPath == null || audioPath.isEmpty) {
        throw Exception('Failed to get recording path');
      }

      debugPrint('Got recording path: $audioPath');

      // Get language code
      final languageCode = _selectedLanguage == 'বাংলা' ? 'bn' : 'en';
      
      // Get privacy level from settings
      final privacyLevel = ref.read(settingsProvider).privacyLevel;

      debugPrint('Uploading audio file...');
      
      // Upload and analyze with longer timeout (5 minutes for Whisper processing)
      final result = await VoiceEntryRepository.instance.uploadAndAnalyze(
        audioFilePath: audioPath,
        language: languageCode,
        privacyLevel: privacyLevel,
      ).timeout(
        const Duration(minutes: 5),
        onTimeout: () {
          throw TimeoutException('Analysis is taking longer than expected. Please try with a shorter recording.');
        },
      );

      debugPrint('Analysis complete!');

      // Store result in provider for ResultScreen to access
      ref.read(analysisResultProvider.notifier).state = AnalysisResult(
        moodScore: result.entry.finalMoodScore,
        moodLabel: result.entry.moodLabel,
        transcript: result.entry.transcript ?? '',
        emotions: result.entry.detectedEmotions,
        detailedEmotions: const [], // TODO: Map from backend if available
        personalizedResponse: null, // TODO: Map from backend if available
        confidence: result.entry.confidence,
        acousticScore: result.entry.acousticMoodScore,
        semanticScore: result.entry.semanticMoodScore,
        language: result.entry.language,
        duration: result.entry.durationSeconds,
      );

      // Refresh entries list
      await ref.read(entriesProvider.notifier).fetchEntries();

      // Navigate to result screen
      if (mounted) {
        context.go('/result');
      }
    } on TimeoutException catch (e) {
      debugPrint('Timeout error: $e');
      if (mounted) {
        setState(() {
          _isAnalyzing = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.message ?? 'Request timed out'),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        );
      }
    } catch (e) {
      debugPrint('Analysis error: $e');
      if (mounted) {
        setState(() {
          _isAnalyzing = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Analysis failed: ${e.toString()}'),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        );
      }
    }
  }

  // Removed unused _getMoodLabel

  void _showLanguageSelector() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.cardDark : Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: isDark ? AppColors.dividerDark : AppColors.divider,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              'Select Language',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 24.h),
            _buildLanguageOption('🇺🇸', 'English'),
            SizedBox(height: 12.h),
            _buildLanguageOption('🇧🇩', 'বাংলা'),
            SizedBox(height: MediaQuery.of(context).padding.bottom + 16.h),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(String flag, String language) {
    final isSelected = _selectedLanguage == language;
    return GestureDetector(
      onTap: () {
        setState(() => _selectedLanguage = language);
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withOpacity(0.1)
              : AppColors.background,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.transparent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Text(flag, style: TextStyle(fontSize: 24.sp)),
            SizedBox(width: 16.w),
            Text(
              language,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
            const Spacer(),
            if (isSelected)
              Icon(Icons.check_circle, color: AppColors.primary, size: 24.sp),
          ],
        ),
      ),
    );
  }

  String _formatDuration(int seconds) {
    final mins = seconds ~/ 60;
    final secs = seconds % 60;
    return '${mins.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    if (_isAnalyzing) {
      return _buildAnalyzingScreen();
    }

    return Scaffold(
      body: Builder(builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return SafeArea(
          child: Column(
            children: [
              // Header
              Padding(
                padding: EdgeInsets.all(20.w),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Container(
                        padding: EdgeInsets.all(10.w),
                        decoration: BoxDecoration(
                          color: isDark ? AppColors.cardDark : Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  Colors.black.withOpacity(isDark ? 0.2 : 0.05),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.close_rounded,
                          color: AppColors.textPrimary,
                          size: 24.sp,
                        ),
                      ),
                    ),
                    const Spacer(),
                    // Language selector
                    GestureDetector(
                      onTap: _showLanguageSelector,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.w, vertical: 8.h),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Text(
                              _selectedLanguage == 'English' ? '🇺🇸' : '🇧🇩',
                              style: TextStyle(fontSize: 18.sp),
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              _selectedLanguage,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textPrimary,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Icon(
                              Icons.keyboard_arrow_down_rounded,
                              size: 20.sp,
                              color: AppColors.textSecondary,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Main content
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Emoji and prompt
                  if (!_isRecording) ...[
                    Text(
                      '🎤',
                      style: TextStyle(fontSize: 64.sp),
                    ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(
                          begin: const Offset(1, 1),
                          end: const Offset(1.1, 1.1),
                          duration: 1500.ms,
                        ),
                    SizedBox(height: 24.h),
                    Text(
                      'Tap to start recording',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Speak naturally for 30-60 seconds',
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ] else ...[
                    // Recording indicator
                    _buildWaveform(),
                    SizedBox(height: 32.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 12.w,
                          height: 12.w,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        )
                            .animate(onPlay: (c) => c.repeat(reverse: true))
                            .fadeIn(duration: 600.ms),
                        SizedBox(width: 8.w),
                        Text(
                          'Recording...',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      _formatDuration(_recordingSeconds),
                      style: TextStyle(
                        fontSize: 48.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ],
              ),

              const Spacer(),

              // Record button
              GestureDetector(
                onTap: _isRecording ? _stopRecording : _startRecording,
                child: Container(
                  width: 100.w,
                  height: 100.w,
                  decoration: BoxDecoration(
                    gradient: _isRecording
                        ? LinearGradient(
                            colors: [Colors.red.shade400, Colors.red.shade600],
                          )
                        : AppColors.primaryGradient,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: (_isRecording ? Colors.red : AppColors.primary)
                            .withOpacity(0.4),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Icon(
                      _isRecording ? Icons.stop_rounded : Icons.mic_rounded,
                      color: Colors.white,
                      size: 48.sp,
                    ),
                  ),
                ).animate(target: _isRecording ? 1 : 0).custom(
                      duration: 600.ms,
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: 1 + sin(value * 3.14159) * 0.05,
                          child: child,
                        );
                      },
                    ),
              ),

              SizedBox(height: 20.h),

              // Hint text
              Text(
                _isRecording ? 'Tap to stop' : 'Press and hold to record',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: AppColors.textSecondary,
                ),
              ),

              SizedBox(height: 48.h),

              // Tips section
              if (!_isRecording)
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 24.w),
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Row(
                    children: [
                      Text(
                        '💡',
                        style: TextStyle(fontSize: 24.sp),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          'Talk about how your day went, what\'s on your mind, or just express yourself freely.',
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: AppColors.textSecondary,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              SizedBox(height: 32.h),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildWaveform() {
    final barCount = 50;
    final dataLength = _waveformData.length;
    
    return Container(
      height: 140.h,
      width: MediaQuery.of(context).size.width - 40.w,
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Glow effect background
          Container(
            height: 100.h,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  AppColors.primary.withOpacity(0.15),
                  Colors.transparent,
                ],
              ),
            ),
          ),
          
          // Waveform bars
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List.generate(
              barCount,
              (index) {
                double height;
                if (dataLength == 0) {
                  height = 12.h;
                } else if (index < barCount - dataLength) {
                  height = 12.h;
                } else {
                  final dataIndex = index - (barCount - dataLength);
                  height = _waveformData[dataIndex] * 80.h;
                }

                // Create mirror effect for symmetry
                final distanceFromCenter = (index - barCount / 2).abs();
                final symmetryFactor = 1 - (distanceFromCenter / (barCount / 2)) * 0.3;
                height = height * symmetryFactor;

                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 0.5.w),
                  width: 3.w,
                  height: height.clamp(12.h, 80.h),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        AppColors.primary,
                        AppColors.primary.withOpacity(0.7),
                        AppColors.primary.withOpacity(0.4),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(2.r),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.4),
                        blurRadius: 6,
                        spreadRadius: 0.5,
                      ),
                    ],
                  ),
                ).animate(
                  onPlay: (controller) => controller.repeat(reverse: true),
                ).shimmer(
                  duration: (1200 + (index % 5) * 100).ms,
                  color: Colors.white.withOpacity(0.3),
                  angle: 90,
                ).scale(
                  begin: const Offset(1, 0.96),
                  end: const Offset(1, 1.04),
                  duration: (800 + (index % 3) * 100).ms,
                );
              },
            ),
          ),
          
          // Center pulse indicator
          Container(
            width: 6.w,
            height: 6.w,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.6),
                  blurRadius: 10,
                  spreadRadius: 3,
                ),
              ],
            ),
          ).animate(onPlay: (c) => c.repeat())
            .scale(
              begin: const Offset(1, 1),
              end: const Offset(1.3, 1.3),
              duration: 1000.ms,
            )
            .fadeOut(duration: 1000.ms),
        ],
      ),
    );
  }

  Widget _buildAnalyzingScreen() {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated analyzing icon
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: 150.w,
                    height: 150.w,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                  )
                      .animate(onPlay: (c) => c.repeat())
                      .scale(
                        begin: const Offset(1, 1),
                        end: const Offset(1.2, 1.2),
                        duration: 1500.ms,
                      )
                      .fadeOut(duration: 1500.ms),
                  Container(
                    width: 120.w,
                    height: 120.w,
                    decoration: BoxDecoration(
                      gradient: AppColors.primaryGradient,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '🔮',
                        style: TextStyle(fontSize: 48.sp),
                      ),
                    ),
                  ).animate(onPlay: (c) => c.repeat(reverse: true)).scale(
                        begin: const Offset(1, 1),
                        end: const Offset(1.05, 1.05),
                        duration: 800.ms,
                      ),
                ],
              ),

              SizedBox(height: 40.h),

              Text(
                'Analyzing your voice...',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),

              SizedBox(height: 16.h),

              // Analysis steps
              _buildAnalysisStep('Extracting acoustic features', true),
              _buildAnalysisStep('Transcribing speech', true),
              _buildAnalysisStep('Analyzing sentiment', false),
              _buildAnalysisStep('Generating insights', false),

              SizedBox(height: 32.h),

              SizedBox(
                width: 200.w,
                child: LinearProgressIndicator(
                  backgroundColor: AppColors.divider,
                  valueColor: AlwaysStoppedAnimation(AppColors.primary),
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnalysisStep(String text, bool completed) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (completed)
            Icon(
              Icons.check_circle,
              color: AppColors.success,
              size: 18.sp,
            ).animate().scale(
                begin: const Offset(0, 0),
                end: const Offset(1, 1),
                duration: 300.ms)
          else
            SizedBox(
              width: 18.sp,
              height: 18.sp,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation(AppColors.primary),
              ),
            ),
          SizedBox(width: 10.w),
          Text(
            text,
            style: TextStyle(
              fontSize: 14.sp,
              color: completed ? AppColors.success : AppColors.textSecondary,
              fontWeight: completed ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
