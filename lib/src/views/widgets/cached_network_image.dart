import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCustomNetworkImage extends StatelessWidget {
  final String image;
  final String errorImage;
  final double? width;
  const CustomCustomNetworkImage(
      {super.key, required this.image, required this.errorImage, this.width});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: image,
      width: width ?? MediaQuery.sizeOf(context).width * 0.2,
      fit: BoxFit.cover,
      errorWidget: (context, url, error) {
        return Image.asset(
          fit: BoxFit.cover,
          errorImage,
        );
      },
    );
  }
}
