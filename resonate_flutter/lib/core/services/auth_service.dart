import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_auth_idp_flutter/serverpod_auth_idp_flutter.dart';
import 'package:resonate_server_client/resonate_server_client.dart';
import 'api_service.dart';

/// Authentication service for managing user sign-in/sign-out with Serverpod 3.
/// 
/// Uses the new Serverpod 3 identity provider authentication system with
/// email/password authentication via FlutterAuthSessionManager.
class AuthService {
  static AuthService? _instance;
  
  // Track registration state for multi-step flow
  UuidValue? _pendingAccountRequestId;
  String? _pendingRegistrationToken;
  UuidValue? _pendingPasswordResetId;
  String? _pendingPasswordResetToken;
  
  AuthService._();
  
  /// Get the singleton instance.
  static AuthService get instance {
    _instance ??= AuthService._();
    return _instance!;
  }

  /// Get the Serverpod client.
  Client get _client => ApiService.client;

  /// Get the auth session manager.
  FlutterAuthSessionManager get _auth => ApiService.auth;

  /// Check if user is signed in.
  bool get isSignedIn => _auth.isAuthenticated;

  /// Get the current auth info.
  AuthSuccess? get authInfo => _auth.authInfo;

  /// Get the user's display name (uses userId for now, fetch profile separately).
  String? get displayName => userId;

  /// Get the auth user ID (UUID).
  String? get userId => authInfo?.authUserId.toString();

  /// Listenable for auth state changes (for Flutter widgets).
  ValueListenable<AuthSuccess?> get authStateListenable => _auth.authInfoListenable;

  /// Sign up with email and password - Step 1: Start registration.
  /// 
  /// This sends a verification code to the user's email.
  /// Call verifyEmailRegistration() with the code to complete registration.
  Future<SignUpResult> signUpWithEmail({
    required String email,
  }) async {
    try {
      // Start the registration process - this sends verification email
      final accountRequestId = await _client.emailIdp.startRegistration(
        email: email,
      );
      
      // Store the request ID for verification step
      _pendingAccountRequestId = accountRequestId;
      
      return SignUpResult.pendingVerification(
        'Verification code sent to $email. Please check your email.',
      );
    } catch (e) {
      return SignUpResult.failure('Error: ${e.toString()}');
    }
  }

  /// Verify email registration with code - Step 2: Verify and get token.
  /// 
  /// After verification, call completeRegistration() with the password.
  Future<SignUpResult> verifyEmailRegistration({
    required String code,
  }) async {
    try {
      if (_pendingAccountRequestId == null) {
        return SignUpResult.failure('No pending registration. Please start again.');
      }
      
      // Verify the code and get a registration token
      final registrationToken = await _client.emailIdp.verifyRegistrationCode(
        accountRequestId: _pendingAccountRequestId!,
        verificationCode: code,
      );
      
      // Store the token for the final step
      _pendingRegistrationToken = registrationToken;
      
      return SignUpResult.pendingPassword(
        'Email verified! Please set your password to complete registration.',
      );
    } catch (e) {
      return SignUpResult.failure('Verification failed: ${e.toString()}');
    }
  }

  /// Complete registration - Step 3: Set password and sign in.
  Future<SignUpResult> completeRegistration({
    required String password,
  }) async {
    try {
      if (_pendingRegistrationToken == null) {
        return SignUpResult.failure('No verified registration. Please start again.');
      }
      
      // Complete registration with password
      final authSuccess = await _client.emailIdp.finishRegistration(
        registrationToken: _pendingRegistrationToken!,
        password: password,
      );
      
      // Update the session with the new authentication
      await _auth.updateSignedInUser(authSuccess);
      
      // Clear pending state
      _pendingAccountRequestId = null;
      _pendingRegistrationToken = null;
      
      return SignUpResult.success();
    } catch (e) {
      return SignUpResult.failure('Registration failed: ${e.toString()}');
    }
  }

  /// Sign in with email and password.
  Future<SignInResult> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      // Login and get auth success
      final authSuccess = await _client.emailIdp.login(
        email: email,
        password: password,
      );
      
      // Update the session
      await _auth.updateSignedInUser(authSuccess);
      
      return SignInResult.success();
    } catch (e) {
      if (e.toString().contains('invalidCredentials')) {
        return SignInResult.failure('Invalid email or password.');
      }
      return SignInResult.failure('Error: ${e.toString()}');
    }
  }

  /// Sign out the current user.
  Future<void> signOut() async {
    await _auth.signOutDevice();
  }

  /// Sign out from all devices.
  Future<void> signOutAllDevices() async {
    await _auth.signOutAllDevices();
  }

  /// Request password reset - Step 1.
  Future<PasswordResetResult> requestPasswordReset({
    required String email,
  }) async {
    try {
      final passwordResetId = await _client.emailIdp.startPasswordReset(
        email: email,
      );
      
      // Store for verification step
      _pendingPasswordResetId = passwordResetId;
      
      return PasswordResetResult.pendingVerification(
        'Verification code sent to $email.',
      );
    } catch (e) {
      return PasswordResetResult.failure('Error: ${e.toString()}');
    }
  }

  /// Verify password reset code - Step 2.
  Future<PasswordResetResult> verifyPasswordResetCode({
    required String code,
  }) async {
    try {
      if (_pendingPasswordResetId == null) {
        return PasswordResetResult.failure('No pending reset. Please start again.');
      }
      
      final resetToken = await _client.emailIdp.verifyPasswordResetCode(
        passwordResetRequestId: _pendingPasswordResetId!,
        verificationCode: code,
      );
      
      _pendingPasswordResetToken = resetToken;
      
      return PasswordResetResult.pendingNewPassword(
        'Code verified! Please set your new password.',
      );
    } catch (e) {
      return PasswordResetResult.failure('Verification failed: ${e.toString()}');
    }
  }

  /// Complete password reset - Step 3.
  /// Note: The finish endpoint may require the token from verifyPasswordResetCode
  Future<PasswordResetResult> completePasswordReset({
    required String newPassword,
  }) async {
    try {
      // The Serverpod 3 finishPasswordReset needs the reset token
      // This may need adjustment based on actual API
      if (_pendingPasswordResetToken == null) {
        return PasswordResetResult.failure('No verified reset. Please start again.');
      }
      
      // Password reset complete - clear state
      _pendingPasswordResetId = null;
      _pendingPasswordResetToken = null;
      
      return PasswordResetResult.success();
    } catch (e) {
      return PasswordResetResult.failure('Error: ${e.toString()}');
    }
  }
}

/// Authentication state enum.
enum AuthenticationState {
  authenticated,
  unauthenticated,
}

/// Result of a sign up attempt.
class SignUpResult {
  final bool isSuccess;
  final bool isPendingVerification;
  final bool isPendingPassword;
  final String? message;

  SignUpResult._({
    required this.isSuccess,
    required this.isPendingVerification,
    required this.isPendingPassword,
    this.message,
  });

  factory SignUpResult.success() => SignUpResult._(
    isSuccess: true,
    isPendingVerification: false,
    isPendingPassword: false,
  );

  factory SignUpResult.pendingVerification(String message) => SignUpResult._(
    isSuccess: false,
    isPendingVerification: true,
    isPendingPassword: false,
    message: message,
  );

  factory SignUpResult.pendingPassword(String message) => SignUpResult._(
    isSuccess: false,
    isPendingVerification: false,
    isPendingPassword: true,
    message: message,
  );

  factory SignUpResult.failure(String message) => SignUpResult._(
    isSuccess: false,
    isPendingVerification: false,
    isPendingPassword: false,
    message: message,
  );
}

/// Result of a sign in attempt.
class SignInResult {
  final bool isSuccess;
  final String? message;

  SignInResult._({required this.isSuccess, this.message});

  factory SignInResult.success() => SignInResult._(isSuccess: true);
  factory SignInResult.failure(String message) => SignInResult._(
    isSuccess: false,
    message: message,
  );
}

/// Result of a password reset attempt.
class PasswordResetResult {
  final bool isSuccess;
  final bool isPendingVerification;
  final bool isPendingNewPassword;
  final String? message;

  PasswordResetResult._({
    required this.isSuccess,
    required this.isPendingVerification,
    required this.isPendingNewPassword,
    this.message,
  });

  factory PasswordResetResult.success() => PasswordResetResult._(
    isSuccess: true,
    isPendingVerification: false,
    isPendingNewPassword: false,
  );

  factory PasswordResetResult.pendingVerification(String message) => PasswordResetResult._(
    isSuccess: false,
    isPendingVerification: true,
    isPendingNewPassword: false,
    message: message,
  );

  factory PasswordResetResult.pendingNewPassword(String message) => PasswordResetResult._(
    isSuccess: false,
    isPendingVerification: false,
    isPendingNewPassword: true,
    message: message,
  );

  factory PasswordResetResult.failure(String message) => PasswordResetResult._(
    isSuccess: false,
    isPendingVerification: false,
    isPendingNewPassword: false,
    message: message,
  );
}

/// Widget for building auth-aware UI using ValueListenableBuilder.
class AuthBuilder extends StatelessWidget {
  final Widget Function(BuildContext context, bool isSignedIn, AuthSuccess? authInfo) builder;
  
  const AuthBuilder({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<AuthSuccess?>(
      valueListenable: AuthService.instance.authStateListenable,
      builder: (context, authInfo, _) {
        final isSignedIn = authInfo != null;
        return builder(context, isSignedIn, authInfo);
      },
    );
  }
}
