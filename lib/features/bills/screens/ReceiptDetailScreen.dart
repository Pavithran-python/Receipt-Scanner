import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanner/core/constants/colors.dart';
import 'package:scanner/core/utils/convert_base64.dart';
import 'package:scanner/core/widgets/circular_progress_indicator_widget.dart';
import 'package:scanner/core/widgets/secure_image.dart';
import 'package:scanner/features/bills/bloc/bills_bloc.dart';
import 'package:scanner/features/bills/bloc/bills_event.dart';
import 'package:scanner/features/bills/bloc/bills_state.dart';
import 'package:scanner/features/bills/models/bill_model.dart';

class ReceiptDetailScreen extends StatelessWidget{
  const ReceiptDetailScreen({super.key,required this.getReceiptItem});
  final Bill getReceiptItem;

  callDeleteButton({required BuildContext context}){
    context.read<BillBloc>().add(DeleteBill(getReceiptItem.id!));

  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(title: Text('Receipt Detail')),
      body: BlocListener<BillBloc, BillState>(
        listener: (context,state){
          if(state is DeleteBillSuccess){
            Navigator.pop(context,"delete");
            final res = state.deleteResponse;
            String getMessage = res["message"]??"Receipt Deleted Successfully";
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getMessage)),);
          }
          if (state is BillError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)),);
          }
        },
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SecureImage(url: getReceiptItem.imageUrl, radius: 0, height: null, width: screenWidth, getBoxFit: BoxFit.fitHeight),
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
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical:10,horizontal: 16),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(blurStyle: BlurStyle.outer, color: Colors.grey.withOpacity(0.3), blurRadius: 7,),],),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: OutlinedButton(onPressed: (){Navigator.pop(context);}, child: Text('Cancel'),),),
            SizedBox(width: 30),
            Expanded(
              child: BlocBuilder<BillBloc, BillState>(
                builder: (context, state) {
                  final isLoading = state is BillLoading;
                  return ElevatedButton(
                    onPressed:  () {
                      if(!isLoading){
                        callDeleteButton(context: context);
                      }
                    },
                    child: isLoading ? CircularProgressIndicatorWidget() : const Text('Delete'),
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
