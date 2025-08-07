import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scanner/core/constants/colors.dart';
import 'package:scanner/core/constants/constant.dart';
import 'package:scanner/core/utils/check_condition.dart';
import 'package:scanner/core/widgets/Loader/dashboard_loader_screen.dart';
import 'package:scanner/features/bill_list/bloc/bill_list_bloc.dart';
import 'package:scanner/features/bill_list/bloc/bill_list_state.dart';
import 'package:scanner/features/bills/widgets/ReceiptListview.dart';
import 'package:scanner/features/floating/screen/expandable_fab_bloc_screen.dart';
import 'package:scanner/features/uploads/screens/CameraScreen.dart';
import 'package:scanner/features/uploads/screens/PreviewScreen.dart';


class DashboardScreen extends StatelessWidget {

  navigateToCameraScreen({required BuildContext context}){
    Navigator.push(context, MaterialPageRoute(builder: (_) => CameraScreen()),).then((val){
    });
  }

  navigateToPreviewScreen({required BuildContext getContext,required XFile image}){
    Navigator.push(getContext, MaterialPageRoute(builder: (_) => PreviewScreen(imagePath: image.path),),).then((val){
      print("$val");
      if(val != null && val == retake){
        pickImageAndUpload(context: getContext);
      }
    });
  }

  pickImageAndUpload({required BuildContext context}) async {
    final status = await checkCondition().checkAndRequestGalleryPermission();
    if(status){
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        navigateToPreviewScreen(getContext: context, image: image);
      }
      else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(noImageSelected)),);
      }
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(photoDenied)),);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(title: Text(dashboardTitle)),
      body: BlocBuilder<BillListBloc, BillListState>(
        builder: (context, state) {
          if (state is BillListLoading) {
            return DashboardLoaderScreen();
          } else if (state is BillListLoaded) {
            final bills = state.bills;
            if (bills.isEmpty) {
              return Center(child: Text(noReceiptFound));
            }
            return ListView.builder(
              itemCount: state.bills.length,
              itemBuilder: (context, index) {
                final receipt = state.bills[index];
                return ReceiptListview(getReceiptItem: receipt);},
            );
          }
          return Center(child: Text(somethingWentWrong));
        },
      ),
      floatingActionButton: ExpandableFabBlocScreen(
        getSelectedOption: (int getSelectedOption){
          if(getSelectedOption==0){
            pickImageAndUpload(context: context);
          }
          else{
            navigateToCameraScreen(context: context);
          }
        },
      ),
    );
  }
}