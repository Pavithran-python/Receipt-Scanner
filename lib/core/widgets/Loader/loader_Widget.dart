import 'package:flutter/material.dart';
import 'package:scanner/core/constants/colors.dart';
import 'package:shimmer/shimmer.dart';

Widget LoaderWidget({required double loaderWidth,required double loaderHeight,required double radius}){
  return Shimmer.fromColors(
    baseColor: AppColors.loaderColor,
    highlightColor: AppColors.background,
    child: Container(
      width: loaderWidth,
      height: loaderHeight,
      decoration: BoxDecoration(
        color:AppColors.loaderColor,
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
    ),
  );
}