import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

abstract class AppColors {
  // Light Mode
  static const brightnessLight = Brightness.light;
  static const primaryLight = Color(0xff005db7);
  static const onPrimaryLight = Color(0xffffffff);
  static const primaryContainerLight = Color(0xffd6e3ff);
  static const onPrimaryContainerLight = Color(0xff001b3d);
  static const secondaryLight = Color(0xff555f71);
  static const onSecondaryLight = Color(0xffffffff);
  static const secondaryContainerLight = Color(0xffdae2f9);
  static const onSecondaryContainerLight = Color(0xff121c2b);
  static const tertiaryLight = Color(0xff6f5575);
  static const onTertiaryLight = Color(0xffffffff);
  static const tertiaryContainerLight = Color(0xfff9d8fd);
  static const onTertiaryContainerLight = Color(0xff28132f);
  static const errorLight = Color(0xffba1a1a);
  static const onErrorLight = Color(0xffffffff);
  static const errorContainerLight = Color(0xffffdad6);
  static const onErrorContainerLight = Color(0xff410002);
  static const backgroundLight = Color(0xfffdfbff);
  static const onBackgroundLight = Color(0xff1a1b1e);
  static const surfaceLight = Color(0xfffdfbff);
  static const onSurfaceLight = Color(0xff1a1b1e);
  static const surfaceVariantLight = Color(0xffe0e2ec);
  static const onSurfaceVariantLight = Color(0xff44474e);
  static const outlineLight = Color(0xff74777f);
  static const outlineVariantLight = Color(0xffc4c6cf);
  static const shadowLight = Color(0xff000000);
  static const scrimLight = Color(0xff000000);
  static const inverseSurfaceLight = Color(0xff2f3033);
  static const onInverseSurfaceLight = Color(0xfff1f0f4);
  static const inversePrimaryLight = Color(0xffa9c7ff);
  static const surfaceTintLight = Color(0xff005db7);

  // Dark Mode
  static const brightnessDark = Brightness.dark;
  static const primaryDark = Color(0xffa9c7ff);
  static const onPrimaryDark = Color(0xff003063);
  static const primaryContainerDark = Color(0xff00468c);
  static const onPrimaryContainerDark = Color(0xffd6e3ff);
  static const secondaryDark = Color(0xffbdc7dc);
  static const onSecondaryDark = Color(0xff283141);
  static const secondaryContainerDark = Color(0xff3e4758);
  static const onSecondaryContainerDark = Color(0xffdae2f9);
  static const tertiaryDark = Color(0xffdcbce1);
  static const onTertiaryDark = Color(0xff3f2845);
  static const tertiaryContainerDark = Color(0xff563e5c);
  static const onTertiaryContainerDark = Color(0xfff9d8fd);
  static const errorDark = Color(0xffffb4ab);
  static const onErrorDark = Color(0xff690005);
  static const errorContainerDark = Color(0xff93000a);
  static const onErrorContainerDark = Color(0xffffb4ab);
  static const backgroundDark = Color(0xff1a1b1e);
  static const onBackgroundDark = Color(0xffe3e2e6);
  static const surfaceDark = Color(0xff1a1b1e);
  static const onSurfaceDark = Color(0xffe3e2e6);
  static const surfaceVariantDark = Color(0xff44474e);
  static const onSurfaceVariantDark = Color(0xffc4c6cf);
  static const outlineDark = Color(0xff8e9099);
  static const outlineVariantDark = Color(0xff44474e);
  static const shadowDark = Color(0xff000000);
  static const scrimDark = Color(0xff000000);
  static const inverseSurfaceDark = Color(0xffe3e2e6);
  static const onInverseSurfaceDark = Color(0xff2f3033);
  static const inversePrimaryDark = Color(0xff005db7);
  static const surfaceTintDark = Color(0xffa9c7ff);

  // Common
  static const transparent = Colors.transparent;
}

abstract class _LightColors {
  static const background = Colors.white;
  static const card = AppColors.primaryLight;
}

abstract class _DarkColors {
  static const background = Color(0xFF1A1B1E);
  static const card = AppColors.primaryDark;
}

/// Reference to the application theme.
class AppTheme {
  static final visualDensity = VisualDensity.adaptivePlatformDensity;

  final darkBase = ThemeData.dark();
  final lightBase = ThemeData.light();

  /// Light theme
  ThemeData get light => ThemeData(
        brightness: Brightness.light,
        colorScheme: lightBase.colorScheme.copyWith(secondary: AppColors.surfaceTintLight),
        visualDensity: visualDensity,
        canvasColor: _LightColors.background,
        appBarTheme: lightBase.appBarTheme.copyWith(
          iconTheme: lightBase.iconTheme,
          backgroundColor: _LightColors.background,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
            color: AppColors.primaryLight,
          ),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        scaffoldBackgroundColor: _LightColors.background,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: AppColors.primaryDark,
          ),
        ),
        cardColor: _LightColors.card,
        textTheme: lightBase.textTheme.apply(bodyColor: AppColors.primaryLight),
        primaryTextTheme: const TextTheme(
          titleLarge: TextStyle(color: AppColors.onPrimaryLight),
          bodyLarge: TextStyle(color: AppColors.onPrimaryLight),
        ),
        iconTheme: const IconThemeData(color: AppColors.outlineDark),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primaryDark, // Corrected property for text color
          ),
        ),
      );

  /// Dark theme
  ThemeData get dark => ThemeData(
        brightness: Brightness.dark,
        colorScheme: darkBase.colorScheme.copyWith(secondary: AppColors.surfaceTintDark),
        visualDensity: visualDensity,
        canvasColor: _DarkColors.background,
        appBarTheme: darkBase.appBarTheme.copyWith(
          iconTheme: darkBase.iconTheme,
          backgroundColor: _DarkColors.background,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 17,
            color: AppColors.primaryDark,
          ),
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        scaffoldBackgroundColor: _DarkColors.background,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: AppColors.primaryDark,
          ),
        ),
        cardColor: _DarkColors.card,
        textTheme: lightBase.textTheme.apply(bodyColor: AppColors.primaryDark),
        primaryTextTheme: const TextTheme(
          titleLarge: TextStyle(color: AppColors.onPrimaryDark),
          bodyLarge: TextStyle(color: AppColors.onPrimaryDark),
        ),
        iconTheme: const IconThemeData(color: AppColors.outlineLight),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primaryDark, // Corrected property for text color
          ),
        ),
      );
}
