import 'package:flutter/material.dart';
import 'package:tarcking_app/core/extensions/extensions.dart';
import '../../../../core/theme/app_colors.dart';
import 'get_fall_back_image.dart';

class AddressWidget extends StatelessWidget {
  final String titleAddress;
  final String image;
  final String storeName;
  final String address;
  final int? fallbackIndex;

  const AddressWidget({
    super.key,
    required this.titleAddress,
    required this.image,
    required this.storeName,
    required this.address,
     this.fallbackIndex,
  });

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 10),
        Text(
          titleAddress,
          style: const TextStyle(
            fontSize: 15,
            color: AppColors.grey,
            fontFamily: "Inter",
          ),
        ),
        const SizedBox(height: 5),
        Container(
          width: size.width * 0.95,
          height: size.height * 0.082,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: AppColors.grey.withOpacity(0.3),
                spreadRadius: 0.5,
                blurRadius: 4,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: FallbackImageWidget(
                  image: image,
                  fallbackIndex: fallbackIndex ?? 0,
                  width: size.width * 0.15,
                  height: size.height * 0.08,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      storeName,
                      style: const TextStyle(
                        fontSize: 15,
                        color: AppColors.grey,
                        fontFamily: "Inter",
                      ),
                    ).setHorizontalPadding(context, 0.001),
                    const SizedBox(height: 5),
                    Expanded(
                      child: Row(
                        children: [
                          const Icon(Icons.location_on_outlined),
                          const SizedBox(width: 5),
                          Flexible(
                            child: Text(
                              address,
                              style: const TextStyle(
                                fontSize: 13,
                                color: AppColors.black,
                                fontFamily: "Inter",
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ).setHorizontalPadding(context, 0.01);
  }
}
