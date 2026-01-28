import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_colors.dart';
import '../../widgets/shared_widgets.dart';
import '../../providers/app_providers.dart';
import '../../data/repositories/repositories.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  bool _agreedToTerms = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.error,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      ),
    );
  }

  Future<void> _signup() async {
    if (_nameController.text.isEmpty) {
      _showError('Please enter your name');
      return;
    }
    if (_emailController.text.isEmpty) {
      _showError('Please enter your email');
      return;
    }
    if (_passwordController.text.isEmpty) {
      _showError('Please enter a password');
      return;
    }
    if (_passwordController.text.length < 8) {
      _showError('Password must be at least 8 characters');
      return;
    }
    if (!_agreedToTerms) {
      _showError('Please agree to the terms and conditions');
      return;
    }
    
    setState(() => _isLoading = true);
    
    // Step 1: Start registration (sends verification code)
    final result = await ref.read(authProvider.notifier).signup(
      _emailController.text,
      _passwordController.text,
    );
    
    if (mounted) {
      setState(() => _isLoading = false);
      
      // Check if we need verification
      final authState = ref.read(authProvider);
      if (authState.error != null && authState.error!.contains('Verification code sent')) {
        // Show verification dialog
        _showVerificationDialog();
      } else if (result) {
        // Registration complete (shouldn't happen with email verification)
        context.go('/home');
      } else {
        // Show error
        _showError(authState.error ?? 'Signup failed. Please try again.');
      }
    }
  }

  Future<void> _showVerificationDialog() async {
    final codeController = TextEditingController();
    
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        title: Text(
          'Verify Your Email',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'We sent a verification code to:',
              style: TextStyle(fontSize: 14.sp, color: AppColors.textSecondary),
            ),
            SizedBox(height: 8.h),
            Text(
              _emailController.text,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Check your Serverpod terminal for the code',
              style: TextStyle(
                fontSize: 13.sp,
                color: AppColors.textSecondary,
                fontStyle: FontStyle.italic,
              ),
            ),
            SizedBox(height: 16.h),
            TextField(
              controller: codeController,
              keyboardType: TextInputType.number,
              maxLength: 8,
              style: TextStyle(fontSize: 18.sp, letterSpacing: 2),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                hintText: 'Enter code',
                counterText: '',
                filled: true,
                fillColor: AppColors.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AppColors.primary, width: 2),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('Cancel', style: TextStyle(color: AppColors.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () async {
              if (codeController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Please enter the verification code')),
                );
                return;
              }
              Navigator.pop(context, true);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text('Verify'),
          ),
        ],
      ),
    );
    
    if (result == true && codeController.text.isNotEmpty) {
      // Step 2: Verify code and complete registration
      setState(() => _isLoading = true);
      
      final success = await ref.read(authProvider.notifier).signup(
        _emailController.text,
        _passwordController.text,
        verificationCode: codeController.text,
      );
      
      if (mounted) {
        setState(() => _isLoading = false);
        
        if (success) {
          // Update profile with the user's name
          try {
            await UserProfileRepository.instance.updateProfile(
              displayName: _nameController.text,
            );
          } catch (e) {
            // Profile update failed, but user is still logged in
            debugPrint('Failed to update profile name: $e');
          }
          
          // Fetch user data after successful signup
          await Future.wait([
            ref.read(settingsProvider.notifier).fetchSettings(),
            ref.read(entriesProvider.notifier).fetchEntries(),
            ref.read(insightsProvider.notifier).fetchInsights(),
          ]);
          
          context.go('/home');
        } else {
          final authState = ref.read(authProvider);
          _showError(authState.error ?? 'Verification failed. Please try again.');
        }
      }
    }
    
    codeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              
              // Back button
              GestureDetector(
                onTap: () => context.go('/login'),
                child: Container(
                  padding: EdgeInsets.all(10.w),
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Icon(
                    Icons.arrow_back_rounded,
                    color: AppColors.textPrimary,
                    size: 24.sp,
                  ),
                ),
              ),
              
              SizedBox(height: 24.h),
              
              // Logo
              Center(
                child: Container(
                  width: 60.w,
                  height: 60.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.15),
                        blurRadius: 12,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ClipOval(
                    child: Image.asset(
                      'assets/images/brand_logo_dark.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ).animate().scale(
                  begin: const Offset(0.7, 0.7),
                  end: const Offset(1, 1),
                  duration: 400.ms,
                  curve: Curves.easeOut,
                ),
              ),
              
              SizedBox(height: 24.h),
              
              // Header
              Text(
                'Create Account',
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ).animate().fadeIn(delay: 100.ms),
              
              SizedBox(height: 8.h),
              
              Text(
                'Start your emotional wellness journey',
                style: TextStyle(
                  fontSize: 15.sp,
                  color: AppColors.textSecondary,
                ),
              ).animate().fadeIn(delay: 200.ms),
              
              SizedBox(height: 40.h),
              
              // Name field
              _buildLabel('Full Name'),
              SizedBox(height: 8.h),
              _buildTextField(
                controller: _nameController,
                hintText: 'Enter your name',
                prefixIcon: Icons.person_outline,
              ).animate().fadeIn(delay: 300.ms).slideX(begin: -0.1, end: 0),
              
              SizedBox(height: 20.h),
              
              // Email field
              _buildLabel('Email'),
              SizedBox(height: 8.h),
              _buildTextField(
                controller: _emailController,
                hintText: 'your@email.com',
                prefixIcon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ).animate().fadeIn(delay: 400.ms).slideX(begin: -0.1, end: 0),
              
              SizedBox(height: 20.h),
              
              // Password field
              _buildLabel('Password'),
              SizedBox(height: 8.h),
              _buildTextField(
                controller: _passwordController,
                hintText: 'Create a strong password',
                prefixIcon: Icons.lock_outline,
                obscureText: _obscurePassword,
                suffixIcon: IconButton(
                  icon: Icon(
                    _obscurePassword 
                        ? Icons.visibility_outlined 
                        : Icons.visibility_off_outlined,
                    color: AppColors.textSecondary,
                  ),
                  onPressed: () {
                    setState(() => _obscurePassword = !_obscurePassword);
                  },
                ),
              ).animate().fadeIn(delay: 500.ms).slideX(begin: -0.1, end: 0),
              
              SizedBox(height: 8.h),
              
              // Password requirements
              _buildPasswordHint('At least 8 characters'),
              _buildPasswordHint('One uppercase letter'),
              _buildPasswordHint('One number'),
              
              SizedBox(height: 24.h),
              
              // Terms checkbox
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 24.w,
                    height: 24.w,
                    child: Checkbox(
                      value: _agreedToTerms,
                      onChanged: (value) {
                        setState(() => _agreedToTerms = value ?? false);
                      },
                      activeColor: AppColors.primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.r),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text.rich(
                      TextSpan(
                        text: 'I agree to the ',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.textSecondary,
                        ),
                        children: [
                          TextSpan(
                            text: 'Terms of Service',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ).animate().fadeIn(delay: 600.ms),
              
              SizedBox(height: 32.h),
              
              // Signup button
              GradientButton(
                text: 'Create Account',
                onPressed: _signup,
                isLoading: _isLoading,
              ).animate().fadeIn(delay: 700.ms).slideY(begin: 0.2, end: 0),
              
              SizedBox(height: 24.h),
              
              // Divider
              Row(
                children: [
                  Expanded(child: Divider(color: AppColors.divider)),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Text(
                      'or sign up with',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: AppColors.divider)),
                ],
              ),
              
              SizedBox(height: 24.h),
              
              // Social buttons
              Row(
                children: [
                  Expanded(
                    child: _buildSocialButton(
                      'Google',
                      Icons.g_mobiledata,
                      () {},
                    ),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: _buildSocialButton(
                      'Apple',
                      Icons.apple,
                      () {},
                    ),
                  ),
                ],
              ).animate().fadeIn(delay: 800.ms),
              
              SizedBox(height: 32.h),
              
              // Login link
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 15.sp,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context.go('/login'),
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData prefixIcon,
    TextInputType? keyboardType,
    bool obscureText = false,
    Widget? suffixIcon,
  }) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: TextStyle(fontSize: 16.sp),
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: Icon(prefixIcon, color: AppColors.textSecondary),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: AppColors.surface,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: AppColors.divider),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: AppColors.primary, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      ),
    );
  }

  Widget _buildPasswordHint(String text) {
    return Padding(
      padding: EdgeInsets.only(top: 4.h),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outline,
            size: 14.sp,
            color: AppColors.textLight,
          ),
          SizedBox(width: 6.w),
          Text(
            text,
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.textLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialButton(String label, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.divider),
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24.sp, color: AppColors.textPrimary),
            SizedBox(width: 8.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
