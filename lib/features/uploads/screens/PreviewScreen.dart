import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanner/core/constants/colors.dart';
import 'package:scanner/core/utils/compress_image.dart';
import 'package:scanner/core/utils/date_format_change.dart';
import 'package:scanner/core/widgets/circular_progress_indicator_widget.dart';
import 'package:scanner/features/bills/bloc/bill_detail_bloc.dart';
import 'package:scanner/features/bills/bloc/bill_detail_event.dart';
import 'package:scanner/features/bills/bloc/bill_detail_state.dart';
import 'package:scanner/features/bills/models/bill_model.dart';
import 'package:scanner/features/bills/screens/EditReceiptScreen.dart';

class PreviewScreen extends StatelessWidget {
  final String imagePath;
  const PreviewScreen({super.key, required this.imagePath});

  navigateToEditReceiptScreen({required BuildContext getContext, required Bill getReceiptItem,}) {
    Navigator.push(getContext, MaterialPageRoute(builder: (_) => EditReceiptScreen(getReceiptItem: getReceiptItem,isUpdate: false,),),).then((val) {
      Navigator.pop(getContext, val);
    });
  }

  callUploadImageAPI({required BuildContext getContext, required String base64data,}) {
    getContext.read<BillDetailBloc>().add(UploadImageEvent(base64data));
  }

  Future<void> onContinuePressed({required BuildContext getContext}) async {
    File imageFile = File(imagePath);
    File? getCompressImage = await compressImage(originalFile: imageFile);
    if(getCompressImage!=null){
      final bytes = getCompressImage.readAsBytesSync();
      final base64 = base64Encode(bytes);
      callUploadImageAPI(getContext: getContext, base64data: base64);
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(title: Text('Preview')),
      body: BlocListener<BillDetailBloc, BillDetailState>(
        listener: (context, state) {
          if (state is ImageUploadSuccess) {
            final res = state.response;
            print("Response success : $res");
            final receipt = res['receipt'] ?? {};
            final imageUrl = res['url'] ?? '';
            Bill getReceiptItem = Bill(merchant: receipt['merchant'] ?? '', total: (receipt['total'] ?? 0).toDouble(), date: receipt['date']??"", category: receipt['category'] ?? '', items: List<String>.from(receipt['items'] ?? []), imageUrl: imageUrl,);
            navigateToEditReceiptScreen(getContext: context, getReceiptItem: getReceiptItem,);
          }
          if (state is BillDetailError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)),);
          }
        },
        child: Container(width: screenWidth,height: screenHeight,child: Image.file(File(imagePath), fit: BoxFit.fill,),),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [BoxShadow(blurStyle: BlurStyle.outer, color: Colors.grey.withOpacity(0.3), blurRadius: 7,),],
        ),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: OutlinedButton(onPressed: () {Navigator.pop(context, "retake");}, child: Text('Retake'),),),
            SizedBox(width: 30),
            Expanded(
              child: BlocBuilder<BillDetailBloc, BillDetailState>(
                builder: (context, state) {
                  final isLoading = state is BillDetailLoading;
                  return ElevatedButton(
                    onPressed: () {
                      if(!isLoading){
                        onContinuePressed(getContext: context);
                      }
                    },
                    child: isLoading ? CircularProgressIndicatorWidget() : const Text('Continue'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
