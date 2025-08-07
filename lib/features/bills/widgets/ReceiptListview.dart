import 'dart:io';
import 'package:flutter/material.dart';
import 'package:scanner/core/constants/colors.dart';
import 'package:scanner/core/constants/constant.dart';
import 'package:scanner/core/constants/sizes.dart';
import 'package:scanner/core/utils/date_format_change.dart';
import 'package:scanner/core/widgets/secure_image.dart';
import 'package:scanner/features/bills/models/bill_model.dart';
import 'package:scanner/features/bills/screens/ReceiptDetailScreen.dart';
import 'package:scanner/core/utils/convert_base64.dart';

class ReceiptListview extends StatelessWidget{
  const ReceiptListview({super.key,required this.getReceiptItem});
  final Bill getReceiptItem;

  navigateToReceiptDetailScreen({required BuildContext context}){
    Navigator.push(context, MaterialPageRoute(builder: (_) => ReceiptDetailScreen(billId: getReceiptItem.id!,)),).then((val){
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: AppSizes.horizontalPadding,right: AppSizes.horizontalPadding,top: AppSizes.verticalPadding),
      padding: EdgeInsets.symmetric(horizontal: AppSizes.horizontalPadding, vertical: AppSizes.verticalPadding),
      decoration: BoxDecoration(
        color: AppColors.cardBackgroundColor,
        borderRadius: BorderRadius.circular(AppSizes.radius),
        boxShadow: [BoxShadow(blurStyle: BlurStyle.outer, color: AppColors.boxShadowColor, blurRadius: AppSizes.shadowBlurRadius,),],
      ),
      child: InkWell(
        onTap: (){
          navigateToReceiptDetailScreen(context: context);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(getReceiptItem.merchant,style: TextStyle(fontWeight: FontWeight.bold,),softWrap: true,),
            SizedBox(height: (AppSizes.verticalPadding/2),),
            Text(getReceiptItem.category,style: TextStyle(fontWeight: FontWeight.w500),softWrap: true,),
            SizedBox(height: (AppSizes.verticalPadding/2),),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(DateFormatChange().formatReadableDate(inputDate: getReceiptItem.date),style: TextStyle(fontWeight: FontWeight.w500),softWrap: true,),
                Text("$currency ${getReceiptItem.total}",style: TextStyle(fontWeight: FontWeight.w600),softWrap: true,),
              ],
            ),
          ],
        ),
      ),
    );
  }

}