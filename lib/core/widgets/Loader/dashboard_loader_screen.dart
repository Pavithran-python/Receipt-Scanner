

import 'package:flutter/cupertino.dart';
import 'package:scanner/core/constants/sizes.dart';
import 'package:scanner/core/widgets/Loader/loader_Widget.dart';

class DashboardLoaderScreen extends StatelessWidget{
  DashboardLoaderScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      margin: EdgeInsets.only(left: AppSizes.horizontalPadding,right: AppSizes.horizontalPadding,top: AppSizes.verticalPadding),
      child: LoaderWidget(loaderWidth: double.infinity, loaderHeight: AppSizes.dashboardLoaderHeight, radius: AppSizes.radius),
    );
  }

}