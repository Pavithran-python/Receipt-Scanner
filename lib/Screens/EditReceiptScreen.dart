import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanner/Bloc/receipt_bloc.dart';
import 'package:scanner/Bloc/receipt_event.dart';
import 'package:scanner/Models/Receipt.dart';


typedef TextController = TextEditingController;

class EditReceiptScreen extends StatelessWidget {
  final Receipt getReceiptItem;
  final merchantController = TextController();
  final totalController = TextController();
  final dateController = TextController();
  final categoryController = TextController();
  final itemsController = TextController();

  EditReceiptScreen({super.key, required this.getReceiptItem});
  
  callSaveButton({required BuildContext context}){
    final receipt = Receipt(
      merchant: merchantController.text,
      total: double.tryParse(totalController.text) ?? 0,
      date: dateController.text,
      category: categoryController.text,
      items: itemsController.text.split(','),
      imageBase64: getReceiptItem.imageBase64,
    );
    context.read<ReceiptBloc>().add(AddReceipt(receipt));
    Navigator.pop(context,"save");
  }

  @override
  Widget build(BuildContext context) {
    merchantController.text =  getReceiptItem.merchant;
    totalController.text = getReceiptItem.total.toString();
    dateController.text =  getReceiptItem.date;
    categoryController.text = getReceiptItem.category;
    itemsController.text = getReceiptItem.items.join(',');
    return Scaffold(
      appBar: AppBar(title: Text('Edit Receipt')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: ListView(
          children: [
            TextField(controller: merchantController, decoration: InputDecoration(labelText: 'Merchant')),
            TextField(controller: totalController, decoration: InputDecoration(labelText: 'Total (INR)'), keyboardType: TextInputType.numberWithOptions(decimal: true)),
            TextField(controller: dateController, decoration: InputDecoration(labelText: 'Date (YYYY-MM-DD)')),
            TextField(controller: categoryController, decoration: InputDecoration(labelText: 'Category')),
            TextField(controller: itemsController, decoration: InputDecoration(labelText: 'Items (comma separated)')),
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
                  callSaveButton(context: context);
                },
                child: Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}