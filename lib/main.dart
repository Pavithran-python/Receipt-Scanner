import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:scanner/core/constants/colors.dart';
import 'package:scanner/core/services/bill_api_service.dart';
import 'package:scanner/features/bill_list/bloc/bill_list_bloc.dart';
import 'package:scanner/features/bill_list/bloc/bill_list_event.dart';
import 'core/constants/sizes.dart';
import 'core/repositories/bill_repository.dart';
import 'core/themes/app_theme.dart';
import 'features/bill_list/screens/DashboardScreen.dart';
import 'features/bills/bloc/bill_detail_bloc.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final billRepository = BillRepository(BillApiService());
    return MultiBlocProvider(
      providers: [
        BlocProvider<BillListBloc>(create: (context) => BillListBloc(billRepository)..add(LoadBills()),),
        BlocProvider<BillDetailBloc>(create: (context) => BillDetailBloc(billRepository),),
      ],
      child: ScreenUtilInit(
        designSize: Size(412, 915), // base size used in UI design (width, height)
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: buildAppTheme(),
            home: DashboardScreen(),
          );
        },
      ),
    );
  }

  ThemeData buildAppTheme(){
    return ThemeData(
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.background,
        elevation: AppSizes.appBarElevation,
        titleTextStyle: TextStyle(color: AppColors.appBarTextColor,fontSize: AppSizes.appBarTextSize,fontWeight: FontWeight.bold),
      ),
      textTheme: TextTheme(
        displayLarge: TextStyle(color: AppColors.error,fontSize:  AppSizes.displayLargeTextSize,fontWeight: FontWeight.bold),
        displaySmall: TextStyle(color: AppColors.buttonTextColor,fontSize: AppSizes.displaySmallTextSize,fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(color: AppColors.text,fontSize: AppSizes.bodyLargeTextSize,fontWeight: FontWeight.w600),
        bodyMedium: TextStyle(color: AppColors.text,fontSize: AppSizes.bodyMediumTextSize,fontWeight: FontWeight.w400),
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
        sizeConstraints: BoxConstraints.tightFor(width: AppSizes.floatingButtonSize, height: AppSizes.floatingButtonSize),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.buttonTextColor,
        focusElevation: AppSizes.appBarElevation,
        iconSize: AppSizes.floatingActionButtonIconSize,
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
}

