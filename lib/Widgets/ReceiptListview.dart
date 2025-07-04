import 'dart:io';
import 'package:flutter/material.dart';
import 'package:scanner/Models/Receipt.dart';
import 'package:scanner/Screens/ReceiptDetailScreen.dart';
import 'package:scanner/Utils/convertBase64XFile.dart';

class ReceiptListview extends StatelessWidget{
  const ReceiptListview({super.key,required this.getReceiptItem});
  final Receipt getReceiptItem;

  navigateToReceiptDetailScreen({required BuildContext context}){
    Navigator.push(context, MaterialPageRoute(builder: (_) => ReceiptDetailScreen(getReceiptItem: getReceiptItem,)),).then((val){
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      width: screenWidth,
      margin: EdgeInsets.symmetric(horizontal: screenWidth/25,vertical: screenHeight/75),
      padding: EdgeInsets.symmetric(horizontal: screenWidth/30,vertical: screenHeight/60),
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: FutureBuilder<File>(
                future: convertBase64ToFile(imageBase64: getReceiptItem.imageBase64,getId: getReceiptItem.id!),
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return SizedBox(width: screenWidth/3.5,height: screenWidth/3.5,child:Icon(Icons.dangerous_outlined,color: Colors.red,),);
                  }
                  return SizedBox(width: screenWidth/3.5,height: screenWidth/3.5,child:ClipRRect(borderRadius: BorderRadius.circular(10),child: Image.file(File(snapshot.data!.path,),fit: BoxFit.fitWidth,),),);
                },
              ),
            ),
            SizedBox(width: screenWidth/25,),
            Expanded(child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Merchant : ${getReceiptItem.merchant}",style: TextStyle(fontWeight: FontWeight.bold,),softWrap: true,),
                Text("Price : ${getReceiptItem.total}",style: TextStyle(fontWeight: FontWeight.w600),softWrap: true,),
                Text("Category : ${getReceiptItem.category}",style: TextStyle(fontWeight: FontWeight.w500),softWrap: true,),
                Text("Date : ${getReceiptItem.date}",style: TextStyle(fontWeight: FontWeight.w500),softWrap: true,),
                Text("Items : ${getReceiptItem.items}",style: TextStyle(fontWeight: FontWeight.w500),softWrap: true,),
              ],
            ),),
          ],
        ),
      ),
    );
  }

}