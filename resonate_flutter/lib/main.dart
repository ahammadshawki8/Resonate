import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/theme/app_theme.dart';
import 'navigation/app_router.dart';
import 'providers/app_providers.dart';

/// Global theme mode notifier to avoid rebuilding MaterialApp
final ValueNotifier<ThemeMode> themeModeNotifier =
    ValueNotifier(ThemeMode.light);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const ProviderScope(child: ResonateApp()));
}

class ResonateApp extends ConsumerStatefulWidget {
  const ResonateApp({super.key});

  @override
  ConsumerState<ResonateApp> createState() => _ResonateAppState();
}

class _ResonateAppState extends ConsumerState<ResonateApp> {
  @override
  void initState() {
    super.initState();
    // Sync initial theme state
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final isDark = ref.read(settingsProvider).darkMode;
      themeModeNotifier.value = isDark ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Listen to settings changes and update theme notifier
    ref.listen<bool>(
      settingsProvider.select((s) => s.darkMode),
      (previous, next) {
        themeModeNotifier.value = next ? ThemeMode.dark : ThemeMode.light;
      },
    );

    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (context, child) {
        // Use ValueListenableBuilder to listen to theme changes
        // This avoids rebuilding the entire widget tree
        return ValueListenableBuilder<ThemeMode>(
          valueListenable: themeModeNotifier,
          builder: (context, themeMode, _) {
            return MaterialApp.router(
              title: 'Resonate',
              debugShowCheckedModeBanner: false,
              theme: AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: themeMode,
              // Disable theme animation to prevent TextStyle interpolation errors
              themeAnimationDuration: Duration.zero,
              routerConfig: appRouter,
            );
          },
        );
      },
    );
  }
}
