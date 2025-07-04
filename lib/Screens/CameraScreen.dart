import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';

import 'PreviewScreen.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  navigateToPreviewScreen({required BuildContext getContext,required XFile image}){
    Navigator.push(getContext, MaterialPageRoute(builder: (_) => PreviewScreen(imagePath: image.path),),).then((val){
      print("$val");
      if(val==null){
        Navigator.pop(getContext,val);
      }
      else{
        if(val == "retake"){
          print("retahggh");
        }
        else{
          Navigator.pop(getContext,val);
        }
      }
    });
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
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final controller = snapshot.data as CameraController;
        return Scaffold(
          appBar: AppBar(title: Text('Camera')),
          body: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(width: screenWidth,height:screenHeight,child: CameraPreview(controller),),
              Container(
                width: screenWidth/8,
                height: screenWidth/8,
                margin: EdgeInsets.only(bottom: screenHeight/30),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(screenWidth/10)),
                  boxShadow: [
                    BoxShadow(
                      blurStyle: BlurStyle.outer,
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 7,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () async {
                    final image = await controller.takePicture();
                    navigateToPreviewScreen(getContext: context, image: image);
                  },
                  child: Icon(Icons.camera,size: screenWidth/10,),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<CameraController?> _initCamera(BuildContext context) async {
    final status = await Permission.camera.request();
    if (status.isGranted) {
      final cameras = await availableCameras();
      final backCamera = cameras.firstWhere(
            (cam) => cam.lensDirection == CameraLensDirection.back,
      );
      final controller = CameraController(backCamera, ResolutionPreset.medium);
      await controller.initialize();
      return controller;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Camera permission denied')),
      );
      Navigator.pop(context);
      return null;
    }
  }
}