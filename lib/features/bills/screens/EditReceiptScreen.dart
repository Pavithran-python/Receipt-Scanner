import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanner/core/constants/colors.dart';
import 'package:scanner/core/utils/date_format_change.dart';
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
        "total": double.tryParse(totalController.text.trim()) ?? 0,
        "items": itemsController.text.trim().isEmpty ? [] : itemsController.text.trim().split(',').map((e) => e.trim()).toList(),
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

  String? validateDate(String? value) {
    if (value == null || value.trim().isEmpty) return 'Date is required';
    final regex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
    if (!regex.hasMatch(value.trim())) return 'Enter date as YYYY-MM-DD';
    return null;
  }

  String? validateAmount(String? value) {
    if (value == null || value.trim().isEmpty) return 'Amount is required';
    final parsed = double.tryParse(value.trim());
    return parsed == null ? 'Enter a valid number' : null;
  }

  String? validateItems(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Items are required';
    }
    final items = value.split(',').map((e) => e.trim()).toList();
    if (items.any((item) => item.isEmpty)) {
      return 'Each item must be non-empty and comma-separated';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(title: Text('Edit Receipt')),
      body: BlocListener<BillDetailBloc, BillDetailState>(
        listener: (context, state) {
          if (state is BillOperationSuccess) {
            Bill getNewBill = state.bill;
            if(widget.isUpdate){
              context.read<BillListBloc>().add(UpdateBillToListEvent(getNewBill));
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Receipt updated successfully")),);
            }
            else{
              context.read<BillListBloc>().add(AddBillToListEvent(getNewBill));
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Receipt created successfully")),);
            }
            Navigator.pop(context,widget.isUpdate);
          }
          if (state is BillDetailError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)),);
          }
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  TextFormField(controller: merchantController, enabled: !widget.isUpdate,decoration: InputDecoration(labelText: 'Merchant'), validator: (val) => val == null || val.trim().isEmpty ? 'Merchant is required' : null,),
                  SizedBox(height: 20),
                  TextFormField(controller: totalController, decoration: InputDecoration(labelText: 'Total (INR)'), keyboardType: TextInputType.numberWithOptions(decimal: true), validator: validateAmount,),
                  SizedBox(height: 20),
                  TextFormField(controller: dateController, enabled: !widget.isUpdate,decoration: InputDecoration(labelText: 'Date (YYYY-MM-DD)'), validator: validateDate,),
                  SizedBox(height: 20),
                  TextFormField(controller: categoryController, enabled: !widget.isUpdate,decoration: InputDecoration(labelText: 'Category'), validator: (val) => val == null || val.trim().isEmpty ? 'Category is required' : null,),
                  SizedBox(height: 20),
                  TextFormField(controller: itemsController, decoration: InputDecoration(labelText: 'Items (comma separated)'),validator: validateItems,),
                ],
              ),
            ),
          ),
        ),
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
            Expanded(child: OutlinedButton(onPressed: () => Navigator.pop(context), child: Text('Cancel'),),),
            SizedBox(width: 30),
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
                    child: isLoading ? CircularProgressIndicatorWidget() : Text( widget.isUpdate?"Update":'Save'),
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