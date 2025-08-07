import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scanner/core/constants/colors.dart';
import 'package:scanner/core/constants/constant.dart';
import 'package:scanner/core/widgets/Loader/loader_Widget.dart';
import 'PreviewScreen.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  navigateToPreviewScreen({required BuildContext getContext,required XFile image}){
    Navigator.push(getContext, MaterialPageRoute(builder: (_) => PreviewScreen(imagePath: image.path),),).then((val){
      print("$val");
      if(val!=null && val == retake){
      }
      else{
        Navigator.pop(getContext,val);
      }
    });
  }

  Future<CameraController?> _initCamera(BuildContext context) async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      final cameras = await availableCameras();
      final backCamera = cameras.firstWhere((cam) => cam.lensDirection == CameraLensDirection.back,);
      final controller = CameraController(backCamera, ResolutionPreset.medium);
      await controller.initialize();
      return controller;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(cameraPermissionDenied)),);
      Navigator.pop(context);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return FutureBuilder(
      future: _initCamera(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Scaffold(
            appBar: AppBar(title: Text(cameraAppBarText)),
            body: LoaderWidget(loaderWidth: screenWidth, loaderHeight: screenHeight, radius: 0),
          );
        }
        final controller = snapshot.data as CameraController;
        return Scaffold(
          backgroundColor: AppColors.pageBackground,
          appBar: AppBar(title: Text(cameraAppBarText)),
          body: Container(width: screenWidth,height:screenHeight,child: CameraPreview(controller),),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          floatingActionButton: FloatingActionButton(onPressed: ()async{
            final image = await controller.takePicture();
            navigateToPreviewScreen(getContext: context, image: image);
          },child: Icon(Icons.camera,),),
        );
      },
    );
  }


}