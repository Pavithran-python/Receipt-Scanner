import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanner/core/constants/colors.dart';
import 'package:scanner/core/widgets/circular_progress_indicator_widget.dart';
import 'package:scanner/features/bills/bloc/bills_bloc.dart';
import 'package:scanner/features/bills/bloc/bills_event.dart';
import 'package:scanner/features/bills/bloc/bills_state.dart';
import 'package:scanner/features/bills/models/bill_model.dart';

class EditReceiptScreen extends StatefulWidget {
  final Bill getReceiptItem;
  const EditReceiptScreen({super.key, required this.getReceiptItem});

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

  void callSaveButton({required BuildContext context}) {
    if (_formKey.currentState!.validate()) {
      final receipt = Bill(merchant: merchantController.text.trim(), total: double.tryParse(totalController.text.trim()) ?? 0, date: dateController.text.trim(), category: categoryController.text.trim(), items: itemsController.text.trim().isEmpty ? [] : itemsController.text.trim().split(',').map((e) => e.trim()).toList(), imageUrl: widget.getReceiptItem.imageUrl,);
      context.read<BillBloc>().add(AddBill(receipt));
    }
  }

  String? validateDate(String? value) {
    if (value == null || value.trim().isEmpty) return 'Date is required';
    final regex = RegExp(r'^\d{4}-\d{2}-\d{2}$');
    if (!regex.hasMatch(value.trim())) return 'Enter date as YYYY-MM-DD';
    return null;
  }

  String? validateAmount(String? value) {
    if (value == null || value.trim().isEmpty) return null;
    final parsed = double.tryParse(value.trim());
    return parsed == null ? 'Enter a valid number' : null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pageBackground,
      appBar: AppBar(title: Text('Edit Receipt')),
      body: BlocListener<BillBloc, BillState>(
        listener: (context, state) {
          if (state is BillOperationSuccess) {
            Bill res = state.bill;
            Navigator.pop(context, res);
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Receipt created successfully")),);
          }
          if (state is BillError) {
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
                  TextFormField(controller: merchantController, decoration: InputDecoration(labelText: 'Merchant'), validator: (val) => val == null || val.trim().isEmpty ? 'Merchant is required' : null,),
                  SizedBox(height: 20),
                  TextFormField(controller: totalController, decoration: InputDecoration(labelText: 'Total (INR)'), keyboardType: TextInputType.numberWithOptions(decimal: true), validator: validateAmount,),
                  SizedBox(height: 20),
                  TextFormField(controller: dateController, decoration: InputDecoration(labelText: 'Date (YYYY-MM-DD)'), validator: validateDate,),
                  SizedBox(height: 20),
                  TextFormField(controller: categoryController, decoration: InputDecoration(labelText: 'Category'), validator: (val) => val == null || val.trim().isEmpty ? 'Category is required' : null,),
                  SizedBox(height: 20),
                  TextFormField(controller: itemsController, decoration: InputDecoration(labelText: 'Items (comma separated)'),),
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
              child: BlocBuilder<BillBloc, BillState>(
                builder: (context, state) {
                  final isLoading = state is BillLoading;
                  return ElevatedButton(
                    onPressed: (){
                      if(!isLoading){
                        callSaveButton(context: context);
                      }
                    },
                    child: isLoading ? CircularProgressIndicatorWidget() : Text('Save'),
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