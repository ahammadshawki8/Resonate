import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/shared_widgets.dart';
import '../../providers/app_providers.dart';

class PrivacySettingsScreen extends ConsumerStatefulWidget {
  const PrivacySettingsScreen({super.key});

  @override
  ConsumerState<PrivacySettingsScreen> createState() =>
      _PrivacySettingsScreenState();
}

class _PrivacySettingsScreenState extends ConsumerState<PrivacySettingsScreen> {
  late String _selectedLevel;

  @override
  void initState() {
    super.initState();
    _selectedLevel = ref.read(settingsProvider).privacyLevel;
  }

  final List<PrivacyOption> _options = [
    PrivacyOption(
      level: 'full',
      title: 'Full Analysis',
      description:
          'Both voice characteristics and transcribed text are analyzed for the most accurate mood detection.',
      features: [
        'Acoustic analysis (tone, energy, pace)',
        'Speech-to-text transcription',
        'Sentiment analysis',
        'AI-generated insights',
      ],
      icon: Icons.mic,
      accuracy: 0.95,
    ),
    PrivacyOption(
      level: 'context',
      title: 'Context Only',
      description:
          'Text is used for context but not stored. Voice characteristics remain the primary analysis method.',
      features: [
        'Acoustic analysis',
        'Temporary transcription',
        'Basic sentiment',
        'Limited insights',
      ],
      icon: Icons.text_fields,
      accuracy: 0.85,
    ),
    PrivacyOption(
      level: 'keywords',
      title: 'Keywords Only',
      description:
          'Only emotion-related keywords are extracted. No full transcription is stored.',
      features: [
        'Acoustic analysis',
        'Emotion keyword extraction',
        'No transcript storage',
        'Standard insights',
      ],
      icon: Icons.key,
      accuracy: 0.75,
    ),
    PrivacyOption(
      level: 'acoustic',
      title: 'Acoustic Only',
      description:
          'Maximum privacy. Only voice characteristics are analyzed. No speech recognition.',
      features: [
        'Acoustic analysis only',
        'No transcription',
        'No text storage',
        'Basic insights',
      ],
      icon: Icons.graphic_eq,
      accuracy: 0.65,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(
            Icons.arrow_back_rounded,
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
          ),
        ),
        title: Text(
          'Privacy Settings',
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
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Info card
                  Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color: AppColors.primary.withOpacity(0.2),
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.shield_outlined,
                          color: AppColors.primary,
                          size: 24.sp,
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Text(
                            'Choose how your voice data is processed. Higher privacy means less data stored, but may affect accuracy.',
                            style: TextStyle(
                              fontSize: 13.sp,
                              color: isDark
                                  ? AppColors.textPrimaryDark
                                  : AppColors.textPrimary,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn().slideY(begin: -0.1, end: 0),

                  SizedBox(height: 24.h),

                  // Privacy options
                  ..._options.asMap().entries.map((entry) {
                    final index = entry.key;
                    final option = entry.value;
                    return Padding(
                      padding: EdgeInsets.only(bottom: 16.h),
                      child: _buildPrivacyOption(option, isDark)
                          .animate()
                          .fadeIn(delay: (100 + index * 100).ms)
                          .slideX(begin: 0.1, end: 0),
                    );
                  }),
                ],
              ),
            ),
          ),

          // Save button
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, -4),
                ),
              ],
            ),
            child: GradientButton(
              text: 'Save Changes',
              onPressed: () {
                // Save privacy level
                ref
                    .read(settingsProvider.notifier)
                    .setPrivacyLevel(_selectedLevel);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Privacy settings updated'),
                    backgroundColor: AppColors.success,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                );
                context.pop();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacyOption(PrivacyOption option, bool isDark) {
    final isSelected = _selectedLevel == option.level;

    return GestureDetector(
      onTap: () => setState(() => _selectedLevel = option.level),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isDark ? AppColors.cardDark : Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : (isDark ? AppColors.dividerDark : AppColors.divider),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isSelected
                  ? AppColors.primary.withOpacity(0.1)
                  : Colors.black.withOpacity(isDark ? 0.2 : 0.03),
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
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: (isSelected
                            ? AppColors.primary
                            : (isDark
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondary))
                        .withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    option.icon,
                    color: isSelected
                        ? AppColors.primary
                        : (isDark
                            ? AppColors.textSecondaryDark
                            : AppColors.textSecondary),
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        option.title,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: isDark
                              ? AppColors.textPrimaryDark
                              : AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        'Accuracy: ~${(option.accuracy * 100).toInt()}%',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: isSelected
                              ? AppColors.primary
                              : (isDark
                                  ? AppColors.textSecondaryDark
                                  : AppColors.textSecondary),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Radio<String>(
                  value: option.level,
                  groupValue: _selectedLevel,
                  onChanged: (value) {
                    if (value != null) {
                      setState(() => _selectedLevel = value);
                    }
                  },
                  activeColor: AppColors.primary,
                ),
              ],
            ),
            SizedBox(height: 12.h),
            Text(
              option.description,
              style: TextStyle(
                fontSize: 13.sp,
                color: isDark
                    ? AppColors.textSecondaryDark
                    : AppColors.textSecondary,
                height: 1.5,
              ),
            ),
            if (isSelected) ...[
              SizedBox(height: 16.h),
              Container(
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.surfaceDark : AppColors.surface,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'What is included:',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? AppColors.textPrimaryDark
                            : AppColors.textPrimary,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    ...option.features.map((feature) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: 4.h),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              size: 14.sp,
                              color: AppColors.success,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              feature,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: isDark
                                    ? AppColors.textSecondaryDark
                                    : AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class PrivacyOption {
  final String level;
  final String title;
  final String description;
  final List<String> features;
  final IconData icon;
  final double accuracy;

  PrivacyOption({
    required this.level,
    required this.title,
    required this.description,
    required this.features,
    required this.icon,
    required this.accuracy,
  });
}
