import 'dart:io';
import 'package:flutter/material.dart';
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth,
      margin: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
      padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            blurStyle: BlurStyle.outer,
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 7,
          ),
        ],
      ),
      child: InkWell(
        onTap: (){
          navigateToReceiptDetailScreen(context: context);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //SecureImage(url: getReceiptItem.imageUrl, radius: 10, height: screenWidth/3.5, width: screenWidth/3.5, getBoxFit: BoxFit.cover),
            //SizedBox(width: screenWidth/25,),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(getReceiptItem.merchant,style: TextStyle(fontWeight: FontWeight.bold,),softWrap: true,),
                  SizedBox(height: 4,),
                  Text(getReceiptItem.category,style: TextStyle(fontWeight: FontWeight.w500),softWrap: true,),
                  SizedBox(height: 4,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(DateFormatChange().formatReadableDate(inputDate: getReceiptItem.date),style: TextStyle(fontWeight: FontWeight.w500),softWrap: true,),
                      Text("₹ ${getReceiptItem.total}",style: TextStyle(fontWeight: FontWeight.w600),softWrap: true,),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}