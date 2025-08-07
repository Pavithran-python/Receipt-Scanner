
import 'package:flutter/material.dart';
import 'package:scanner/core/constants/sizes.dart';
import 'package:scanner/core/widgets/Loader/loader_Widget.dart';

class SecureImage extends StatelessWidget {
  final String url;
  final double? height;
  final double? width;
  final double radius;
  final BoxFit getBoxFit;

  const SecureImage({super.key, required this.url,required this.radius,required this.height,required this.width,required this.getBoxFit});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Image.network(url, height: height, width: width, fit: getBoxFit,
        errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image),
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return LoaderWidget(loaderWidth: width??AppSizes.loaderDefaultSize, loaderHeight: height??width??AppSizes.loaderDefaultSize, radius: radius,);
        },
      ),
    );
  }
}