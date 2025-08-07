import 'package:flutter/material.dart';
import 'package:scanner/core/constants/colors.dart';
import 'package:scanner/core/constants/sizes.dart';

class AppTheme {

  //Theme Data
  static ThemeData appTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.background,
      elevation: AppSizes.appBarElevation,
      titleTextStyle: TextStyle(color: AppColors.appBarTextColor,fontSize: AppSizes.appBarTextSize,fontWeight: FontWeight.bold),
    ),
    textTheme: TextTheme(
      bodyLarge: TextStyle(color: AppColors.text,fontSize: AppSizes.bodyLargeTextSize,fontWeight: FontWeight.w600),
      bodyMedium: TextStyle(color: AppColors.text,fontSize: AppSizes.bodyMediumTextSize,),
      bodySmall: TextStyle(color: AppColors.text,fontSize: AppSizes.bodySmallTextSize,),
    ),
    primarySwatch: AppColors.primary, // or your custom swatch
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: AppColors.background, // Text color
        backgroundColor: AppColors.primary,
        fixedSize: Size.fromHeight(AppSizes.buttonHeight),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radius),
        ),
        textStyle: TextStyle(fontSize: AppSizes.buttonTextSize, fontWeight: FontWeight.bold,color: AppColors.buttonTextColor),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,
        side: BorderSide(color: AppColors.primary,width: AppSizes.buttonBorderWidth),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.radius),
        ),
        fixedSize: Size.fromHeight(AppSizes.buttonHeight),
        textStyle: TextStyle(fontSize: AppSizes.buttonTextSize,fontWeight: FontWeight.bold,),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.buttonTextColor,
      focusElevation: AppSizes.appBarElevation,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.floatingButtonSize),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: AppColors.textFieldHintTextColor,),
      helperStyle: TextStyle(color: AppColors.textFieldHintTextColor),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.borderFocusColor, width: AppSizes.textFieldBorderWidth),
        borderRadius: BorderRadius.circular(AppSizes.textFieldBorderRadius),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(AppSizes.textFieldBorderRadius),
      ),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(AppSizes.textFieldBorderRadius),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: AppSizes.textFieldHorizontalPadding, vertical: AppSizes.textFieldVerticalPadding),
    ),
  );
}