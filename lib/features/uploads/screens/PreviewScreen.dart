import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanner/core/constants/colors.dart';
import 'package:scanner/core/constants/constant.dart';
import 'package:scanner/core/constants/json_constant.dart';
import 'package:scanner/core/constants/sizes.dart';
import 'package:scanner/core/utils/compress_image.dart';
import 'package:scanner/core/widgets/circular_progress_indicator_widget.dart';
import 'package:scanner/core/widgets/message_box.dart';
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
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(title: Text(previewAppBarText)),
      body: BlocListener<BillDetailBloc, BillDetailState>(
        listener: (context, state) {
          if (state is ImageUploadSuccess) {
            final res = state.response;
            final receipt = res[receiptJsonText] ?? {};
            final imageUrl = res[urlJsonText] ?? '';
            Bill getReceiptItem = Bill(merchant: receipt[merchantJsonText] ?? '', total: (receipt[totalJsonText] ?? 0).toDouble(), date: receipt[dateJsonText]??"", category: receipt[categoryJsonText] ?? '', items: List<String>.from(receipt[itemsJsonText] ?? []), imageUrl: imageUrl,);
            navigateToEditReceiptScreen(getContext: context, getReceiptItem: getReceiptItem,);
          }
          if (state is BillDetailError) {
            MessageBox(context: context, getMessage: state.message);
          }
        },
        child: Container(width: double.infinity,height: double.infinity,child:Image.file(File(imagePath), fit: BoxFit.fill,),)
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.cardBackgroundColor,
          boxShadow: [BoxShadow(blurStyle: BlurStyle.outer, color: AppColors.boxShadowColor, blurRadius: AppSizes.shadowBlurRadius,),],
        ),
        padding: EdgeInsets.symmetric(horizontal: AppSizes.horizontalPadding, vertical: AppSizes.verticalPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: OutlinedButton(onPressed: () {Navigator.pop(context, retake);}, child: Text(retakeText),),),
            SizedBox(width: AppSizes.horizontalPadding),
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
                    child: isLoading ? CircularProgressIndicatorWidget() : const Text(continueText),
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
