import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';
import '../../providers/app_providers.dart';
import '../../data/models/models.dart';

class WellnessHistoryScreen extends ConsumerStatefulWidget {
  const WellnessHistoryScreen({super.key});

  @override
  ConsumerState<WellnessHistoryScreen> createState() => _WellnessHistoryScreenState();
}

class _WellnessHistoryScreenState extends ConsumerState<WellnessHistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final journals = ref.watch(journalProvider);
    final gratitudes = ref.watch(gratitudeProvider);
    final goals = ref.watch(wellnessGoalProvider);
    final contacts = ref.watch(favoriteContactProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Wellness History',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppColors.primary,
          labelColor: AppColors.primary,
          unselectedLabelColor: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
          labelPadding: EdgeInsets.symmetric(horizontal: 8.w),
          tabs: [
            Tab(
              icon: Text('📓', style: TextStyle(fontSize: 18.sp)),
              text: 'Journals (${journals.length})',
            ),
            Tab(
              icon: Text('🙏', style: TextStyle(fontSize: 18.sp)),
              text: 'Gratitude (${gratitudes.length})',
            ),
            Tab(
              icon: Text('🎯', style: TextStyle(fontSize: 18.sp)),
              text: 'Goals (${goals.length})',
            ),
            Tab(
              icon: Text('📞', style: TextStyle(fontSize: 18.sp)),
              text: 'Contacts (${contacts.length})',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildJournalList(journals, isDark),
          _buildGratitudeList(gratitudes, isDark),
          _buildGoalsList(goals, isDark),
          _buildContactsList(contacts, isDark),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (_tabController.index == 0) {
            _showAddJournalDialog(context);
          } else if (_tabController.index == 1) {
            _showAddGratitudeDialog(context);
          } else if (_tabController.index == 2) {
            _showAddGoalDialog(context);
          } else {
            _showAddContactDialog(context);
          }
        },
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: Text(
          _tabController.index == 0 ? 'New Journal' : (_tabController.index == 1 ? 'New Gratitude' : (_tabController.index == 2 ? 'New Goal' : 'New Contact')),
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildJournalList(List<JournalEntry> journals, bool isDark) {
    if (journals.isEmpty) {
      return _buildEmptyState(
        emoji: '📓',
        title: 'No Journal Entries Yet',
        subtitle: 'Start writing to track your thoughts and feelings',
        isDark: isDark,
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: journals.length,
      itemBuilder: (context, index) {
        final journal = journals[index];
        return _buildJournalCard(journal, isDark, index);
      },
    );
  }

  Widget _buildJournalCard(JournalEntry journal, bool isDark, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () => _showJournalDetail(journal, isDark),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Colors.purple.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Text('📓', style: TextStyle(fontSize: 20.sp)),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _formatDate(journal.createdAt),
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            _formatTime(journal.createdAt),
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete_outline, color: Colors.red.withOpacity(0.7), size: 20.sp),
                      onPressed: () => _confirmDeleteJournal(journal),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      Text('💭', style: TextStyle(fontSize: 14.sp)),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          journal.prompt,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontStyle: FontStyle.italic,
                            color: AppColors.primary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  journal.content,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                    height: 1.5,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(delay: (index * 50).ms).slideX(begin: 0.1, end: 0);
  }

  Widget _buildGratitudeList(List<GratitudeEntry> gratitudes, bool isDark) {
    if (gratitudes.isEmpty) {
      return _buildEmptyState(
        emoji: '🙏',
        title: 'No Gratitude Entries Yet',
        subtitle: 'Practice gratitude daily for a positive mindset',
        isDark: isDark,
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: gratitudes.length,
      itemBuilder: (context, index) {
        final gratitude = gratitudes[index];
        return _buildGratitudeCard(gratitude, isDark, index);
      },
    );
  }

  Widget _buildGratitudeCard(GratitudeEntry gratitude, bool isDark, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: Colors.amber.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text('🙏', style: TextStyle(fontSize: 20.sp)),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _formatDate(gratitude.createdAt),
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        _formatTime(gratitude.createdAt),
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.delete_outline, color: Colors.red.withOpacity(0.7), size: 20.sp),
                  onPressed: () => _confirmDeleteGratitude(gratitude),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            ...gratitude.items.asMap().entries.map((entry) {
              final idx = entry.key;
              final item = entry.value;
              return Padding(
                padding: EdgeInsets.only(bottom: 8.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 24.w,
                      height: 24.w,
                      decoration: BoxDecoration(
                        color: Colors.amber.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          '${idx + 1}',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.amber[800],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        item,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    ).animate().fadeIn(delay: (index * 50).ms).slideX(begin: 0.1, end: 0);
  }

  Widget _buildEmptyState({
    required String emoji,
    required String title,
    required String subtitle,
    required bool isDark,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(emoji, style: TextStyle(fontSize: 64.sp))
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .scale(begin: const Offset(1, 1), end: const Offset(1.1, 1.1), duration: 1000.ms),
          SizedBox(height: 24.h),
          Text(
            title,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 14.sp,
              color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showJournalDetail(JournalEntry journal, bool isDark) {
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
            Row(
              children: [
                Text('📓', style: TextStyle(fontSize: 32.sp)),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Journal Entry',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        '${_formatDate(journal.createdAt)} at ${_formatTime(journal.createdAt)}',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Row(
                children: [
                  Text('💭', style: TextStyle(fontSize: 18.sp)),
                  SizedBox(width: 10.w),
                  Expanded(
                    child: Text(
                      journal.prompt,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontStyle: FontStyle.italic,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  journal.content,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                    height: 1.6,
                  ),
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
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                ),
                child: const Text('Close', style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddJournalDialog(BuildContext context) {
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

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: Container(
          height: MediaQuery.of(ctx).size.height * 0.6,
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
                  '📓 New Journal Entry',
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                padding: EdgeInsets.all(14.w),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Text('💭', style: TextStyle(fontSize: 22.sp)),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        prompt,
                        style: TextStyle(
                          fontSize: 14.sp,
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
                    hintStyle: TextStyle(color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary),
                    filled: true,
                    fillColor: isDark ? AppColors.cardDark : AppColors.surface,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16.r),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
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
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('📓 Journal entry saved!'),
                          backgroundColor: AppColors.success,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                  ),
                  child: const Text('Save Entry', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showAddGratitudeDialog(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final List<TextEditingController> controllers = List.generate(3, (_) => TextEditingController());

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),
        child: Container(
          height: MediaQuery.of(ctx).size.height * 0.55,
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
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'List 3 things you\'re grateful for today',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                ),
              ),
              SizedBox(height: 20.h),
              Expanded(
                child: ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: TextField(
                      controller: controllers[index],
                      decoration: InputDecoration(
                        prefixIcon: Text('${index + 1}.', style: TextStyle(fontSize: 18.sp, color: AppColors.primary)),
                        prefixIconConstraints: BoxConstraints(minWidth: 40.w),
                        hintText: 'I\'m grateful for...',
                        hintStyle: TextStyle(color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary),
                        filled: true,
                        fillColor: isDark ? AppColors.cardDark : AppColors.surface,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      style: TextStyle(color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    final items = controllers.map((c) => c.text.trim()).where((t) => t.isNotEmpty).toList();
                    if (items.isNotEmpty) {
                      final entry = GratitudeEntry(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        createdAt: DateTime.now(),
                        items: items,
                      );
                      ref.read(gratitudeProvider.notifier).addEntry(entry);
                      Navigator.pop(ctx);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('🙏 Gratitude saved!'),
                          backgroundColor: AppColors.success,
                        ),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
                  ),
                  child: const Text('Save Gratitude', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmDeleteJournal(JournalEntry journal) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        title: const Text('Delete Journal Entry?'),
        content: const Text('This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(journalProvider.notifier).deleteEntry(journal.id);
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Journal entry deleted'), backgroundColor: AppColors.error),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteGratitude(GratitudeEntry gratitude) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        title: const Text('Delete Gratitude Entry?'),
        content: const Text('This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(gratitudeProvider.notifier).deleteEntry(gratitude.id);
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Gratitude entry deleted'), backgroundColor: AppColors.error),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  // Goals List
  Widget _buildGoalsList(List<WellnessGoal> goals, bool isDark) {
    if (goals.isEmpty) {
      return _buildEmptyState(
        emoji: '🎯',
        title: 'No Goals Set Yet',
        subtitle: 'Set wellness goals to track your progress',
        isDark: isDark,
      );
    }

    final activeGoals = goals.where((g) => !g.isCompleted).toList();
    final completedGoals = goals.where((g) => g.isCompleted).toList();

    return ListView(
      padding: EdgeInsets.all(16.w),
      children: [
        if (activeGoals.isNotEmpty) ...[
          Text(
            'Active Goals',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
            ),
          ),
          SizedBox(height: 12.h),
          ...activeGoals.asMap().entries.map((entry) => _buildGoalCard(entry.value, isDark, entry.key)),
        ],
        if (completedGoals.isNotEmpty) ...[
          SizedBox(height: 24.h),
          Text(
            'Completed (✅ ${completedGoals.length})',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.success,
            ),
          ),
          SizedBox(height: 12.h),
          ...completedGoals.asMap().entries.map((entry) => _buildGoalCard(entry.value, isDark, entry.key)),
        ],
      ],
    );
  }

  Widget _buildGoalCard(WellnessGoal goal, bool isDark, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: goal.isCompleted ? Border.all(color: AppColors.success.withOpacity(0.5), width: 2) : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () => ref.read(wellnessGoalProvider.notifier).toggleGoal(goal.id),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                // Checkbox
                Container(
                  width: 28.w,
                  height: 28.w,
                  decoration: BoxDecoration(
                    color: goal.isCompleted ? AppColors.success : Colors.transparent,
                    border: Border.all(
                      color: goal.isCompleted ? AppColors.success : AppColors.primary,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: goal.isCompleted
                      ? Icon(Icons.check, color: Colors.white, size: 18.sp)
                      : null,
                ),
                SizedBox(width: 16.w),
                // Emoji
                Text(goal.emoji, style: TextStyle(fontSize: 24.sp)),
                SizedBox(width: 12.w),
                // Title
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        goal.title,
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: goal.isCompleted
                              ? (isDark ? AppColors.textSecondaryDark : AppColors.textSecondary)
                              : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimary),
                          decoration: goal.isCompleted ? TextDecoration.lineThrough : null,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        goal.isCompleted
                            ? 'Completed ${_formatDate(goal.completedAt!)}'
                            : 'Added ${_formatDate(goal.createdAt)}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                // Delete button
                IconButton(
                  icon: Icon(Icons.delete_outline, color: Colors.red.withOpacity(0.7), size: 20.sp),
                  onPressed: () => _confirmDeleteGoal(goal),
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: index * 100)).slideX(begin: 0.1, end: 0);
  }

  void _confirmDeleteGoal(WellnessGoal goal) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        title: const Text('Delete Goal?'),
        content: const Text('This action cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(wellnessGoalProvider.notifier).deleteGoal(goal.id);
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Goal deleted'), backgroundColor: AppColors.error),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showAddGoalDialog(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final customGoalController = TextEditingController();
    final goals = [
      {'emoji': '💧', 'title': 'Drink more water'},
      {'emoji': '😴', 'title': 'Sleep 8 hours'},
      {'emoji': '🚶', 'title': 'Walk 10 min daily'},
      {'emoji': '📵', 'title': 'Less screen time'},
      {'emoji': '🧘', 'title': 'Meditate daily'},
      {'emoji': '📓', 'title': 'Journal nightly'},
      {'emoji': '🍎', 'title': 'Eat healthier'},
      {'emoji': '💪', 'title': 'Exercise regularly'},
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
                Text('🎯 Add a Wellness Goal',
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
                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                    content: Text('🎯 Goal added: ⭐ ${customGoalController.text.trim()}'),
                                    backgroundColor: AppColors.success,
                                    behavior: SnackBarBehavior.floating,
                                    margin: EdgeInsets.only(bottom: 80.h, left: 16.w, right: 16.w)));
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
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text('🎯 Goal added: ${g['emoji']} ${g['title']}'),
                                  backgroundColor: AppColors.success,
                                  behavior: SnackBarBehavior.floating,
                                  margin: EdgeInsets.only(bottom: 80.h, left: 16.w, right: 16.w)));
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

  // Contacts List
  Widget _buildContactsList(List<FavoriteContact> contacts, bool isDark) {
    if (contacts.isEmpty) {
      return _buildEmptyState(
        emoji: '📞',
        title: 'No Contacts Yet',
        subtitle: 'Add your favorite people to call when you need support',
        isDark: isDark,
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16.w),
      itemCount: contacts.length,
      itemBuilder: (context, index) {
        final contact = contacts[index];
        return _buildContactCard(contact, isDark, index);
      },
    );
  }

  Widget _buildContactCard(FavoriteContact contact, bool isDark, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text('📞 Opening phone to call ${contact.name}...'),
                backgroundColor: Colors.green,
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.only(bottom: 80.h, left: 16.w, right: 16.w)));
          },
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                // Emoji avatar
                Container(
                  width: 50.w,
                  height: 50.w,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(contact.emoji, style: TextStyle(fontSize: 24.sp)),
                  ),
                ),
                SizedBox(width: 16.w),
                // Name and type
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        contact.name,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                        decoration: BoxDecoration(
                          color: _getContactTypeColor(contact.type).withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Text(
                          contact.type,
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: _getContactTypeColor(contact.type),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Call button
                Container(
                  width: 44.w,
                  height: 44.w,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(Icons.call, color: Colors.white, size: 22.sp),
                ),
                SizedBox(width: 8.w),
                // Delete button
                IconButton(
                  icon: Icon(Icons.delete_outline, color: Colors.red.withOpacity(0.7), size: 20.sp),
                  onPressed: () => _confirmDeleteContact(contact),
                ),
              ],
            ),
          ),
        ),
      ),
    ).animate().fadeIn(delay: Duration(milliseconds: index * 100)).slideX(begin: 0.1, end: 0);
  }

  Color _getContactTypeColor(String type) {
    switch (type.toLowerCase()) {
      case 'family':
        return Colors.pink;
      case 'friend':
        return Colors.purple;
      case 'professional':
        return Colors.teal;
      default:
        return Colors.blue;
    }
  }

  void _confirmDeleteContact(FavoriteContact contact) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        title: const Text('Delete Contact?'),
        content: Text('Remove ${contact.name} from your favorites?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(favoriteContactProvider.notifier).deleteContact(contact.id);
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Contact removed'), backgroundColor: AppColors.error),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showAddContactDialog(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    String selectedEmoji = '😊';
    String selectedType = 'Friend';
    
    final emojis = ['😊', '👩', '👨', '👧', '👦', '🧑‍🤝‍🧑', '👫', '🧠', '❤️', '⭐'];
    final types = ['Family', 'Friend', 'Professional', 'Other'];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (modalContext) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text('📞 Add Contact',
                        style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.bold,
                            color: isDark
                                ? AppColors.textPrimaryDark
                                : AppColors.textPrimary)),
                  ),
                  SizedBox(height: 8.h),
                  Center(
                    child: Text('Add someone you can call for support',
                        style: TextStyle(
                            fontSize: 14.sp,
                            color: isDark
                                ? AppColors.textSecondaryDark
                                : AppColors.textSecondary)),
                  ),
                  SizedBox(height: 24.h),
                  
                  // Name input
                  Text('Name',
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary)),
                  SizedBox(height: 8.h),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: 'Enter contact name...',
                      hintStyle: TextStyle(
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondary),
                      filled: true,
                      fillColor: isDark ? AppColors.cardDark : AppColors.surface,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
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
                  
                  SizedBox(height: 16.h),
                  
                  // Phone input
                  Text('Phone Number',
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary)),
                  SizedBox(height: 8.h),
                  TextField(
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: 'Enter phone number...',
                      prefixIcon: Icon(Icons.phone, color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary, size: 20.sp),
                      hintStyle: TextStyle(
                          color: isDark
                              ? AppColors.textSecondaryDark
                              : AppColors.textSecondary),
                      filled: true,
                      fillColor: isDark ? AppColors.cardDark : AppColors.surface,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
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
                  
                  SizedBox(height: 16.h),
                  
                  // Emoji picker
                  Text('Choose an emoji',
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary)),
                  SizedBox(height: 8.h),
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: emojis.map((e) => GestureDetector(
                      onTap: () => setModalState(() => selectedEmoji = e),
                      child: Container(
                        width: 44.w,
                        height: 44.w,
                        decoration: BoxDecoration(
                          color: selectedEmoji == e 
                              ? AppColors.primary.withOpacity(0.2) 
                              : (isDark ? AppColors.cardDark : AppColors.surface),
                          borderRadius: BorderRadius.circular(12.r),
                          border: selectedEmoji == e 
                              ? Border.all(color: AppColors.primary, width: 2) 
                              : null,
                        ),
                        child: Center(child: Text(e, style: TextStyle(fontSize: 22.sp))),
                      ),
                    )).toList(),
                  ),
                  
                  SizedBox(height: 20.h),
                  
                  // Type picker
                  Text('Relationship',
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary)),
                  SizedBox(height: 8.h),
                  Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: types.map((t) => GestureDetector(
                      onTap: () => setModalState(() => selectedType = t),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                        decoration: BoxDecoration(
                          color: selectedType == t 
                              ? _getContactTypeColor(t).withOpacity(0.2) 
                              : (isDark ? AppColors.cardDark : AppColors.surface),
                          borderRadius: BorderRadius.circular(20.r),
                          border: selectedType == t 
                              ? Border.all(color: _getContactTypeColor(t), width: 2) 
                              : null,
                        ),
                        child: Text(t,
                            style: TextStyle(
                                fontSize: 13.sp,
                                color: selectedType == t 
                                    ? _getContactTypeColor(t) 
                                    : (isDark ? AppColors.textPrimaryDark : AppColors.textPrimary),
                                fontWeight: FontWeight.w500)),
                      ),
                    )).toList(),
                  ),
                  
                  SizedBox(height: 24.h),
                  
                  // Add button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (nameController.text.trim().isNotEmpty) {
                          final contact = FavoriteContact(
                            id: DateTime.now().millisecondsSinceEpoch.toString(),
                            createdAt: DateTime.now(),
                            name: nameController.text.trim(),
                            emoji: selectedEmoji,
                            type: selectedType,
                            phone: phoneController.text.trim().isNotEmpty ? phoneController.text.trim() : null,
                          );
                          ref.read(favoriteContactProvider.notifier).addContact(contact);
                          Navigator.pop(modalContext);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('📞 ${contact.name} added to contacts!'),
                              backgroundColor: AppColors.success,
                              behavior: SnackBarBehavior.floating,
                              margin: EdgeInsets.only(bottom: 80.h, left: 16.w, right: 16.w)));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r)),
                      ),
                      child: const Text('Add Contact',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.w600)),
                    ),
                  ),
                  SizedBox(height: 16.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final diff = now.difference(date);

    if (diff.inDays == 0) {
      return 'Today';
    } else if (diff.inDays == 1) {
      return 'Yesterday';
    } else if (diff.inDays < 7) {
      return '${diff.inDays} days ago';
    } else {
      final months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
      return '${months[date.month - 1]} ${date.day}, ${date.year}';
    }
  }

  String _formatTime(DateTime date) {
    final hour = date.hour > 12 ? date.hour - 12 : (date.hour == 0 ? 12 : date.hour);
    final period = date.hour >= 12 ? 'PM' : 'AM';
    return '$hour:${date.minute.toString().padLeft(2, '0')} $period';
  }
}
