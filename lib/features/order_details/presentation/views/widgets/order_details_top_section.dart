import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../../../core/contants/app_icons.dart';
import '../../../../../core/contants/app_images.dart';
import '../../../../../core/routes/route_names.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/date_converter.dart';
import '../../../data/models/order_details_model.dart';
import '../../cubit/order_details_cubit.dart';

class OrderDetailsTopSection extends StatelessWidget {
  const OrderDetailsTopSection({
    super.key,
    required this.order,
    required this.address,
  });

  final OrderDetails order;
  final Address address;

  @override
  Widget build(BuildContext context) {
    final currentStep = _getCurrentStep(order.state);
    final totalSteps = 5;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (order.state != 'canceled' && order.state != 'completed')...[
          StepProgressIndicator(
            totalSteps: totalSteps,
            currentStep: currentStep,
            size: 4,
            padding: 4,
            selectedColor: AppColors.green,
            unselectedColor: Colors.grey[400]!,
            roundedEdges: const Radius.circular(10),
            customStep: (index, color, _) {
              return Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(10),
                ),
              );
            },
          ),
          SizedBox(height: 16,),
        ],
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.pink.withValues(alpha: 0.07),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Status : ${order.state}',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.green,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Order ID : ${order.orderNumber}',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                _formatDate(order.createdAt),
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: Colors.grey[800]),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.orderMapScreen,
              arguments: {'order': order, 'isFromPickup': true},
            );
          },
          child: _AddressSection(
            title: 'Pickup address',
            address: order.pickupAddress, isUser: false,
          ),
        ),
        SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppRoutes.orderMapScreen,
              arguments: {'order': order, 'isFromPickup': false},
            );
          },
          child: _AddressSection(title: 'User Address', address: address, isUser: true,),
        ),
        SizedBox(height:8),
      ],
    );
  }

  int _getCurrentStep(String state) {
    switch (state) {
      case 'pending':
        return 1;
      case 'inProgress':
        return 2;
      case 'Out for delivery':
        return 3;
      case 'Arrived':
        return 4;
      case 'Delivered':
      case 'completed':
        return 5;
      case 'canceled':
        return 0;
      default:
        return 1;
    }
  }

  String _formatDate(DateTime date) {
    DateConverter dateConverter = DateConverter();
    return dateConverter.formatDate(date);
  }
}

class _AddressSection extends StatelessWidget {
  const _AddressSection({
    required this.title,
    required this.address,
    required this.isUser
  });

  final String title;
  final Address address;
  final bool isUser;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.grey.withValues(alpha: 0.2),
              width: 2,
              style: BorderStyle.solid,
            ),
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.asset(
                  isUser? "assets/images/edo.png":AppImages.flowerImage,
                  width: 50,
                  height: 50,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      address.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        SvgPicture.asset(AppIcons.locationIcon),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            address.address,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  context.read<OrderDetailsCubit>().call(address.phoneNumber);
                },
                child: Icon(
                  Icons.local_phone_outlined,
                  color: AppColors.pink,
                  size: 20,
                ),
              ),
              const SizedBox(width: 16),
              InkWell(
                onTap: () {
                  context.read<OrderDetailsCubit>().shareViaWhatsApp(
                    address.phoneNumber,
                  );
                },
                child: SvgPicture.asset(
                  AppIcons.whatsappIcon,
                  height: 20,
                  width: 20,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}