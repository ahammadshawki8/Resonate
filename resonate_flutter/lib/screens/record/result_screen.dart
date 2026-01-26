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

    // Get the quick actions from the analysis result's personalized response
    // Filter to only include actions that exist in home screen
    final allowedActions = {'breathing', 'journal', 'meditate', 'music', 'call', 'workout', 'gratitude', 'goals'};
    final quickActions = (analysisResult.personalizedResponse?.quickActions ?? [])
        .where((action) => allowedActions.contains(action.actionType))
        .take(3)
        .toList();

    // Show quick actions modal (will clear state and navigate when dismissed)
    _showQuickActionsSuggestionModal(quickActions);
  }

  void _showQuickActionsSuggestionModal(List<QuickAction> quickActions) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isDismissible: false,
      enableDrag: false,
      isScrollControlled: true,
      builder: (modalContext) => Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.6,
        ),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
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
              SizedBox(height: 16.h),
              
              // Success icon
              Container(
                width: 56.w,
                height: 56.w,
                decoration: BoxDecoration(
                  color: AppColors.success.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle,
                  color: AppColors.success,
                  size: 36.sp,
                ),
              ),
              SizedBox(height: 12.h),
              
              Text(
                'Entry Saved! 🎉',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 6.h),
              
              Text(
                'Based on how you\'re feeling, try one of these:',
                style: TextStyle(
                  fontSize: 13.sp,
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
              
              // Quick actions grid
              if (quickActions.isNotEmpty)
                Wrap(
                  spacing: 10.w,
                  runSpacing: 10.h,
                  alignment: WrapAlignment.center,
                  children: quickActions.map((action) => GestureDetector(
                    onTap: () {
                      Navigator.pop(modalContext);
                      ref.read(analysisResultProvider.notifier).state = null;
                      context.go('/home?action=${action.actionType}');
                    },
                    child: Container(
                      width: 130.w,
                      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 10.w),
                      decoration: BoxDecoration(
                        color: action.color.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: action.color.withOpacity(0.3)),
                      ),
                      child: Column(
                        children: [
                          Text(action.emoji, style: TextStyle(fontSize: 24.sp)),
                          SizedBox(height: 6.h),
                          Text(
                            action.label,
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: action.color,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  )).toList(),
                ),
              
              SizedBox(height: 16.h),
              
              // Skip button
              TextButton(
                onPressed: () {
                  Navigator.pop(modalContext);
                  ref.read(analysisResultProvider.notifier).state = null;
                  context.go('/home');
                },
                child: Text(
                  'Skip for now',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                  ),
                ),
              ),
              SizedBox(height: 60.h),
            ],
          ),
        ),
      ),
    );
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
        ],
      ),
    ).animate().fadeIn(delay: 700.ms).slideY(begin: 0.1, end: 0);
  }
}
