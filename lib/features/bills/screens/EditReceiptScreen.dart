import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanner/core/constants/colors.dart';
import 'package:scanner/core/constants/constant.dart';
import 'package:scanner/core/constants/json_constant.dart';
import 'package:scanner/core/constants/sizes.dart';
import 'package:scanner/core/utils/check_condition.dart';
import 'package:scanner/core/widgets/circular_progress_indicator_widget.dart';
import 'package:scanner/features/bill_list/bloc/bill_list_bloc.dart';
import 'package:scanner/features/bill_list/bloc/bill_list_event.dart';
import 'package:scanner/features/bills/bloc/bill_detail_bloc.dart';
import 'package:scanner/features/bills/bloc/bill_detail_event.dart';
import 'package:scanner/features/bills/bloc/bill_detail_state.dart';
import 'package:scanner/features/bills/models/bill_model.dart';

class EditReceiptScreen extends StatefulWidget {
  final Bill getReceiptItem;
  final bool isUpdate;
  const EditReceiptScreen({super.key, required this.getReceiptItem,required this.isUpdate});

  @override
  State<EditReceiptScreen> createState() => _EditReceiptScreenState();
}

class _EditReceiptScreenState extends State<EditReceiptScreen> {
  final _formKey = GlobalKey<FormState>();
  final merchantController = TextEditingController();
  final totalController = TextEditingController();
  final dateController = TextEditingController();
  final categoryController = TextEditingController();
  final itemsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    merchantController.text = widget.getReceiptItem.merchant;
    totalController.text = widget.getReceiptItem.total.toString();
    dateController.text = widget.getReceiptItem.date;
    categoryController.text = widget.getReceiptItem.category;
    itemsController.text = widget.getReceiptItem.items.join(',');
  }

  callUpdateButton({required BuildContext context}){
    if (_formKey.currentState!.validate()) {
      final updates = {
        totalJsonText: double.tryParse(totalController.text.trim()) ?? 0,
        itemsJsonText: itemsController.text.trim().isEmpty ? [] : itemsController.text.trim().split(',').map((e) => e.trim()).toList(),
      };
      context.read<BillDetailBloc>().add(UpdateBill(widget.getReceiptItem.id!, updates));
    }
  }

  callSaveButton({required BuildContext context}) {
    if (_formKey.currentState!.validate()) {
      final receipt = Bill(merchant: merchantController.text.trim(), total: double.tryParse(totalController.text.trim()) ?? 0, date: dateController.text.trim(), category: categoryController.text.trim(), items: itemsController.text.trim().isEmpty ? [] : itemsController.text.trim().split(',').map((e) => e.trim()).toList(), imageUrl: widget.getReceiptItem.imageUrl,);
      context.read<BillDetailBloc>().add(AddBill(receipt));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(title: Text(editReceiptAppBarTitle)),
      body: BlocListener<BillDetailBloc, BillDetailState>(
        listener: (context, state) {
          if (state is BillOperationSuccess) {
            Bill getNewBill = state.bill;
            if(widget.isUpdate){
              context.read<BillListBloc>().add(UpdateBillToListEvent(getNewBill));
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(receiptUpdate)),);
            }
            else{
              context.read<BillListBloc>().add(AddBillToListEvent(getNewBill));
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(receiptCreate)),);
            }
            Navigator.pop(context,widget.isUpdate);
          }
          if (state is BillDetailError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)),);
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: AppSizes.horizontalPadding),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: AppSizes.verticalPadding+AppSizes.verticalPadding),
                  TextFormField(controller: merchantController, enabled: !widget.isUpdate,decoration: InputDecoration(labelText: merchantLabel), validator: (val) => val == null || val.trim().isEmpty ? errorMerchantRequired : null,),
                  SizedBox(height: AppSizes.verticalPadding+AppSizes.verticalPadding),
                  TextFormField(controller: totalController, decoration: InputDecoration(labelText: totalLabel), keyboardType: TextInputType.numberWithOptions(decimal: true), validator: checkCondition().validateAmount,),
                  SizedBox(height: AppSizes.verticalPadding+AppSizes.verticalPadding),
                  TextFormField(controller: dateController, enabled: !widget.isUpdate,decoration: InputDecoration(labelText: dateLabel), validator: checkCondition().validateDate,),
                  SizedBox(height: AppSizes.verticalPadding+AppSizes.verticalPadding),
                  TextFormField(controller: categoryController, enabled: !widget.isUpdate,decoration: InputDecoration(labelText: categoryLabel), validator: (val) => val == null || val.trim().isEmpty ? errorCategoryRequired : null,),
                  SizedBox(height: AppSizes.verticalPadding+AppSizes.verticalPadding),
                  TextFormField(controller: itemsController, decoration: InputDecoration(labelText: itemsLabel),validator: checkCondition().validateItems,),
                ],
              ),
            ),
          ),
        ),
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
                  final isLoading = state is BillDetailLoading;
                  return ElevatedButton(
                    onPressed: (){
                      if(!isLoading){
                        if(widget.isUpdate){
                          callUpdateButton(context: context);
                        }
                        else{
                          callSaveButton(context: context);
                        }
                      }
                    },
                    child: isLoading ? CircularProgressIndicatorWidget() : Text( widget.isUpdate?updateButtonText:saveButtonText),
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