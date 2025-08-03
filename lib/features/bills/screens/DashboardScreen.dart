import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanner/core/constants/colors.dart';
import 'package:scanner/core/widgets/Loader/dashboard_loader_screen.dart';
import 'package:scanner/features/bills/bloc/bills_bloc.dart';
import 'package:scanner/features/bills/bloc/bills_event.dart';
import 'package:scanner/features/bills/bloc/bills_state.dart';
import 'package:scanner/features/bills/models/bill_model.dart';
import 'package:scanner/features/bills/widgets/ReceiptListview.dart';
import 'package:scanner/features/floating/screen/expandable_fab_bloc_screen.dart';
import '../../uploads/screens/CameraScreen.dart';

class DashboardScreen extends StatelessWidget {
  Future<void>? precacheFuture;

  navigateToCameraScreen({required BuildContext context}){
    Navigator.push(context, MaterialPageRoute(builder: (_) => CameraScreen()),).then((val){
      if(val is Bill){
        Bill getNewBill = val;
        print("New Bill ${getNewBill.toJson()}");
        //context.read<BillBloc>().add(AddBillToListEvent(getNewBill));
      }
    });
  }

  precacheImages(BuildContext context, List<Bill> bills) async {
    for (var bill in bills) {
      final image = Image.network(bill.imageUrl);
      await precacheImage(image.image, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(title: Text('Receipts')),
      body: BlocBuilder<BillBloc, BillState>(
        builder: (context, state) {
          if (state is BillLoading) {
            return DashboardLoaderScreen();
          } else if (state is BillLoaded) {
            final bills = state.bills;
            precacheFuture ??= precacheImages(context, bills);
            return FutureBuilder(
              future: precacheFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return DashboardLoaderScreen();
                }
                if (bills.isEmpty) {
                  return Center(child: Text('No Receipt Found'));
                }
                return ListView.builder(
                  itemCount: state.bills.length,
                  itemBuilder: (context, index) {
                    final receipt = state.bills[index];
                    return ReceiptListview(getReceiptItem: receipt);},
                );
              }
            );
          }
          return Center(child: Text('Something went wrong'));
        },
      ),
      floatingActionButton: ExpandableFabBlocScreen(getSelectedOption: (int getSelectedOption){
        print("Selected option : ${getSelectedOption}");
        if(getSelectedOption==0){

        }
        else{
          navigateToCameraScreen(context: context);
        }
      },),
      /*floatingActionButton: FloatingActionButton(
        child: Icon(Icons.camera_alt),
        onPressed: () {
          navigateToCameraScreen(context: context);
        },
      ),*/
    );
  }
}