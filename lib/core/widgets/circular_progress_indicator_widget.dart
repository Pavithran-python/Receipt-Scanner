
import 'package:flutter/material.dart';
import 'package:scanner/core/constants/colors.dart';
import 'package:scanner/core/constants/sizes.dart';

class CircularProgressIndicatorWidget extends StatelessWidget{
  const CircularProgressIndicatorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: AppSizes.circularProgressHeight,
        height: AppSizes.circularProgressHeight,
        child:CircularProgressIndicator(
          color: AppColors.buttonTextColor,
          strokeWidth: AppSizes.circularProgressWidth,
        ),
      ),
    );
  }

}