

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

Widget LoaderWidget({required double loaderWidth,required double loaderHeight,required double radius}){
  return Shimmer.fromColors(
    baseColor: Colors.grey.withOpacity(0.5),
    highlightColor: Colors.white,
    child: Container(
      width: loaderWidth,
      height: loaderHeight,
      decoration: BoxDecoration(
        color:Colors.grey.withOpacity(0.5),
        borderRadius: BorderRadius.all(Radius.circular(radius)),
      ),
    ),
  );
}