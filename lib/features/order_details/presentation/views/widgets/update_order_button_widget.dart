import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarcking_app/features/order_details/data/models/order_details_model.dart';

import '../../../../../core/Widgets/Custom_Elevated_Button.dart';
import '../../cubit/order_details_cubit.dart';
import '../../../../successpage/presentation/view/success_page.dart';

class UpdateOrderButtonWidget extends StatelessWidget {
  final OrderDetails order;
  final bool isUpdating;
  final Function(String buttonText)? onButtonClicked;

  const UpdateOrderButtonWidget({
    super.key,
    required this.order,
    required this.isUpdating,
    this.onButtonClicked,
  });

  @override
  Widget build(BuildContext context) {
    final buttonText = _getButtonText(order.state);

    return CustomElevatedButton(
      width: double.infinity,
      text: buttonText,
      onPressed: isUpdating || order.state == 'canceled'
          ? null
          : () {
        onButtonClicked?.call(buttonText);

        if (order.state == 'completed') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SuccessPage()),
          );
        } else {
          context.read<OrderDetailsCubit>().updateOrderStatus();
        }
      },
    );
  }

  String _getButtonText(String state) {
    switch (state) {
      case 'pending':
        return 'Start Order';
      case 'inProgress':
        return 'Complete Order';
      case 'canceled':
        return 'Canceled';
      case 'completed':
        return 'Completed';
      default:
        return 'Update Order';
    }
  }
}
