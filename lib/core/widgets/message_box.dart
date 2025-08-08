import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

MessageBox({required BuildContext context,required String getMessage}){
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(getMessage,style: Theme.of(context).textTheme.displaySmall,)),);
}
