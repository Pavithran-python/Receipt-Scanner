

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
          SizedBox(height: 20,),
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
      margin: EdgeInsets.symmetric(horizontal: screenWidth/25,vertical: screenHeight/75),
      child: LoaderWidget(loaderWidth: screenWidth, loaderHeight: screenWidth/3.5+screenHeight/60+screenHeight/60, radius: 10),
    );
  }

}