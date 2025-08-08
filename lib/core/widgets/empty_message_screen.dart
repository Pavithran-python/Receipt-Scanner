import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scanner/core/constants/sizes.dart';

class EmptyMessageScreen extends StatelessWidget{
  final String emptyMessage;
  EmptyMessageScreen({super.key,required this.emptyMessage});

  @override
  Widget build(BuildContext context) {
    return Center(child: Padding(padding: EdgeInsets.symmetric(horizontal: AppSizes.horizontalPadding,vertical: AppSizes.verticalPadding),child: Text(emptyMessage,style: Theme.of(context).textTheme.displayLarge,)));
  }

}
