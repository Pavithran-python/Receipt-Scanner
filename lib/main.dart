import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanner/core/services/bill_api_service.dart';
import 'package:scanner/features/bills/screens/EditReceiptScreen.dart';
import 'core/repositories/bill_repository.dart';
import 'core/themes/app_theme.dart';
import 'features/bills/bloc/bills_bloc.dart';
import 'features/bills/bloc/bills_event.dart';
import 'features/bills/models/bill_model.dart';
import 'features/bills/screens/DashboardScreen.dart';

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
    return BlocProvider(
      create: (_) => BillBloc(BillRepository(BillApiService()))..add(LoadBills()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.appTheme,
        //home: EditReceiptScreen(getReceiptItem: Bill(merchant: '', total: 0, date: '', category: '', items: [], imageUrl: ''))
        home: DashboardScreen(),
      ),
    );
  }
}

