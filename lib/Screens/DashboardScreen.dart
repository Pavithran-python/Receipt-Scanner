import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanner/Bloc/receipt_bloc.dart';
import 'package:scanner/Bloc/receipt_state.dart';
import 'package:scanner/Widgets/ReceiptListview.dart';
import 'CameraScreen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  navigateToCameraScreen({required BuildContext context}){
    Navigator.push(context, MaterialPageRoute(builder: (_) => CameraScreen()),).then((val){
      if(val!=null && val == "save"){

      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: Text('Receipts')),
      body: BlocBuilder<ReceiptBloc, ReceiptState>(
        builder: (context, state) {
          if (state is ReceiptLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ReceiptLoaded) {
            return state.receipts.isEmpty?Center(child: Text('No Receipt Found')):ListView.builder(
              itemCount: state.receipts.length,
              itemBuilder: (context, index) {
                final receipt = state.receipts[index];
                return ReceiptListview(getReceiptItem: receipt);
              },
            );
          }
          return Center(child: Text('Something went wrong'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () {
          navigateToCameraScreen(context: context);
        },
      ),
    );
  }
}