import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanner/core/constants/colors.dart';
import 'package:scanner/core/constants/constant.dart';
import 'package:scanner/core/constants/sizes.dart';
import 'package:scanner/core/utils/date_format_change.dart';
import 'package:scanner/core/widgets/Loader/receipt_detail_loader_screen.dart';
import 'package:scanner/core/widgets/circular_progress_indicator_widget.dart';
import 'package:scanner/core/widgets/empty_message_screen.dart';
import 'package:scanner/core/widgets/message_box.dart';
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
      appBar: AppBar(title: Text(receiptDetailAppBar)),
      body: BlocConsumer<BillDetailBloc, BillDetailState>(
        listener: (context, state) {
          if (state is DeleteBillSuccess) {
            context.read<BillListBloc>().add(DeleteBillToListEvent(widget.billId));
            final res = state.deleteResponse;
            String getMessage = res[message] ?? receiptDeletedSuccessfully;
            Navigator.pop(context, delete);
            MessageBox(context: context, getMessage: getMessage);
          } else if (state is BillDetailError) {
            MessageBox(context: context, getMessage: state.message);
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
                    color: AppColors.black,
                    child: SecureImage(url: bill!.imageUrl, radius: 0, height: screenWidth, width: screenWidth, getBoxFit: BoxFit.fitHeight,),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: AppSizes.horizontalPadding,vertical: AppSizes.verticalPadding),
                        padding: EdgeInsets.symmetric(horizontal: AppSizes.horizontalPadding,vertical: AppSizes.verticalPadding),
                        decoration: BoxDecoration(
                          color: AppColors.cardBackgroundColor,
                          borderRadius: BorderRadius.circular(AppSizes.radius),
                          boxShadow: [BoxShadow(blurStyle: BlurStyle.outer, color: AppColors.boxShadowColor, blurRadius: AppSizes.shadowBlurRadius,),],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(productDetailText, style:Theme.of(context).textTheme.bodyLarge,),
                            SizedBox(height: AppSizes.verticalPadding),
                            _buildInfoRow(merchantText, bill.merchant),
                            SizedBox(height: (AppSizes.verticalPadding/2)),
                            _buildInfoRow(categoryText, bill.category),
                            SizedBox(height: (AppSizes.verticalPadding/2)),
                            _buildInfoRow(dateText, DateFormatChange().formatReadableDate(inputDate: bill.date)),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: AppSizes.horizontalPadding,right: AppSizes.horizontalPadding,bottom: AppSizes.verticalPadding),
                        padding: EdgeInsets.symmetric(horizontal: AppSizes.horizontalPadding,vertical: AppSizes.verticalPadding),
                        decoration: BoxDecoration(
                          color: AppColors.cardBackgroundColor,
                          borderRadius: BorderRadius.circular(AppSizes.radius),
                          boxShadow: [BoxShadow(blurStyle: BlurStyle.outer,color: AppColors.boxShadowColor, blurRadius: AppSizes.shadowBlurRadius,),],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(priceDetailText,style: Theme.of(context).textTheme.bodyLarge,),
                                InkWell(onTap: (){navigateToEditReceiptScreen(getContext: context, getReceiptItem: bill,);},child: Icon(Icons.edit,size: AppSizes.editIconSize,)),
                              ],
                            ),
                            SizedBox(height: AppSizes.verticalPadding),
                            _buildInfoRow(priceText, "$currency${bill.total}"),
                            bill.items.isEmpty?SizedBox():SizedBox(height: (AppSizes.verticalPadding/2)),
                            bill.items.isEmpty?SizedBox():Text(itemsText, style: Theme.of(context).textTheme.bodyMedium),
                            bill.items.isEmpty?SizedBox():SizedBox(height: (AppSizes.verticalPadding/2)),
                            for (var item in bill.items)
                              Row(
                                children: [
                                  Text(bullet, style: Theme.of(context).textTheme.bodyMedium),
                                  Expanded(child: Text(item, style: Theme.of(context).textTheme.bodyLarge))
                                ],
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }
          return EmptyMessageScreen(emptyMessage: somethingWentWrong);
        },
      ),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: AppSizes.horizontalPadding, vertical: AppSizes.verticalPadding),
        decoration: BoxDecoration(
          color: AppColors.cardBackgroundColor,
          boxShadow: [BoxShadow(blurStyle: BlurStyle.outer, color: AppColors.boxShadowColor, blurRadius: AppSizes.shadowBlurRadius,),],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: OutlinedButton(onPressed: () => Navigator.pop(context), child: Text(cancelButtonText),),),
            SizedBox(width: AppSizes.horizontalPadding),
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
                    child: isLoading ? CircularProgressIndicatorWidget() : Text(deleteButtonText),
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
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
        SizedBox(width: AppSizes.horizontalPadding),
        Flexible(child: Text(value, style: Theme.of(context).textTheme.bodyLarge),),
      ],
    );
  }

}
