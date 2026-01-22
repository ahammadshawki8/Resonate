import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/shared_widgets.dart';
import '../../providers/app_providers.dart';
import '../../data/models/models.dart';
import '../wellness/workout_session_screen.dart';
import '../wellness/meditation_session_screen.dart';
import '../wellness/music_player_screen.dart';

class ResultScreen extends ConsumerStatefulWidget {
  const ResultScreen({super.key});

  @override
  ConsumerState<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends ConsumerState<ResultScreen> {
  String? _selectedNote;
  final List<String> _selectedTags = [];

  // Available tags for selection
  final List<Tag> _availableTags = [
    Tag(id: '1', name: 'work', color: '#8B7CF6'),
    Tag(id: '2', name: 'family', color: '#FF8FAB'),
    Tag(id: '3', name: 'health', color: '#7DD3C0'),
    Tag(id: '4', name: 'gratitude', color: '#FFB366'),
    Tag(id: '5', name: 'stress', color: '#FF6B6B'),
    Tag(id: '6', name: 'growth', color: '#4ECDC4'),
    Tag(id: '7', name: 'social', color: '#9B59B6'),
    Tag(id: '8', name: 'relaxation', color: '#3498DB'),
  ];

  @override
  Widget build(BuildContext context) {
    final analysisResult = ref.watch(analysisResultProvider);

    // If no result, redirect to home
    if (analysisResult == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/home');
      });
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final moodScore = analysisResult.moodScore;
    final moodColor = AppColors.getMoodColor(moodScore);
    final transcript = analysisResult.transcript;
    final confidence = analysisResult.confidence;

    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Celebration header
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      moodColor.withOpacity(0.2),
                      moodColor.withOpacity(0.05),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  children: [
                    // Close button
                    Row(
                      children: [
                        const Spacer(),
                        GestureDetector(
                          onTap: () => _confirmDiscard(context),
                          child: Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: BoxDecoration(
                              color: isDark ? AppColors.cardDark : Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black
                                      .withOpacity(isDark ? 0.2 : 0.1),
                                  blurRadius: 10,
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.close_rounded,
                              size: 20.sp,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 16.h),

                    // Success message
                    Text(
                      '✨ Check-in Complete!',
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                        color: moodColor,
                      ),
                    ).animate().fadeIn(),

                    SizedBox(height: 24.h),

                    // Mood indicator
                    MoodIndicator(
                      moodScore: moodScore,
                      size: 140,
                    ).animate().scale(
                          begin: const Offset(0.5, 0.5),
                          end: const Offset(1, 1),
                          duration: 600.ms,
                          curve: Curves.elasticOut,
                        ),

                    SizedBox(height: 24.h),

                    // Mood score
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.w, vertical: 10.h),
                      decoration: BoxDecoration(
                        color: moodColor.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Mood Score: ',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          Text(
                            '${(moodScore * 100).round()}%',
                            style: TextStyle(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                              color: moodColor,
                            ),
                          ),
                        ],
                      ),
                    ).animate().fadeIn(delay: 200.ms),

                    SizedBox(height: 12.h),

                    // Confidence
                    Text(
                      'Confidence: ${(confidence * 100).round()}%',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppColors.textTertiary,
                      ),
                    ).animate().fadeIn(delay: 300.ms),
                  ],
                ),
              ),

              // Content
              Padding(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Transcript section
                    if (transcript.isNotEmpty) ...[
                      _buildSectionTitle(
                          'What you said', Icons.format_quote_rounded),
                      SizedBox(height: 12.h),
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Text(
                          '"$transcript"',
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: AppColors.textPrimary,
                            fontStyle: FontStyle.italic,
                            height: 1.6,
                          ),
                        ),
                      )
                          .animate()
                          .fadeIn(delay: 400.ms)
                          .slideY(begin: 0.1, end: 0),
                      SizedBox(height: 24.h),
                    ],

                    // Detected emotions with rich display
                    _buildSectionTitle(
                        'Detected Emotions', Icons.psychology_outlined),
                    SizedBox(height: 12.h),
                    _buildEmotionsDisplay(
                        analysisResult.detailedEmotions, isDark),

                    SizedBox(height: 24.h),

                    // Personalized response section
                    if (analysisResult.personalizedResponse != null) ...[
                      _buildPersonalizedResponse(
                          analysisResult.personalizedResponse!, isDark),
                      SizedBox(height: 24.h),
                    ],

                    // Analysis breakdown
                    _buildSectionTitle(
                        'Analysis Breakdown', Icons.analytics_outlined),
                    SizedBox(height: 12.h),
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildAnalysisRow('Voice Tone',
                              analysisResult.acousticScore, AppColors.primary),
                          SizedBox(height: 16.h),
                          _buildAnalysisRow(
                              'Speech Energy',
                              (moodScore + 0.1).clamp(0.0, 1.0),
                              AppColors.secondary),
                          SizedBox(height: 16.h),
                          _buildAnalysisRow('Sentiment',
                              analysisResult.semanticScore, AppColors.accent),
                        ],
                      ),
                    )
                        .animate()
                        .fadeIn(delay: 600.ms)
                        .slideY(begin: 0.1, end: 0),

                    SizedBox(height: 24.h),

                    // Add tags
                    _buildSectionTitle('Add Tags', Icons.tag_rounded),
                    SizedBox(height: 12.h),
                    Wrap(
                      spacing: 10.w,
                      runSpacing: 10.h,
                      children: _availableTags.map((tag) {
                        final isSelected = _selectedTags.contains(tag.name);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                _selectedTags.remove(tag.name);
                              } else {
                                _selectedTags.add(tag.name);
                              }
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 10.h),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Color(int.parse(
                                      tag.color.replaceFirst('#', '0xFF')))
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all(
                                color: Color(int.parse(
                                    tag.color.replaceFirst('#', '0xFF'))),
                              ),
                            ),
                            child: Text(
                              tag.name,
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: isSelected
                                    ? Colors.white
                                    : Color(int.parse(
                                        tag.color.replaceFirst('#', '0xFF'))),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ).animate().fadeIn(delay: 700.ms),

                    SizedBox(height: 24.h),

                    // Add note
                    _buildSectionTitle(
                        'Add a Note (Optional)', Icons.edit_note_rounded),
                    SizedBox(height: 12.h),
                    TextField(
                      maxLines: 3,
                      onChanged: (value) => _selectedNote = value,
                      decoration: InputDecoration(
                        hintText: 'Add any additional thoughts...',
                        hintStyle: TextStyle(color: AppColors.textTertiary),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.r),
                          borderSide: BorderSide(color: AppColors.divider),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.r),
                          borderSide: BorderSide(color: AppColors.divider),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.r),
                          borderSide:
                              BorderSide(color: AppColors.primary, width: 2),
                        ),
                      ),
                    ).animate().fadeIn(delay: 800.ms),

                    SizedBox(height: 32.h),

                    // Save button
                    GradientButton(
                      text: 'Save Entry',
                      icon: Icons.check_rounded,
                      onPressed: () => _saveEntry(analysisResult),
                    )
                        .animate()
                        .fadeIn(delay: 900.ms)
                        .slideY(begin: 0.2, end: 0),

                    SizedBox(height: 16.h),

                    // Discard button
                    Center(
                      child: TextButton(
                        onPressed: () => _confirmDiscard(context),
                        child: Text(
                          'Discard',
                          style: TextStyle(
                            fontSize: 15.sp,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _saveEntry(AnalysisResult analysisResult) {
    // Create tags from selected names
    final tags = _selectedTags.map((name) {
      final tagData = _availableTags.firstWhere((t) => t.name == name);
      return Tag(id: tagData.id, name: name, color: tagData.color);
    }).toList();

    // Create the final entry with all required fields
    final finalEntry = VoiceEntry(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      userId: 'user_001',
      recordedAt: DateTime.now(),
      durationSeconds: analysisResult.duration,
      language: analysisResult.language,
      audioUrl: 'local://audio_${DateTime.now().millisecondsSinceEpoch}.m4a',
      transcript: analysisResult.transcript,
      emotionKeywords: analysisResult.emotions,
      sentimentScore: analysisResult.semanticScore,
      detectedEmotions: analysisResult.emotions,
      topicContext: 'daily_checkin',
      // Acoustic features (mock values for now)
      pitchMean: 150.0 + (analysisResult.moodScore * 50),
      pitchStd: 20.0 + (analysisResult.moodScore * 10),
      energyMean: 0.5 + (analysisResult.moodScore * 0.3),
      tempo: 100.0 + (analysisResult.moodScore * 40),
      silenceRatio: 0.1 + ((1 - analysisResult.moodScore) * 0.2),
      // Mood scores
      acousticMoodScore: analysisResult.acousticScore,
      semanticMoodScore: analysisResult.semanticScore,
      finalMoodScore: analysisResult.moodScore,
      moodLabel: analysisResult.moodLabel,
      confidence: analysisResult.confidence,
      signalAlignment: 0.85,
      // User additions
      tags: tags,
      privacyLevel: 'full',
      note: _selectedNote,
    );

    // Add to entries
    ref.read(entriesProvider.notifier).addEntry(finalEntry);

    // Clear the analysis result
    ref.read(analysisResultProvider.notifier).state = null;

    // Show success message and navigate
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Entry saved successfully! 🎉'),
        backgroundColor: AppColors.success,
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      ),
    );

    context.go('/home');
  }

  void _confirmDiscard(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: const Text('Discard Entry?'),
        content: const Text('This check-in will not be saved.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Cancel',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
          TextButton(
            onPressed: () {
              ref.read(analysisResultProvider.notifier).state = null;
              Navigator.pop(context);
              context.go('/home');
            },
            child: const Text(
              'Discard',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 20.sp, color: AppColors.primary),
        SizedBox(width: 8.w),
        Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildEmotionsDisplay(List<Emotion> detailedEmotions, bool isDark) {
    // Fall back to simple display if no detailed emotions
    if (detailedEmotions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Container(
      width: double.infinity,
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
        children: detailedEmotions.asMap().entries.map((entry) {
          final emotion = entry.value;
          final index = entry.key;

          return Padding(
            padding: EdgeInsets.only(
                bottom: index < detailedEmotions.length - 1 ? 16.h : 0),
            child: Row(
              children: [
                // Emoji and name
                Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    color: emotion.color.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: Text(
                      emotion.emoji,
                      style: TextStyle(fontSize: 22.sp),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            emotion.name,
                            style: TextStyle(
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w600,
                              color: isDark
                                  ? AppColors.textPrimaryDark
                                  : AppColors.textPrimary,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color: emotion.color.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              '${(emotion.intensity * 100).round()}%',
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                                color: emotion.color,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6.h),
                      // Intensity bar
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4.r),
                        child: LinearProgressIndicator(
                          value: emotion.intensity,
                          backgroundColor: emotion.color.withOpacity(0.15),
                          valueColor: AlwaysStoppedAnimation(emotion.color),
                          minHeight: 6.h,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
              .animate()
              .fadeIn(delay: (500 + index * 100).ms)
              .slideX(begin: 0.1, end: 0);
        }).toList(),
      ),
    );
  }

  Widget _buildAnalysisRow(String label, double value, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
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
              '${(value * 100).round()}%',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(4.r),
          child: LinearProgressIndicator(
            value: value,
            backgroundColor: color.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation(color),
            minHeight: 8.h,
          ),
        ),
      ],
    );
  }

  Widget _buildPersonalizedResponse(
      PersonalizedResponse response, bool isDark) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            response.accentColor.withOpacity(0.15),
            response.accentColor.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: response.accentColor.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with emoji and headline
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: response.accentColor.withOpacity(0.1),
              borderRadius: BorderRadius.vertical(top: Radius.circular(19.r)),
            ),
            child: Row(
              children: [
                Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: BoxDecoration(
                    color: response.accentColor.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      response.emoji,
                      style: TextStyle(fontSize: 24.sp),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    response.headline,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Message
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Text(
              response.message,
              style: TextStyle(
                fontSize: 14.sp,
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondary,
                height: 1.6,
              ),
            ),
          ),

          // Suggestions
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Suggestions for you:',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 8.h),
                ...response.suggestions.take(3).map((suggestion) => Padding(
                      padding: EdgeInsets.only(bottom: 6.h),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.check_circle_outline,
                            size: 16.sp,
                            color: response.accentColor,
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              suggestion,
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: isDark
                                    ? AppColors.textSecondaryDark
                                    : AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),

          SizedBox(height: 12.h),

          // Quick action buttons
          Padding(
            padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quick Actions:',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? AppColors.textPrimaryDark
                        : AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 10.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: response.quickActions
                      .map(
                        (action) => GestureDetector(
                          onTap: () => _handleQuickAction(action),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 14.w, vertical: 10.h),
                            decoration: BoxDecoration(
                              color: isDark ? AppColors.cardDark : Colors.white,
                              borderRadius: BorderRadius.circular(25.r),
                              border: Border.all(
                                color: action.color.withOpacity(0.5),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: action.color.withOpacity(0.1),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(action.emoji,
                                    style: TextStyle(fontSize: 16.sp)),
                                SizedBox(width: 6.w),
                                Text(
                                  action.label,
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w500,
                                    color: action.color,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 700.ms).slideY(begin: 0.1, end: 0);
  }

  void _handleQuickAction(QuickAction action) {
    switch (action.actionType) {
      case 'breathing':
        _showBreathingExercise();
        break;
      case 'journal':
        _showJournalPrompt();
        break;
      case 'gratitude':
        _showGratitudePrompt();
        break;
      case 'music':
        _showMusicSuggestion();
        break;
      case 'call':
        _showCallSuggestion();
        break;
      case 'meditate':
        _showMeditationGuide();
        break;
      case 'grounding':
        _showGroundingExercise();
        break;
      case 'workout':
        _showWorkoutSuggestion();
        break;
      case 'share':
        _showShareExperience();
        break;
      case 'celebrate':
        _showCelebration();
        break;
      case 'goals':
        _showGoalsSetting();
        break;
      case 'focus':
        _showFocusMode();
        break;
      case 'walk':
        _showWalkSuggestion();
        break;
    }
  }

  void _showBreathingExercise() {
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
                color: isDark ? AppColors.dividerDark : AppColors.divider,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              '🌬️ Breathing Exercise',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color:
                    isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              '4-7-8 Technique',
              style: TextStyle(
                fontSize: 14.sp,
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondary,
              ),
            ),
            const Spacer(),
            Container(
              width: 180.w,
              height: 180.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withOpacity(0.3),
                    AppColors.accent.withOpacity(0.3),
                  ],
                ),
              ),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Breathe In',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      '4 seconds',
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
            )
                .animate(onPlay: (controller) => controller.repeat())
                .scale(
                    duration: 4.seconds,
                    begin: const Offset(0.8, 0.8),
                    end: const Offset(1.2, 1.2))
                .then()
                .scale(
                    duration: 7.seconds,
                    begin: const Offset(1.2, 1.2),
                    end: const Offset(1.2, 1.2))
                .then()
                .scale(
                    duration: 8.seconds,
                    begin: const Offset(1.2, 1.2),
                    end: const Offset(0.8, 0.8)),
            const Spacer(),
            Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                children: [
                  Text(
                    'Inhale for 4s • Hold for 7s • Exhale for 8s',
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: isDark
                          ? AppColors.textSecondaryDark
                          : AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16.h),
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
                      child: const Text('Done',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showJournalPrompt() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final controller = TextEditingController();
    final rootContext = context;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (modalContext) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(modalContext).viewInsets.bottom),
        child: Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : Colors.white,
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
              Text(
                '📓 Quick Journal',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Write down what\'s on your mind...',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondary,
                ),
              ),
              SizedBox(height: 16.h),
              TextField(
                controller: controller,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Start writing...',
                  filled: true,
                  fillColor: isDark ? AppColors.cardDark : AppColors.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(modalContext),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (controller.text.trim().isNotEmpty) {
                          final entry = JournalEntry(
                            id: DateTime.now().millisecondsSinceEpoch.toString(),
                            createdAt: DateTime.now(),
                            content: controller.text.trim(),
                            prompt: 'Quick Journal',
                          );
                          ref.read(journalProvider.notifier).addEntry(entry);
                          Navigator.pop(modalContext);
                          ScaffoldMessenger.of(rootContext).showSnackBar(
                            SnackBar(
                              content: const Text('Journal entry saved! 📓'),
                              backgroundColor: AppColors.success,
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.only(bottom: 16.h, left: 16.w, right: 16.w),
                              action: SnackBarAction(
                                label: 'View All',
                                textColor: Colors.white,
                                onPressed: () => rootContext.push('/wellness-history'),
                              ),
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
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      child: const Text('Save',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showGratitudePrompt() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final controllers = List.generate(3, (_) => TextEditingController());
    final prompts = [
      'Something that made you smile',
      'Someone you appreciate',
      'A simple pleasure'
    ];
    final rootContext = context;
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (modalContext) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(modalContext).viewInsets.bottom),
        child: Container(
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
          ),
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
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
              Text(
                '🙏 Gratitude Moment',
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color:
                      isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Take a moment to think about 3 things you\'re grateful for today.',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondary,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              ...List.generate(3, (index) => Container(
                margin: EdgeInsets.only(bottom: 12.h),
                child: TextField(
                  controller: controllers[index],
                  decoration: InputDecoration(
                    hintText: prompts[index],
                    prefixIcon: Icon(Icons.favorite_border,
                        color: AppColors.secondary, size: 20.sp),
                    filled: true,
                    fillColor: isDark ? AppColors.cardDark : AppColors.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              )),
              SizedBox(height: 16.h),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(modalContext),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      child: const Text('Cancel'),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        final items = controllers
                            .map((c) => c.text.trim())
                            .where((text) => text.isNotEmpty)
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
                              content: Text('${items.length} gratitude${items.length > 1 ? 's' : ''} saved! 💜'),
                              backgroundColor: AppColors.primary,
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.only(bottom: 16.h, left: 16.w, right: 16.w),
                              action: SnackBarAction(
                                label: 'View All',
                                textColor: Colors.white,
                                onPressed: () => rootContext.push('/wellness-history'),
                              ),
                            ),
                          );
                        } else {
                          Navigator.pop(modalContext);
                          ScaffoldMessenger.of(rootContext).showSnackBar(
                            SnackBar(
                              content: const Text('Keep practicing gratitude! 💜'),
                              backgroundColor: AppColors.primary,
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.only(bottom: 16.h, left: 16.w, right: 16.w),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      child:
                          const Text('Save', style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showMusicSuggestion() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.6,
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
              'Music can shift your mood. Choose what feels right.',
              style: TextStyle(
                fontSize: 14.sp,
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            Expanded(
              child: ListView(
                children: [
                  _buildMusicOption(
                    emoji: '😌',
                    title: 'Calm & Peaceful',
                    subtitle: 'Ambient sounds, soft piano, nature',
                    color: Colors.blue,
                    isDark: isDark,
                  ),
                  _buildMusicOption(
                    emoji: '😊',
                    title: 'Uplifting & Happy',
                    subtitle: 'Feel-good songs to boost mood',
                    color: Colors.orange,
                    isDark: isDark,
                  ),
                  _buildMusicOption(
                    emoji: '🧘',
                    title: 'Meditation & Focus',
                    subtitle: 'Binaural beats, lo-fi, concentration',
                    color: Colors.purple,
                    isDark: isDark,
                  ),
                  _buildMusicOption(
                    emoji: '💪',
                    title: 'Energizing',
                    subtitle: 'Upbeat tracks to get moving',
                    color: Colors.red,
                    isDark: isDark,
                  ),
                  _buildMusicOption(
                    emoji: '😢',
                    title: 'Emotional Release',
                    subtitle: 'Songs to help you feel and heal',
                    color: Colors.teal,
                    isDark: isDark,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMusicOption({
    required String emoji,
    required String title,
    required String subtitle,
    required Color color,
    required bool isDark,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      child: Material(
        color: isDark ? AppColors.cardDark : AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MusicPlayerScreen(
                  category: title,
                  emoji: emoji,
                  color: color,
                ),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Container(
                  width: 50.w,
                  height: 50.w,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: Text(emoji, style: TextStyle(fontSize: 24.sp)),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: isDark
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.play_circle_fill, color: color, size: 32.sp),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showCallSuggestion() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '📞 Reach Out',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color:
                    isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Consider reaching out to someone who cares about you.',
              style: TextStyle(
                fontSize: 14.sp,
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            ...['Family member', 'Close friend', 'Therapist or counselor'].map(
              (contact) => Container(
                margin: EdgeInsets.only(bottom: 12.h),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    child: Icon(Icons.person, color: AppColors.primary),
                  ),
                  title: Text(contact,
                      style: TextStyle(
                          color: isDark
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimary)),
                  trailing: Icon(Icons.phone, color: AppColors.success),
                  onTap: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('Opening phone for $contact...'),
                          backgroundColor: AppColors.success),
                    );
                  },
                  tileColor: isDark ? AppColors.cardDark : AppColors.surface,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showMeditationGuide() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.65,
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
              '🧘 Guided Meditation',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color:
                    isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Find stillness and peace with guided practice',
              style: TextStyle(
                fontSize: 14.sp,
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            Expanded(
              child: ListView(
                children: [
                  _buildMeditationOption(
                    duration: '3 min',
                    title: 'Quick Reset',
                    description: 'Brief mindfulness for busy moments',
                    icon: Icons.bolt,
                    color: Colors.amber,
                    isDark: isDark,
                  ),
                  _buildMeditationOption(
                    duration: '5 min',
                    title: 'Body Scan',
                    description: 'Release tension from head to toe',
                    icon: Icons.accessibility_new,
                    color: Colors.blue,
                    isDark: isDark,
                  ),
                  _buildMeditationOption(
                    duration: '10 min',
                    title: 'Loving Kindness',
                    description: 'Cultivate compassion for yourself and others',
                    icon: Icons.favorite,
                    color: Colors.pink,
                    isDark: isDark,
                  ),
                  _buildMeditationOption(
                    duration: '15 min',
                    title: 'Deep Relaxation',
                    description: 'Full body and mind relaxation',
                    icon: Icons.spa,
                    color: Colors.green,
                    isDark: isDark,
                  ),
                  _buildMeditationOption(
                    duration: '20 min',
                    title: 'Sleep Preparation',
                    description: 'Gentle meditation for restful sleep',
                    icon: Icons.bedtime,
                    color: Colors.indigo,
                    isDark: isDark,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMeditationOption({
    required String duration,
    required String title,
    required String description,
    required IconData icon,
    required Color color,
    required bool isDark,
  }) {
    // Parse duration from string like "3 min" to int
    final durationMinutes = int.tryParse(duration.split(' ')[0]) ?? 5;
    
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      child: Material(
        color: isDark ? AppColors.cardDark : AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MeditationSessionScreen(
                  meditationType: title,
                  durationMinutes: durationMinutes,
                  icon: icon,
                  color: color,
                ),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Container(
                  width: 50.w,
                  height: 50.w,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(icon, color: color, size: 28.sp),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: isDark
                                  ? AppColors.textPrimaryDark
                                  : AppColors.textPrimary,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              duration,
                              style: TextStyle(
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w600,
                                color: color,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.play_arrow, color: color, size: 28.sp),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _startMeditationSession(String title, String duration) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('🧘', style: TextStyle(fontSize: 48.sp)),
            SizedBox(height: 16.h),
            Text(
              title,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color:
                    isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              '$duration session starting...',
              style: TextStyle(
                fontSize: 14.sp,
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondary,
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              'Find a comfortable position.\nClose your eyes.\nTake a deep breath...',
              style: TextStyle(
                fontSize: 14.sp,
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondary,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel',
                      style: TextStyle(color: AppColors.textSecondary)),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text('🧘 $title meditation complete. Namaste! 🙏'),
                        backgroundColor: AppColors.success,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r)),
                  ),
                  child: const Text('Complete',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showGroundingExercise() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        padding: EdgeInsets.all(24.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '🌍 5-4-3-2-1 Grounding',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color:
                    isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 24.h),
            ...[
              ('5 things you can SEE', '👁️'),
              ('4 things you can TOUCH', '✋'),
              ('3 things you can HEAR', '👂'),
              ('2 things you can SMELL', '👃'),
              ('1 thing you can TASTE', '👅'),
            ].map(
              (item) => Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: Row(
                  children: [
                    Text(item.$2, style: TextStyle(fontSize: 24.sp)),
                    SizedBox(width: 12.w),
                    Text(
                      item.$1,
                      style: TextStyle(
                        fontSize: 15.sp,
                        color: isDark
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.h),
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
                child: const Text('I feel grounded',
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showWorkoutSuggestion() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.65,
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
              '💪 Movement Therapy',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color:
                    isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Physical activity boosts endorphins and improves mood',
              style: TextStyle(
                fontSize: 14.sp,
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            Expanded(
              child: ListView(
                children: [
                  _buildWorkoutOption(
                    emoji: '🚶',
                    title: '5-Minute Walk',
                    description: 'Get outside or walk around your space',
                    duration: '5 min',
                    intensity: 'Low',
                    color: Colors.green,
                    isDark: isDark,
                  ),
                  _buildWorkoutOption(
                    emoji: '🧘',
                    title: 'Gentle Stretching',
                    description: 'Release muscle tension and relax',
                    duration: '7 min',
                    intensity: 'Low',
                    color: Colors.blue,
                    isDark: isDark,
                  ),
                  _buildWorkoutOption(
                    emoji: '💃',
                    title: 'Dance Break',
                    description: 'Put on your favorite song and move!',
                    duration: '3 min',
                    intensity: 'Medium',
                    color: Colors.pink,
                    isDark: isDark,
                  ),
                  _buildWorkoutOption(
                    emoji: '🏋️',
                    title: 'Quick HIIT',
                    description: 'Jumping jacks, squats, push-ups',
                    duration: '10 min',
                    intensity: 'High',
                    color: Colors.orange,
                    isDark: isDark,
                  ),
                  _buildWorkoutOption(
                    emoji: '🧎',
                    title: 'Yoga Flow',
                    description: 'Sun salutations and calming poses',
                    duration: '15 min',
                    intensity: 'Medium',
                    color: Colors.purple,
                    isDark: isDark,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkoutOption({
    required String emoji,
    required String title,
    required String description,
    required String duration,
    required String intensity,
    required Color color,
    required bool isDark,
  }) {
    // Parse duration from string like "5 min" to int
    final durationMinutes = int.tryParse(duration.split(' ')[0]) ?? 5;
    
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      child: Material(
        color: isDark ? AppColors.cardDark : AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () {
            Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => WorkoutSessionScreen(
                  workoutType: title,
                  emoji: emoji,
                  color: color,
                  durationMinutes: durationMinutes,
                ),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Container(
                  width: 50.w,
                  height: 50.w,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: Text(emoji, style: TextStyle(fontSize: 24.sp)),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: isDark
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondary,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              duration,
                              style: TextStyle(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w600,
                                  color: color),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: Colors.grey.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              intensity,
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                                color: isDark
                                    ? AppColors.textSecondaryDark
                                    : AppColors.textSecondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios, color: color, size: 18.sp),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showShareExperience() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.5,
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
              '💬 Share Your Experience',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color:
                    isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Sharing can strengthen connections and lighten your heart',
              style: TextStyle(
                fontSize: 14.sp,
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            Expanded(
              child: ListView(
                children: [
                  _buildShareOption(
                    icon: Icons.message,
                    title: 'Text a Friend',
                    subtitle: 'Send a message to someone you trust',
                    color: Colors.blue,
                    isDark: isDark,
                  ),
                  _buildShareOption(
                    icon: Icons.group,
                    title: 'Support Community',
                    subtitle: 'Connect with others who understand',
                    color: Colors.green,
                    isDark: isDark,
                  ),
                  _buildShareOption(
                    icon: Icons.note_alt,
                    title: 'Private Note',
                    subtitle: 'Write it down just for yourself',
                    color: Colors.purple,
                    isDark: isDark,
                  ),
                  _buildShareOption(
                    icon: Icons.psychology,
                    title: 'Talk to a Professional',
                    subtitle: 'Reach out to a counselor or therapist',
                    color: Colors.teal,
                    isDark: isDark,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildShareOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
    required bool isDark,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      child: Material(
        color: isDark ? AppColors.cardDark : AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('💬 Opening $title...'),
                backgroundColor: color,
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Container(
                  width: 50.w,
                  height: 50.w,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(icon, color: color, size: 24.sp),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: isDark
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        subtitle,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.arrow_forward_ios, color: color, size: 18.sp),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showCelebration() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(24.r)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('🎉', style: TextStyle(fontSize: 64.sp))
                .animate(onPlay: (controller) => controller.repeat())
                .shimmer(duration: 1200.ms, color: Colors.amber)
                .shake(hz: 2, rotation: 0.05),
            SizedBox(height: 16.h),
            Text(
              'Celebrate Yourself!',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color:
                    isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 16.h),
            Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.amber.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  Text(
                    _getRandomAffirmation(),
                    style: TextStyle(
                      fontSize: 15.sp,
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimary,
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              '✨ You\'re doing amazing! ✨',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.amber[700],
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('📸 Moment captured! Keep shining! ✨'),
                        backgroundColor: AppColors.success,
                      ),
                    );
                  },
                  icon: Icon(Icons.camera_alt, color: AppColors.primary),
                  label: Text('Save Moment',
                      style: TextStyle(color: AppColors.primary)),
                ),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r)),
                  ),
                  child: const Text('🎊 Celebrate!',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _getRandomAffirmation() {
    final affirmations = [
      'You are worthy of love and joy.',
      'Your feelings are valid and important.',
      'You have the strength to overcome challenges.',
      'Every step forward is progress.',
      'You bring light to the world around you.',
      'Your resilience is inspiring.',
      'Today is a gift, and so are you.',
      'You are capable of amazing things.',
    ];
    return affirmations[DateTime.now().millisecond % affirmations.length];
  }

  void _showGoalsSetting() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final TextEditingController goalController = TextEditingController();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.6,
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
                '🎯 Set a Wellness Goal',
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
                'Small steps lead to big changes',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondary,
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                'Quick Goals',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 12.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: [
                  _buildGoalChip('💧 Drink more water', isDark),
                  _buildGoalChip('😴 Sleep 8 hours', isDark),
                  _buildGoalChip('🚶 Walk 10 min daily', isDark),
                  _buildGoalChip('📵 Less screen time', isDark),
                  _buildGoalChip('🧘 Meditate daily', isDark),
                  _buildGoalChip('📓 Journal nightly', isDark),
                ],
              ),
              SizedBox(height: 24.h),
              TextField(
                controller: goalController,
                decoration: InputDecoration(
                  hintText: 'Or write your own goal...',
                  hintStyle: TextStyle(
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondary,
                  ),
                  filled: true,
                  fillColor: isDark ? AppColors.cardDark : AppColors.surface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16.r),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.edit, color: AppColors.primary),
                ),
                style: TextStyle(
                  color: isDark
                      ? AppColors.textPrimaryDark
                      : AppColors.textPrimary,
                ),
              ),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('🎯 Goal set! You\'ve got this! 💪'),
                        backgroundColor: AppColors.success,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: const Text('Set My Goal',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGoalChip(String label, bool isDark) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('🎯 Goal set: $label'),
            backgroundColor: AppColors.success,
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: AppColors.primary.withOpacity(0.3)),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 13.sp,
            color: AppColors.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  void _showFocusMode() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.55,
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
              '🎯 Focus Mode',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color:
                    isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Channel your energy into productivity',
              style: TextStyle(
                fontSize: 14.sp,
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            Expanded(
              child: ListView(
                children: [
                  _buildFocusOption(
                    emoji: '🍅',
                    title: 'Pomodoro Timer',
                    description: '25 min focus, 5 min break',
                    color: Colors.red,
                    isDark: isDark,
                  ),
                  _buildFocusOption(
                    emoji: '📵',
                    title: 'Digital Detox',
                    description: 'Minimize distractions for 30 min',
                    color: Colors.purple,
                    isDark: isDark,
                  ),
                  _buildFocusOption(
                    emoji: '📝',
                    title: 'Priority Task',
                    description: 'Focus on your most important task',
                    color: Colors.blue,
                    isDark: isDark,
                  ),
                  _buildFocusOption(
                    emoji: '🎵',
                    title: 'Focus Music',
                    description: 'Lo-fi beats for concentration',
                    color: Colors.teal,
                    isDark: isDark,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFocusOption({
    required String emoji,
    required String title,
    required String description,
    required Color color,
    required bool isDark,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      child: Material(
        color: isDark ? AppColors.cardDark : AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$emoji Starting $title. Let\'s focus! 🎯'),
                backgroundColor: color,
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Container(
                  width: 50.w,
                  height: 50.w,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: Text(emoji, style: TextStyle(fontSize: 24.sp)),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: isDark
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.play_circle_fill, color: color, size: 28.sp),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showWalkSuggestion() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.55,
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
              '🚶 Mindful Walking',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color:
                    isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'A gentle walk can clear your mind and lift your spirits',
              style: TextStyle(
                fontSize: 14.sp,
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            Expanded(
              child: ListView(
                children: [
                  _buildWalkOption(
                    emoji: '🌳',
                    title: 'Nature Walk',
                    description: 'Find a park or green space nearby',
                    duration: '15-30 min',
                    color: Colors.green,
                    isDark: isDark,
                  ),
                  _buildWalkOption(
                    emoji: '🏠',
                    title: 'Indoor Stroll',
                    description: 'Walk around your home or office',
                    duration: '5-10 min',
                    color: Colors.blue,
                    isDark: isDark,
                  ),
                  _buildWalkOption(
                    emoji: '🧘',
                    title: 'Meditative Walk',
                    description: 'Slow, intentional steps with breathing',
                    duration: '10 min',
                    color: Colors.purple,
                    isDark: isDark,
                  ),
                  _buildWalkOption(
                    emoji: '☀️',
                    title: 'Sunshine Break',
                    description: 'Step outside for natural light',
                    duration: '5 min',
                    color: Colors.orange,
                    isDark: isDark,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWalkOption({
    required String emoji,
    required String title,
    required String description,
    required String duration,
    required Color color,
    required bool isDark,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      child: Material(
        color: isDark ? AppColors.cardDark : AppColors.surface,
        borderRadius: BorderRadius.circular(16.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$emoji Enjoy your $title! 🚶'),
                backgroundColor: color,
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                Container(
                  width: 50.w,
                  height: 50.w,
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Center(
                    child: Text(emoji, style: TextStyle(fontSize: 24.sp)),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            title,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: isDark
                                  ? AppColors.textPrimaryDark
                                  : AppColors.textPrimary,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 2.h),
                            decoration: BoxDecoration(
                              color: color.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Text(
                              duration,
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w600,
                                color: color,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.directions_walk, color: color, size: 28.sp),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
