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
            theme: AppTheme().buildAppTheme(),
            home: DashboardScreen(),
          );
        },
      ),
    );
  }

}

