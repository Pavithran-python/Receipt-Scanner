import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scanner/core/constants/colors.dart';
import 'package:scanner/core/constants/sizes.dart';
import 'package:scanner/core/widgets/Loader/loader_Widget.dart';

class ReceiptDetailLoaderScreen extends StatelessWidget{
  double screenWidth = 0;
  double screenHeight = 0;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          LoaderWidget(loaderWidth: screenWidth, loaderHeight: screenWidth, radius:0),
          SizedBox(height: AppSizes.verticalPadding),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: AppSizes.horizontalPadding,),
                padding: EdgeInsets.symmetric(horizontal: AppSizes.horizontalPadding,vertical: AppSizes.verticalPadding),
                decoration: BoxDecoration(
                  color: AppColors.cardBackgroundColor,
                  borderRadius: BorderRadius.circular(AppSizes.radius),
                  boxShadow: [
                    BoxShadow(
                      blurStyle: BlurStyle.outer,
                      color: AppColors.boxShadowColor,
                      blurRadius: AppSizes.shadowBlurRadius,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AppSizes.verticalPadding),
                    LoaderWidget(loaderWidth: AppSizes.loaderTitleTextWidth, loaderHeight: AppSizes.loaderTitleTextSize, radius: AppSizes.loaderTextRadius),
                    SizedBox(height: AppSizes.verticalPadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        LoaderWidget(loaderWidth: AppSizes.loaderContentTextWidth, loaderHeight: AppSizes.loaderContentTextSize, radius: AppSizes.loaderTextRadius),
                        LoaderWidget(loaderWidth: AppSizes.loaderContentTextWidth, loaderHeight: AppSizes.loaderContentTextSize, radius: AppSizes.loaderTextRadius),
                      ],
                    ),
                    SizedBox(height: AppSizes.verticalPadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        LoaderWidget(loaderWidth: AppSizes.loaderContentTextWidth, loaderHeight: AppSizes.loaderContentTextSize, radius: AppSizes.loaderTextRadius),
                        LoaderWidget(loaderWidth: AppSizes.loaderContentTextWidth, loaderHeight: AppSizes.loaderContentTextSize, radius: AppSizes.loaderTextRadius),
                      ],
                    ),
                    SizedBox(height: AppSizes.verticalPadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        LoaderWidget(loaderWidth: AppSizes.loaderContentTextWidth, loaderHeight: AppSizes.loaderContentTextSize, radius: AppSizes.loaderTextRadius),
                        LoaderWidget(loaderWidth: AppSizes.loaderContentTextWidth, loaderHeight: AppSizes.loaderContentTextSize, radius: AppSizes.loaderTextRadius),
                      ],
                    ),
                    SizedBox(height: AppSizes.verticalPadding),
                  ],
                ),
              ),
              SizedBox(height: AppSizes.verticalPadding),
              Container(
                margin: EdgeInsets.symmetric(horizontal: AppSizes.horizontalPadding,),
                padding: EdgeInsets.symmetric(horizontal: AppSizes.horizontalPadding,vertical: AppSizes.verticalPadding),
                decoration: BoxDecoration(
                  color: AppColors.cardBackgroundColor,
                  borderRadius: BorderRadius.circular(AppSizes.radius),
                  boxShadow: [
                    BoxShadow(
                      blurStyle: BlurStyle.outer,
                      color: AppColors.boxShadowColor,
                      blurRadius: AppSizes.shadowBlurRadius,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AppSizes.verticalPadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        LoaderWidget(loaderWidth: AppSizes.loaderTitleTextWidth, loaderHeight: AppSizes.loaderTitleTextSize, radius: AppSizes.loaderTextRadius),
                        LoaderWidget(loaderWidth: AppSizes.loaderContentTextWidth, loaderHeight: AppSizes.loaderContentTextSize, radius: AppSizes.loaderTextRadius),
                      ],
                    ),
                    SizedBox(height: AppSizes.verticalPadding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        LoaderWidget(loaderWidth: AppSizes.loaderContentTextWidth, loaderHeight: AppSizes.loaderContentTextSize, radius: AppSizes.loaderTextRadius),
                        LoaderWidget(loaderWidth: AppSizes.loaderContentTextWidth, loaderHeight: AppSizes.loaderContentTextSize, radius: AppSizes.loaderTextRadius),
                      ],
                    ),
                    SizedBox(height: AppSizes.verticalPadding),
                    LoaderWidget(loaderWidth: AppSizes.loaderContentTextWidth, loaderHeight: AppSizes.loaderContentTextSize, radius: AppSizes.loaderTextRadius),
                    SizedBox(height: AppSizes.verticalPadding),
                    Padding(padding: EdgeInsets.symmetric(horizontal: AppSizes.horizontalPadding,),child: LoaderWidget(loaderWidth: AppSizes.loaderContentTextWidth, loaderHeight: AppSizes.loaderContentTextSize, radius: AppSizes.loaderTextRadius),),
                    SizedBox(height: AppSizes.verticalPadding),
                    Padding(padding: EdgeInsets.symmetric(horizontal: AppSizes.horizontalPadding,),child: LoaderWidget(loaderWidth: AppSizes.loaderContentTextWidth, loaderHeight: AppSizes.loaderContentTextSize, radius: AppSizes.loaderTextRadius),),
                    SizedBox(height: AppSizes.verticalPadding),
                    Padding(padding: EdgeInsets.symmetric(horizontal: AppSizes.horizontalPadding,),child: LoaderWidget(loaderWidth: AppSizes.loaderContentTextWidth, loaderHeight: AppSizes.loaderContentTextSize, radius: AppSizes.loaderTextRadius),),
                    SizedBox(height: AppSizes.verticalPadding),
                    Padding(padding: EdgeInsets.symmetric(horizontal: AppSizes.horizontalPadding,),child: LoaderWidget(loaderWidth: AppSizes.loaderContentTextWidth, loaderHeight: AppSizes.loaderContentTextSize, radius: AppSizes.loaderTextRadius),),
                    SizedBox(height: AppSizes.verticalPadding),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

}