import 'dart:ffi';

import 'package:flutter/material.dart';

class MyImageLoader extends StatelessWidget {
  final String imageSrc;
  final double width;
  final double height;
  final LoaderType? loaderType;

  MyImageLoader({
    super.key,
    required this.imageSrc,
    required this.width,
    required this.height,
    this.loaderType,
  });

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageSrc,
      fit: BoxFit.cover,
      height: height,
      width: width,
      loadingBuilder: (context, child, ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        final double? loaderValue = loadingProgress.expectedTotalBytes != null
            ? loadingProgress.cumulativeBytesLoaded /
                loadingProgress.expectedTotalBytes!
            : null;
        return loaderFactory(type: loaderType, value: loaderValue);
      },
      errorBuilder: (context, child, stacktrace) {
        return const Icon(
          Icons.image,
        );
      },
    );
  }
}

enum LoaderType { linear, circular }

Widget loaderFactory({required double? value, LoaderType? type}) {
  switch (type) {
    case LoaderType.linear:
      return Column(
        children: [
          const Spacer(),
          LinearProgressIndicator(value: value),
        ],
      );
    default:
      return CircularProgressIndicator(
        value: value,
      );
  }
}
