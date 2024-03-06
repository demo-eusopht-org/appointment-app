import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

part './src/colors.dart';

ThemeData get lightTheme => ThemeData(
      useMaterial3: true,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: _AppColors.primary,
        ),
        backgroundColor: _AppColors.primary,
        titleTextStyle: GoogleFonts.lora(
          color: _AppColors.secondaryText,
          fontSize: 22,
        ),
      ),
      iconTheme: const IconThemeData(
        color: _AppColors.accent,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        extendedTextStyle: GoogleFonts.lora(
          color: _AppColors.iconText,
        ),
      ),
      textSelectionTheme: const TextSelectionThemeData(
        cursorColor: _AppColors.primary,
      ),
      scaffoldBackgroundColor: _AppColors.background,
      brightness: Brightness.light,
      textTheme: GoogleFonts.loraTextTheme(),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: _AppColors.accent,
      ),
      listTileTheme: ThemeData.light().listTileTheme.copyWith(
            textColor: _AppColors.primaryText,
          ),
      primaryColor: _AppColors.primary,
      primaryColorDark: _AppColors.primaryDark,
      primaryColorLight: _AppColors.primaryLight,
      dividerColor: _AppColors.divider,
      canvasColor: _AppColors.accent,
      cardTheme: const CardTheme(
        color: _AppColors.primaryLight,
      ),
      dividerTheme: const DividerThemeData(
        color: _AppColors.divider,
        thickness: 1.2,
      ),
      primaryTextTheme: GoogleFonts.loraTextTheme(),
    );
