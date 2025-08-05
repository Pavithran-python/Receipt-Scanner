import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanner/core/constants/colors.dart';
import 'package:scanner/core/utils/date_format_change.dart';
import 'package:scanner/core/widgets/Loader/receipt_detail_loader_screen.dart';
import 'package:scanner/core/widgets/circular_progress_indicator_widget.dart';
import 'package:scanner/core/widgets/secure_image.dart';
import 'package:scanner/features/bill_list/bloc/bill_list_bloc.dart';
import 'package:scanner/features/bill_list/bloc/bill_list_event.dart';
import 'package:scanner/features/bills/bloc/bill_detail_bloc.dart';
import 'package:scanner/features/bills/bloc/bill_detail_event.dart';
import 'package:scanner/features/bills/bloc/bill_detail_state.dart';
import 'package:scanner/features/bills/models/bill_model.dart';
import 'EditReceiptScreen.dart';

class ReceiptDetailScreen extends StatefulWidget {
  final String billId;
  const ReceiptDetailScreen({super.key, required this.billId});

  @override
  State<ReceiptDetailScreen> createState() => _ReceiptDetailScreenState();
}

class _ReceiptDetailScreenState extends State<ReceiptDetailScreen> {
  Bill? _cachedBill;

  navigateToEditReceiptScreen({required BuildContext getContext, required Bill getReceiptItem,}) {
    Navigator.push(getContext, MaterialPageRoute(builder: (_) => EditReceiptScreen(getReceiptItem: getReceiptItem,isUpdate: true,),),).then((val) {
      print("val : ${val}");
      if(val!=null && val){
        getBillApi();
      }
    });
  }

  getBillApi(){
    context.read<BillDetailBloc>().add(GetBill(widget.billId));
  }

  callDeleteButton(String id) {
    context.read<BillDetailBloc>().add(DeleteBill(id));
  }

  @override
  void initState() {
    super.initState();
    getBillApi();
  }


  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(title: Text('Receipt Detail')),
      body: BlocConsumer<BillDetailBloc, BillDetailState>(
        listener: (context, state) {
          if (state is DeleteBillSuccess) {
            context.read<BillListBloc>().add(DeleteBillToListEvent(widget.billId));
            final res = state.deleteResponse;
            String getMessage = res["message"] ?? "Receipt Deleted Successfully";
            Navigator.pop(context, "delete");
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getMessage)),);
          } else if (state is BillDetailError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)),);
          }
        },
        builder: (context, state) {
          if (state is BillGetDetailLoading) {
            return ReceiptDetailLoaderScreen();
          }
          if(state is BillOperationSuccess){
            _cachedBill = state.bill;
          }
          if(_cachedBill!=null){
            final bill = _cachedBill;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: screenWidth,
                    color: Colors.black,
                    child: SecureImage(url: bill!.imageUrl, radius: 0, height: screenWidth, width: screenWidth, getBoxFit: BoxFit.fitHeight,),
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            Text("Product Details", style:TextStyle(fontWeight:FontWeight.bold),),
                            SizedBox(height: 10),
                            _buildInfoRow("Merchant", bill.merchant),
                            SizedBox(height: 10),
                            _buildInfoRow("Category", bill.category),
                            SizedBox(height: 10),
                            _buildInfoRow("Date", DateFormatChange().formatReadableDate(inputDate: bill.date)),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                      Container(
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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text("Price Detail",style: TextStyle(fontWeight:FontWeight.bold),),
                                InkWell(onTap: (){
                                  navigateToEditReceiptScreen(getContext: context, getReceiptItem: bill,);
                                },child: Icon(Icons.edit)),
                              ],
                            ),
                            SizedBox(height: 10),
                            _buildInfoRow("Price", "₹ ${bill.total}"),
                            bill.items.isEmpty?SizedBox():SizedBox(height: 10),
                            bill.items.isEmpty?SizedBox():Text("Items", style: TextStyle(fontWeight: FontWeight.w500)),
                            bill.items.isEmpty?SizedBox():SizedBox(height: 8),
                            for (var item in bill.items)
                              Row(
                                children: [
                                  Text("\u2022 ", style: TextStyle(fontSize: 18)),
                                  Expanded(child: Text(item, style: TextStyle(fontWeight: FontWeight.bold)))
                                ],
                              ),
                            SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          return Center(child:Text("Something went wrong"));
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
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
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel'),
              ),
            ),
            SizedBox(width: 30),
            Expanded(
              child: BlocBuilder<BillDetailBloc, BillDetailState>(
                builder: (context, state) {
                  final isLoading = state is BillDeleteLoading;
                  return ElevatedButton(
                    onPressed:  (){
                      if(!isLoading){
                        callDeleteButton(widget.billId);
                      }
                    },
                    child: isLoading ? CircularProgressIndicatorWidget() : Text('Delete'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontWeight: FontWeight.w500)),
        SizedBox(width: 20),
        Flexible(
          child: Text(value, style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

}
