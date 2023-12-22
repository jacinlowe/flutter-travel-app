import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class MapViewScreen extends StatelessWidget {
  const MapViewScreen({super.key});
  final String mapUrl = 'lib/assets/map.png';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
          LayoutBuilder(builder: (context, BoxConstraints viewportConstraints) {
        return PhotoView(
          initialScale: PhotoViewComputedScale.covered,
          backgroundDecoration:
              BoxDecoration(color: Theme.of(context).canvasColor),
          imageProvider: AssetImage(
            mapUrl,
          ),
        );
      }),
    );
  }
}
