import 'package:flutter/material.dart';

class FallbackImageWidget extends StatelessWidget {
  final String image;
  final int fallbackIndex;
  final double width;
  final double height;

  const FallbackImageWidget({
    super.key,
    required this.image,
    required this.fallbackIndex,
    required this.width,
    required this.height,
  });

  final List<String> imagesList = const [
    "assets/images/yasser2.jpg",
    "assets/images/edo.png",
    "assets/images/nasser.png",
    "assets/images/empty_profile_image.jpg",
  ];

  @override
  Widget build(BuildContext context) {
    final index = fallbackIndex % imagesList.length;

    if (image == "default-profile.png") {
      return Image.asset(
        imagesList[index],
        width: width,
        height: height,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            "assets/images/empty_profile_image.jpg",
            width: width,
            height: height,
            fit: BoxFit.cover,
          );
        },
      );
    }

    return Image.network(
      image,
      width: width,
      height: height,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          imagesList[index],
          width: width,
          height: height,
          fit: BoxFit.cover,
        );
      },
    );
  }
}
