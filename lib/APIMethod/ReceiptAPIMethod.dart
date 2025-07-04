import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:scanner/Utils/Constant.dart';
import 'CheckInternetConnectionMethod.dart';

class ReceiptAPIMethod{

  Future<Map<String, dynamic>> scanAPICall({required String getImageBase64,}) async{
    Map<String, dynamic> scanResponse = {"status":false,"message":"","content":{}};
    bool internetConnectCheck = await CheckInternetConnectionMethod();
    if(internetConnectCheck){
      const url = 'https://api.together.xyz/v1/chat/completions';
      print("Api Url : ${url}");
      const getKey = 'Bearer $apiKey'; // Replace with your actual API key

      final headers = {
        'Content-Type': 'application/json',
        'Authorization': getKey,
      };

      final body = jsonEncode({
        "model": "meta-llama/Llama-Vision-Free",
        "messages": [
          {
            "role": "user",
            "content": [
              {
                "type": "text",
                "text":
                "Extract receipt information and return ONLY as valid JSON format: {\"merchant\": \"store name\", \"total\": 0.00, \"date\": \"YYYY-MM-DD\", \"category\": \"food/gas/retail/entertainment/other\", \"items\": [\"item1\", \"item2\"]}. Do not include any text outside the JSON."
              },
              {
                "type": "image_url",
                "image_url": {
                  "url": "data:image/jpeg;base64,$getImageBase64"
                }
              }
            ]
          }
        ],
        "max_tokens": 200
      });

      try{
        var scanAPIAPIResponse = await http.post(Uri.parse(url), headers: headers, body: body);
        print(scanAPIAPIResponse.body);
        if(scanAPIAPIResponse.statusCode==200){
          scanResponse["status"] = true;
          Map<String,dynamic> getResponseMap = jsonDecode(scanAPIAPIResponse.body);
          print(getResponseMap);
          List getChoiceList = getResponseMap['choices']??[];
          if(getChoiceList.isNotEmpty){
            Map<String,dynamic> getChoiceMap = getChoiceList[0]??{};
            print("Choice map : $getChoiceMap");
            if(getChoiceMap.isNotEmpty){
              Map<String,dynamic> getMessageMap = getChoiceMap['message']??{};
              print("Message map : $getMessageMap");
              if(getMessageMap.isNotEmpty){
                String getContentString = getMessageMap['content']??"";
                if(getContentString.isNotEmpty){
                  Map<String,dynamic> getContentMap = jsonDecode(getContentString);
                  print("Content map : $getContentMap");
                  scanResponse["content"] = getContentMap;
                }
                else{
                  scanResponse["status"] = false;
                  String getErrorMessage = "Something went wrong";
                  scanResponse["message"] = getErrorMessage;
                }
              }
              else{
                scanResponse["status"] = false;
                String getErrorMessage = "Something went wrong";
                scanResponse["message"] = getErrorMessage;
              }
            }
            else{
              scanResponse["status"] = false;
              String getErrorMessage = "Something went wrong";
              scanResponse["message"] = getErrorMessage;
            }
          }
          else{
            scanResponse["status"] = false;
            String getErrorMessage = "Something went wrong";
            scanResponse["message"] = getErrorMessage;
          }
        }
        else{
          scanResponse["status"] = false;
          Map getResponseMap = jsonDecode(scanAPIAPIResponse.body);
          String getErrorMessage = getResponseMap["message"]??getResponseMap.toString();
          scanResponse["message"] = getErrorMessage;
        }
      }
      catch(e){
        scanResponse["status"] = false;
        String getErrorMessage = e.toString()??"";
        scanResponse["message"] = getErrorMessage;
      }
    }
    else{
      scanResponse["status"] = false;
      scanResponse["message"] = "Please check your internet connection";
    }
    return scanResponse;
  }

}