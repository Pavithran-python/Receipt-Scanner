import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:scanner/APIMethod/ReceiptAPIMethod.dart';
import 'package:scanner/Models/Receipt.dart';
import 'EditReceiptScreen.dart';

class PreviewScreen extends StatelessWidget {
  final String imagePath;
  PreviewScreen({super.key, required this.imagePath});
  final ValueNotifier<bool> _isLoading = ValueNotifier(false);

  navigateToEditReceiptScreen({required BuildContext getContext,required Receipt getReceiptItem}){
    Navigator.push(getContext, MaterialPageRoute(builder: (_) => EditReceiptScreen(getReceiptItem: getReceiptItem,),),).then((val){
      Navigator.pop(getContext,val);
    });
  }

  callReceiptAPI({required BuildContext getContext,required String base64data,}) async {
    var receiptAPIResponse = await ReceiptAPIMethod().scanAPICall(getImageBase64: base64data);
    print(receiptAPIResponse);
    if(receiptAPIResponse["status"]){
      Map<String,dynamic> getContentMap = receiptAPIResponse["content"];
      String getMerchant = getContentMap['merchant'] ?? '';
      double getTotal = getContentMap['total'] ?? 0.0;
      String getDate = getContentMap['date']??'';
      String getCategory = getContentMap['category']??'';
      List getItemList = getContentMap['items']?? [];
      Receipt getReceiptItem = Receipt(merchant: getMerchant, total: getTotal, date: getDate, category: getCategory, items: getItemList, imageBase64: base64data);
      navigateToEditReceiptScreen(getContext: getContext,getReceiptItem: getReceiptItem);
    }
    else{
      String getErrorMessage = receiptAPIResponse["message"];
      ScaffoldMessenger.of(getContext).showSnackBar(
        SnackBar(content: Text(getErrorMessage)),
      );
    }
    _isLoading.value = false;
  }


  Future<void> onContinuePressed({required BuildContext getContext}) async {
    if (_isLoading.value) return;                  // already busy
    _isLoading.value = true;                       // start loader

    final bytes = File(imagePath).readAsBytesSync();
    final base64 = base64Encode(bytes);
    callReceiptAPI(getContext: getContext,base64data: base64);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text('Preview')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(child: Image.file(File(imagePath),fit: BoxFit.fill,)),
          Container(
            width: screenWidth,
            height: screenHeight/12,
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
            padding: EdgeInsets.symmetric(horizontal: screenWidth/12),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: ElevatedButton(
                  onPressed: (){
                    Navigator.pop(context,"retake");
                    },
                  child: Text('Retake'),
                ),),
                SizedBox(width: 30),
                ValueListenableBuilder<bool>(
                  valueListenable: _isLoading,
                  builder: (_, loading, __) => Expanded(
                    child: ElevatedButton(
                      onPressed:  (){
                        if(!loading){
                          onContinuePressed(getContext: context);
                        }
                      },
                      child: loading ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                        ),
                      )
                          : const Text('Continue'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
