import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scanner/core/constants/colors.dart';
import 'package:scanner/core/widgets/Loader/dashboard_loader_screen.dart';
import 'package:scanner/features/bills/bloc/bills_bloc.dart';
import 'package:scanner/features/bills/bloc/bills_event.dart';
import 'package:scanner/features/bills/bloc/bills_state.dart';
import 'package:scanner/features/bills/models/bill_model.dart';
import 'package:scanner/features/bills/widgets/ReceiptListview.dart';
import 'package:scanner/features/floating/screen/expandable_fab_bloc_screen.dart';
import 'package:scanner/features/uploads/screens/PreviewScreen.dart';
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

  navigateToPreviewScreen({required BuildContext getContext,required XFile image}){
    Navigator.push(getContext, MaterialPageRoute(builder: (_) => PreviewScreen(imagePath: image.path),),).then((val){
      print("$val");
      if(val is Bill){

      }
      else if(val == "retake"){
        pickImageAndUpload(context: getContext);
      }
      else{

      }
    });
  }

  Future<bool> checkAndRequestGalleryPermission() async {
    Permission permission;
    if (Platform.isAndroid) {
      // Use Android version-specific permission
      final sdkInt = await _getAndroidSdkInt();
      if (sdkInt >= 33) {
        permission = Permission.photos; // Android 13+
      } else {
        permission = Permission.storage; // Android 12 and below
      }
    } else {
      // iOS
      permission = Permission.photos;
    }
    final status = await permission.status;
    if (status.isGranted) return true;
    final result = await permission.request();
    return result.isGranted;
  }

  Future<int> _getAndroidSdkInt() async {
    final deviceInfo = await DeviceInfoPlugin().androidInfo;
    return deviceInfo.version.sdkInt;
  }

  pickImageAndUpload({required BuildContext context}) async {
    final status = await checkAndRequestGalleryPermission();
    if(status){
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        navigateToPreviewScreen(getContext: context, image: image);
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("No image selected")),);
      }
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Photo permission denied')),);
    }
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
          pickImageAndUpload(context: context);
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