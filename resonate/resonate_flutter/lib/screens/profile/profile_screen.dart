import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/app_providers.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);
    final settings = ref.watch(settingsProvider);
    final entries = ref.watch(entriesProvider);

    // Calculate stats
    final totalCheckins = entries.length;
    final avgMood = entries.isNotEmpty
        ? entries.map((e) => e.finalMoodScore).reduce((a, b) => a + b) /
            entries.length
        : 0.0;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile header
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(20.w, 60.h, 20.w, 32.h),
              decoration: BoxDecoration(
                gradient: AppColors.primaryGradient,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(32.r),
                ),
              ),
              child: Column(
                children: [
                  // Avatar
                  Container(
                    width: 100.w,
                    height: 100.w,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        (user?.name ?? 'U')[0].toUpperCase(),
                        style: TextStyle(
                          fontSize: 40.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ).animate().scale(
                        begin: const Offset(0.5, 0.5),
                        end: const Offset(1, 1),
                        duration: 500.ms,
                        curve: Curves.elasticOut,
                      ),

                  SizedBox(height: 16.h),

                  Text(
                    user?.name ?? 'User',
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ).animate().fadeIn(delay: 100.ms),

                  SizedBox(height: 4.h),

                  Text(
                    user?.email ?? 'user@example.com',
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ).animate().fadeIn(delay: 200.ms),

                  SizedBox(height: 24.h),

                  // Stats row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildProfileStat('$totalCheckins', 'Check-ins'),
                      Container(
                        width: 1,
                        height: 40.h,
                        color: Colors.white.withOpacity(0.3),
                        margin: EdgeInsets.symmetric(horizontal: 32.w),
                      ),
                      _buildProfileStat(
                          '${user?.currentStreak ?? 0}', 'Day Streak'),
                      Container(
                        width: 1,
                        height: 40.h,
                        color: Colors.white.withOpacity(0.3),
                        margin: EdgeInsets.symmetric(horizontal: 32.w),
                      ),
                      _buildProfileStat(
                          '${(avgMood * 100).round()}%', 'Avg Mood'),
                    ],
                  ).animate().fadeIn(delay: 300.ms),
                ],
              ),
            ),

            // Settings sections
            Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Account section
                  _buildSectionTitle('Account'),
                  SizedBox(height: 12.h),
                  _buildSettingsCard([
                    _buildSettingsItem(
                      icon: Icons.person_outline,
                      title: 'Edit Profile',
                      onTap: () => _showEditProfileDialog(context, ref),
                    ),
                    _buildSettingsItem(
                      icon: Icons.lock_outline,
                      title: 'Change Password',
                      onTap: () => _showChangePasswordDialog(context),
                    ),
                    _buildSettingsItem(
                      icon: Icons.email_outlined,
                      title: 'Email Preferences',
                      onTap: () => _showEmailPreferencesDialog(context, ref),
                    ),
                  ]).animate().fadeIn(delay: 400.ms).slideY(begin: 0.1, end: 0),

                  SizedBox(height: 24.h),

                  // Preferences section
                  _buildSectionTitle('Preferences'),
                  SizedBox(height: 12.h),
                  _buildSettingsCard([
                    _buildSettingsSwitch(
                      icon: Icons.notifications_outlined,
                      title: 'Daily Reminders',
                      value: settings.reminderEnabled,
                      onChanged: (value) {
                        ref
                            .read(settingsProvider.notifier)
                            .toggleReminders(value);
                      },
                    ),
                    _buildSettingsItem(
                      icon: Icons.access_time,
                      title: 'Reminder Time',
                      subtitle: _formatTime(settings.reminderTime),
                      onTap: () =>
                          _showTimePicker(context, ref, settings.reminderTime),
                    ),
                    _buildSettingsItem(
                      icon: Icons.language,
                      title: 'Voice Language',
                      subtitle: settings.voiceLanguage == 'en'
                          ? 'English'
                          : 'Bengali',
                      onTap: () => _showLanguageSelector(context, ref),
                    ),
                    _buildSettingsSwitch(
                      icon: Icons.dark_mode_outlined,
                      title: 'Dark Mode',
                      value: settings.darkMode,
                      onChanged: (value) {
                        ref
                            .read(settingsProvider.notifier)
                            .toggleDarkMode(value);
                      },
                    ),
                  ]).animate().fadeIn(delay: 500.ms).slideY(begin: 0.1, end: 0),

                  SizedBox(height: 24.h),

                  // Privacy section
                  _buildSectionTitle('Privacy'),
                  SizedBox(height: 12.h),
                  _buildSettingsCard([
                    _buildSettingsItem(
                      icon: Icons.shield_outlined,
                      title: 'Privacy Settings',
                      subtitle: _getPrivacyLabel(settings.privacyLevel),
                      onTap: () => context.push('/privacy-settings'),
                    ),
                    _buildSettingsItem(
                      icon: Icons.download_outlined,
                      title: 'Export My Data',
                      onTap: () =>
                          _showSnackBar(context, 'Data export coming soon'),
                    ),
                    _buildSettingsItem(
                      icon: Icons.delete_outline,
                      title: 'Delete All Data',
                      titleColor: Colors.red,
                      onTap: () => _showDeleteConfirmation(context, ref),
                    ),
                  ]).animate().fadeIn(delay: 600.ms).slideY(begin: 0.1, end: 0),

                  SizedBox(height: 24.h),

                  // About section
                  _buildSectionTitle('About'),
                  SizedBox(height: 12.h),
                  _buildSettingsCard([
                    _buildSettingsItem(
                      icon: Icons.info_outline,
                      title: 'About Resonate',
                      onTap: () => _showAboutDialog(context),
                    ),
                    _buildSettingsItem(
                      icon: Icons.help_outline,
                      title: 'Help & Support',
                      onTap: () => _showHelpDialog(context),
                    ),
                    _buildSettingsItem(
                      icon: Icons.star_outline,
                      title: 'Rate Us',
                      onTap: () => _showRateDialog(context),
                    ),
                  ]).animate().fadeIn(delay: 700.ms).slideY(begin: 0.1, end: 0),

                  SizedBox(height: 32.h),

                  // Logout button
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => _showLogoutConfirmation(context, ref),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.red),
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      child: Text(
                        'Log Out',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ).animate().fadeIn(delay: 800.ms),

                  SizedBox(height: 16.h),

                  // Version
                  Center(
                    child: Text(
                      'Version 1.0.0',
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppColors.textLight,
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
    );
  }

  Widget _buildProfileStat(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 22.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          label,
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.white.withOpacity(0.9),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Builder(
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Text(
          title,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color:
                isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
          ),
        );
      },
    );
  }

  Widget _buildSettingsCard(List<Widget> children) {
    return Builder(builder: (context) {
      final isDark = Theme.of(context).brightness == Brightness.dark;
      return Container(
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
        child: Column(children: children),
      );
    });
  }

  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    String? subtitle,
    Color? titleColor,
    required VoidCallback onTap,
  }) {
    return Builder(
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return ListTile(
          leading: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: AppColors.primary, size: 20.sp),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              color: titleColor ??
                  (isDark ? AppColors.textPrimaryDark : AppColors.textPrimary),
            ),
          ),
          subtitle: subtitle != null
              ? Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: isDark
                        ? AppColors.textSecondaryDark
                        : AppColors.textSecondary,
                  ),
                )
              : null,
          trailing: Icon(
            Icons.chevron_right,
            color: isDark ? AppColors.textTertiaryDark : AppColors.textLight,
            size: 24.sp,
          ),
          onTap: onTap,
        );
      },
    );
  }

  Widget _buildSettingsSwitch({
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Builder(
      builder: (context) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return ListTile(
          leading: Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: AppColors.primary, size: 20.sp),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 15.sp,
              fontWeight: FontWeight.w500,
              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
            ),
          ),
          trailing: Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primary,
          ),
        );
      },
    );
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hour > 12 ? time.hour - 12 : time.hour;
    final period = time.hour >= 12 ? 'PM' : 'AM';
    return '$hour:${time.minute.toString().padLeft(2, '0')} $period';
  }

  String _getPrivacyLabel(String level) {
    switch (level) {
      case 'full':
        return 'Full Analysis (Voice + Text)';
      case 'context':
        return 'Context Only';
      case 'keywords':
        return 'Keywords Only';
      case 'acoustic':
        return 'Acoustic Only';
      default:
        return level;
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context, WidgetRef ref) {
    final nameController =
        TextEditingController(text: ref.read(currentUserProvider)?.name ?? '');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        title: const Text('Edit Profile'),
        content: TextField(
          controller: nameController,
          decoration: InputDecoration(
            labelText: 'Name',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // In real app, update profile
              Navigator.pop(context);
              _showSnackBar(context, 'Profile updated');
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showTimePicker(
      BuildContext context, WidgetRef ref, TimeOfDay currentTime) async {
    final time = await showTimePicker(
      context: context,
      initialTime: currentTime,
    );
    if (time != null) {
      ref.read(settingsProvider.notifier).setReminderTime(time);
    }
  }

  void _showLanguageSelector(BuildContext context, WidgetRef ref) {
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
              'Select Voice Language',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color:
                    isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 24.h),
            ListTile(
              leading: const Text('🇺🇸', style: TextStyle(fontSize: 24)),
              title: Text('English',
                  style: TextStyle(
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimary)),
              trailing: ref.read(settingsProvider).voiceLanguage == 'en'
                  ? Icon(Icons.check_circle, color: AppColors.primary)
                  : null,
              onTap: () {
                ref.read(settingsProvider.notifier).setVoiceLanguage('en');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Text('🇧🇩', style: TextStyle(fontSize: 24)),
              title: Text('বাংলা (Bengali)',
                  style: TextStyle(
                      color: isDark
                          ? AppColors.textPrimaryDark
                          : AppColors.textPrimary)),
              trailing: ref.read(settingsProvider).voiceLanguage == 'bn'
                  ? Icon(Icons.check_circle, color: AppColors.primary)
                  : null,
              onTap: () {
                ref.read(settingsProvider.notifier).setVoiceLanguage('bn');
                Navigator.pop(context);
              },
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom + 16.h),
          ],
        ),
      ),
    );
  }

  void _showLogoutConfirmation(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: const Text('Log Out?'),
        content: const Text('Are you sure you want to log out?'),
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
              ref.read(authProvider.notifier).logout();
              Navigator.pop(context);
              context.go('/login');
            },
            child: const Text(
              'Log Out',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: const Text('Delete All Data?'),
        content: const Text(
          'This will permanently delete all your voice entries, insights, and patterns. This action cannot be undone.',
        ),
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
              // Clear all data
              ref.read(entriesProvider.notifier).clearAll();
              ref.read(insightsProvider.notifier).clearAll();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('All data deleted'),
                  backgroundColor: Colors.red,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
              );
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: Row(
          children: [
            Text('🎤', style: TextStyle(fontSize: 28.sp)),
            SizedBox(width: 12.w),
            const Text('Resonate'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Your voice speaks louder than words.',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Resonate is your personal emotional wellness companion. '
              'Express yourself through voice, and let AI help you understand '
              'your emotional patterns and wellbeing journey.',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Version 1.0.0',
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.textTertiary,
              ),
            ),
            Text(
              '© 2026 Resonate Team',
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.textTertiary,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Close',
              style: TextStyle(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }

  void _showHelpDialog(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.all(24.w),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Help & Support',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color:
                    isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
              ),
            ),
            SizedBox(height: 24.h),
            _buildHelpItem(
              icon: Icons.record_voice_over,
              title: 'How to Record',
              description:
                  'Tap the microphone button on the home screen to start recording your voice check-in.',
              isDark: isDark,
            ),
            SizedBox(height: 16.h),
            _buildHelpItem(
              icon: Icons.insights,
              title: 'Understanding Insights',
              description:
                  'View your emotional patterns and trends in the Insights tab.',
              isDark: isDark,
            ),
            SizedBox(height: 16.h),
            _buildHelpItem(
              icon: Icons.privacy_tip,
              title: 'Your Privacy',
              description:
                  'Your voice recordings are processed securely. You control what data is stored.',
              isDark: isDark,
            ),
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  _showSnackBar(context, 'Contact support: help@resonate.app');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: const Text('Contact Support'),
              ),
            ),
            SizedBox(height: MediaQuery.of(context).padding.bottom + 16.h),
          ],
        ),
      ),
    );
  }

  Widget _buildHelpItem({
    required IconData icon,
    required String title,
    required String description,
    required bool isDark,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: AppColors.primarySurface,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(icon, color: AppColors.primary, size: 20.sp),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
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
                  fontSize: 12.sp,
                  color: isDark
                      ? AppColors.textSecondaryDark
                      : AppColors.textSecondary,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showRateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: const Text('Enjoying Resonate?'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'We\'d love to hear your feedback! Rate us to help others discover Resonate.',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.textSecondary,
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    _showSnackBar(context,
                        'Thank you for rating us ${index + 1} stars! ⭐');
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Icon(
                      Icons.star_rounded,
                      size: 40.sp,
                      color: AppColors.warning,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Maybe Later',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
        ],
      ),
    );
  }

  void _showChangePasswordDialog(BuildContext context) {
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.r),
        ),
        title: const Text('Change Password'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: currentPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Current Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            TextField(
              controller: newPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'New Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
            SizedBox(height: 12.h),
            TextField(
              controller: confirmPasswordController,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Confirm New Password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ],
        ),
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
              if (newPasswordController.text ==
                  confirmPasswordController.text) {
                Navigator.pop(context);
                _showSnackBar(context, 'Password changed successfully! ✓');
              } else {
                _showSnackBar(context, 'Passwords do not match');
              }
            },
            child: Text(
              'Change',
              style: TextStyle(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }

  void _showEmailPreferencesDialog(BuildContext context, WidgetRef ref) {
    bool weeklyDigest = true;
    bool insightAlerts = true;
    bool productUpdates = false;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          title: const Text('Email Preferences'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SwitchListTile(
                title: const Text('Weekly Digest'),
                subtitle: const Text('Receive weekly mood summaries'),
                value: weeklyDigest,
                activeColor: AppColors.primary,
                onChanged: (value) =>
                    setDialogState(() => weeklyDigest = value),
              ),
              SwitchListTile(
                title: const Text('Insight Alerts'),
                subtitle: const Text('Get notified about new insights'),
                value: insightAlerts,
                activeColor: AppColors.primary,
                onChanged: (value) =>
                    setDialogState(() => insightAlerts = value),
              ),
              SwitchListTile(
                title: const Text('Product Updates'),
                subtitle: const Text('News about new features'),
                value: productUpdates,
                activeColor: AppColors.primary,
                onChanged: (value) =>
                    setDialogState(() => productUpdates = value),
              ),
            ],
          ),
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
                Navigator.pop(context);
                _showSnackBar(context, 'Email preferences saved! ✓');
              },
              child: Text(
                'Save',
                style: TextStyle(color: AppColors.primary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
