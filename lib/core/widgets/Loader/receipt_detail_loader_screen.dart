

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
          SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      blurStyle: BlurStyle.outer,
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 7,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    LoaderWidget(loaderWidth: 175, loaderHeight: 20, radius: 10),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        LoaderWidget(loaderWidth: 100, loaderHeight: 16, radius: 10),
                        LoaderWidget(loaderWidth: 100, loaderHeight: 16, radius: 10),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        LoaderWidget(loaderWidth: 100, loaderHeight: 16, radius: 10),
                        LoaderWidget(loaderWidth: 100, loaderHeight: 16, radius: 10),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        LoaderWidget(loaderWidth: 100, loaderHeight: 16, radius: 10),
                        LoaderWidget(loaderWidth: 100, loaderHeight: 16, radius: 10),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      blurStyle: BlurStyle.outer,
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 7,
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        LoaderWidget(loaderWidth: 175, loaderHeight: 20, radius: 10),
                        LoaderWidget(loaderWidth: 50, loaderHeight: 16, radius: 10),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        LoaderWidget(loaderWidth: 100, loaderHeight: 16, radius: 10),
                        LoaderWidget(loaderWidth: 100, loaderHeight: 16, radius: 10),
                      ],
                    ),
                    SizedBox(height: 20),
                    LoaderWidget(loaderWidth: 100, loaderHeight: 16, radius: 10),
                    SizedBox(height: 10),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 16),child: LoaderWidget(loaderWidth: 100, loaderHeight: 16, radius: 10),),
                    SizedBox(height: 10),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 16),child: LoaderWidget(loaderWidth: 100, loaderHeight: 16, radius: 10),),
                    SizedBox(height: 10),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 16),child: LoaderWidget(loaderWidth: 100, loaderHeight: 16, radius: 10),),
                    SizedBox(height: 10),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 16),child: LoaderWidget(loaderWidth: 100, loaderHeight: 16, radius: 10),),
                    SizedBox(height: 20),
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