import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

part 'src/colors.dart';

ThemeData get darkTheme => ThemeData(
      useMaterial3: true,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
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
      // colorScheme: ColorScheme.fromSeed(
      //   seedColor: _AppColors.primary,
      // ),
      listTileTheme: ThemeData.dark().listTileTheme.copyWith(
            textColor: _AppColors.primaryText,
          ),
      scaffoldBackgroundColor: _AppColors.background,
      brightness: Brightness.light,
      textTheme: GoogleFonts.loraTextTheme(),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: _AppColors.accent,
      ),
      primaryColor: _AppColors.primary,
      primaryColorDark: _AppColors.primaryDark,
      primaryColorLight: _AppColors.primaryLight,
      dividerColor: _AppColors.divider,
      canvasColor: _AppColors.accent,
      dividerTheme: const DividerThemeData(
        color: _AppColors.divider,
        thickness: 1.2,
      ),
      cardTheme: const CardTheme(
        color: _AppColors.primaryLight,
      ),
      primaryTextTheme: GoogleFonts.loraTextTheme(ThemeData.light().textTheme),
    );
