import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanner/Bloc/receipt_bloc.dart';
import 'package:scanner/Bloc/receipt_event.dart';
import 'package:scanner/Models/Receipt.dart';
import 'package:scanner/Utils/convertBase64XFile.dart';

class ReceiptDetailScreen extends StatelessWidget{
  const ReceiptDetailScreen({super.key,required this.getReceiptItem});
  final Receipt getReceiptItem;

  callDeleteButton({required BuildContext context}){
    context.read<ReceiptBloc>().add(DeleteReceipt(getReceiptItem.id!));
    Navigator.pop(context,"delete");
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text('Receipt Detail')),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FutureBuilder<File>(
              future: convertBase64ToFile(imageBase64: getReceiptItem.imageBase64,getId: getReceiptItem.id!,),
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return CircularProgressIndicator();
                }
                if (snapshot.hasError) {
                  return SizedBox(width: screenWidth,height: screenWidth,child:Icon(Icons.dangerous_outlined,color: Colors.red,),);
                }
                return SizedBox(width: screenWidth,child:ClipRRect(borderRadius: BorderRadius.circular(0),child: Image.file(File(snapshot.data!.path,),fit: BoxFit.fitWidth,),),);
              },
            ),
            SizedBox(height: 20,),
            Container(
              width: screenWidth,
              padding: EdgeInsets.symmetric(horizontal: screenWidth/20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Merchant",style: TextStyle(fontWeight: FontWeight.w500,),softWrap: true,),
                      SizedBox(width: 20,),
                      Flexible(child: Text(getReceiptItem.merchant,style: TextStyle(fontWeight: FontWeight.bold,),softWrap: true,),),

                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Price",style: TextStyle(fontWeight: FontWeight.w500,),softWrap: true,),
                      SizedBox(width: 20,),
                      Flexible(child: Text(getReceiptItem.total.toString(),style: TextStyle(fontWeight: FontWeight.bold,),softWrap: true,),),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Category",style: TextStyle(fontWeight: FontWeight.w500,),softWrap: true,),
                      SizedBox(width: 20,),
                      Flexible(child: Text(getReceiptItem.category,style: TextStyle(fontWeight: FontWeight.bold,),softWrap: true,),),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Date",style: TextStyle(fontWeight: FontWeight.w500,),softWrap: true,),
                      SizedBox(width: 20,),
                      Flexible(child: Text(getReceiptItem.date,style: TextStyle(fontWeight: FontWeight.bold,),softWrap: true,),),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text("Items",style: TextStyle(fontWeight: FontWeight.w500,),softWrap: true,),
                      SizedBox(width: 20,),
                      Flexible(child: Text(getReceiptItem.items.toString(),style: TextStyle(fontWeight: FontWeight.bold,),softWrap: true,),),
                    ],
                  ),
                  SizedBox(height: 20,),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              blurStyle: BlurStyle.outer,
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 7,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
            ),
            SizedBox(width: 30),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  callDeleteButton(context: context);
                },
                child: Text('Delete Receipt'),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
