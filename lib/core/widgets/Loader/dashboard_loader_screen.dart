

import 'package:flutter/cupertino.dart';
import 'package:scanner/core/widgets/Loader/loader_Widget.dart';

class DashboardLoaderScreen extends StatelessWidget{
  DashboardLoaderScreen({super.key});
  double screenWidth = 0;
  double screenHeight = 0;

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          receiptLoader(),
          receiptLoader(),
          receiptLoader(),
          receiptLoader(),
          receiptLoader(),
          receiptLoader(),
          receiptLoader(),
          receiptLoader(),
          receiptLoader(),
          receiptLoader(),
        ],
      ),
    );
  }

  Widget receiptLoader(){
    return Container(
      width: screenWidth,
      margin: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
      child: LoaderWidget(loaderWidth: screenWidth, loaderHeight: 100, radius: 10),
    );
  }

}