import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_state_management/theme/icons.dart';

class CachedImageWidget extends StatelessWidget {
  const CachedImageWidget({
    super.key,
    required this.imgUrl,
    this.imgHeight,
    this.imgWidth,
    this.imgFit = BoxFit.cover,
    this.imgScale = 1,
  });

  final String imgUrl;
  final double? imgHeight;
  final double? imgWidth;
  final double imgScale;
  final BoxFit imgFit;

  @override
  Widget build(BuildContext context) {
    final widgetSize = MediaQuery.sizeOf(context);

    return CachedNetworkImage(
      imageUrl: imgUrl,
      height: imgHeight ?? widgetSize.height*0.3,
      width: imgWidth ?? widgetSize.width*0.3,
      scale: imgScale,
      fit: imgFit,
      errorWidget: (context, url, error)=> const Icon(MyAppIcons.error),
    );
  }
}
