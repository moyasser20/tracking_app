import 'package:flutter/material.dart';
import 'package:tarcking_app/core/l10n/translation/app_localizations.dart';

import '../../../../../core/contants/app_images.dart';
import '../../../data/models/order_details_model.dart';

class OrderDetailsBottomSection extends StatelessWidget {
  const OrderDetailsBottomSection({
    super.key,
    required this.items,
    required this.paymentMethod,
    required this.total,
  });

  final List<OrderItem> items;
  final String paymentMethod;
  final double total;

  @override
  Widget build(BuildContext context) {
    var local = AppLocalizations.of(context)!;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(local.orderDetails, style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        Column(
          children: [
            ListView.builder(
              itemBuilder:
                  (context, index) =>
                  _OrderItemRow(item: items[index], total: total),
              itemCount: items.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
            ),
          ],
        ),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Payment method',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const Spacer(),
              Text(
                paymentMethod,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
      ],
    );
  }
}

class _OrderItemRow extends StatelessWidget {
  final OrderItem item;
  final double total;

  const _OrderItemRow({required this.item, required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
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
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              AppImages.orderItemImage,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        item.name,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      'X${item.quantity}',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  'EGP ${item.price}',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}