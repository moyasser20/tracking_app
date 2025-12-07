import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarcking_app/core/extensions/extensions.dart';

import '../../../../core/Widgets/Custom_Elevated_Button.dart';
import '../../../../core/common/widgets/custom_snackbar_widget.dart';
import '../../../../core/l10n/translation/app_localizations.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/order_entity.dart';
import '../viewmodel/home_cubit.dart';
import '../viewmodel/home_states.dart';
import 'address_widget.dart';

class OrderContainerWidget extends StatelessWidget {
  final OrderEntity orderEntity;
  final int orderIndex;

  const OrderContainerWidget({
    super.key,
    required this.orderEntity,
    required this.orderIndex,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final local = AppLocalizations.of(context)!;
    final homeCubit = context.read<HomeCubit>();
    final address =
        homeCubit.orderAddressMap[orderEntity.wrapperId] ??
            local.unknownAddress;

    return Container(
      width: size.width * 0.9,
      padding: EdgeInsets.all(size.width * 0.04),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withValues(alpha: 0.3),
            spreadRadius: 0.5,
            blurRadius: 4,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: size.height * 0.02),
          Text(
            local.flowerOrder,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: AppColors.black,
              fontFamily: "Inter",
            ),
          ),
          SizedBox(height: size.height * 0.02),

          AddressWidget(
            titleAddress: local.pickupAddress,
            image: orderEntity.store.image,
            storeName: orderEntity.store.name,
            address: orderEntity.store.address,
            fallbackIndex: orderEntity.wrapperId.hashCode,
          ),

          SizedBox(height: size.height * 0.03),

          AddressWidget(
            titleAddress: local.userAddress,
            image: orderEntity.user.photo,
            storeName:
            "${orderEntity.user.firstName} ${orderEntity.user.lastName}",
            address: address,
            fallbackIndex: orderEntity.wrapperId.hashCode,
          ),

          SizedBox(height: size.height * 0.03),

          Row(
            children: [
              Text(
                "${orderEntity.totalPrice}",
                style: const TextStyle(
                  color: AppColors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  fontFamily: "Inter",
                ),
              ),
              const Spacer(),
              Flexible(
                flex: 1,
                child: CustomElevatedButton(
                  text: local.reject,
                  onPressed: () {
                    context.read<HomeCubit>().rejectOrderLocally(
                      orderEntity.wrapperId,
                    );
                    showCustomSnackBar(
                      context,
                      local.orderRejectedSuccessfully,
                      isError: false,
                    );
                  },
                  color: AppColors.white,
                  textColor: AppColors.pink,
                  borderColor: AppColors.pink,
                  height: size.height * 0.05,
                ),
              ),
              SizedBox(width: size.width * 0.02),
              Flexible(
                flex: 1,
                child: CustomElevatedButton(
                  text: local.accept,
                  onPressed: () {
                    showCustomSnackBar(
                      context,
                      local.orderAcceptedSuccessfully,
                      isError: false,
                    );
                    Future.delayed(const Duration(milliseconds: 800), () {
                      final homeCubit = context.read<HomeCubit>();
                      final currentState = homeCubit.state;

                      OrderEntity orderToPass;
                      if (currentState is HomeSuccessState) {
                        orderToPass = currentState.ordersResponseEntity.orders
                            .firstWhere((o) => o.id == orderEntity.id);
                      } else {
                        orderToPass = orderEntity;
                      }

                      Navigator.pushNamed(
                        context,
                        AppRoutes.orderDetails,
                        arguments: orderToPass,
                      ).then((_) {
                        log('Refreshing orders after returning from details');
                        homeCubit.getOrders();
                      });
                    });
                  },
                  color: AppColors.pink,
                  textColor: AppColors.white,
                  height: size.height * 0.05,
                ),
              ),
            ],
          ),
        ],
      ),
    ).setHorizontalPadding(context, 0.015);
  }
}
