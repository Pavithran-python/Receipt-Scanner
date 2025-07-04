import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Bloc/receipt_bloc.dart';
import 'Bloc/receipt_event.dart';
import 'Repository/ReceiptRepository.dart';
import 'Screens/DashboardScreen.dart';

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
      create: (_) => ReceiptBloc(ReceiptRepository())..add(LoadReceipts()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: DashboardScreen(),
      ),
    );
  }
}

