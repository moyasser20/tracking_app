import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarcking_app/core/firebase/firebase_service.dart';
import 'package:tarcking_app/features/homescreen/domain/entities/order_entity.dart';
import 'package:tarcking_app/features/order_details/data/models/order_details_model.dart';
import 'package:tarcking_app/features/order_details/presentation/views/widgets/order_details_bottom_section.dart';
import 'package:tarcking_app/features/order_details/presentation/views/widgets/order_details_top_section.dart';
import 'package:tarcking_app/features/order_details/presentation/views/widgets/update_order_button_widget.dart';
import '../../../../core/api/client/api_client.dart';
import '../../../../core/config/di.dart';
import '../../../../core/l10n/translation/app_localizations.dart';
import '../cubit/order_details_cubit.dart';

class OrderDetailsScreen extends StatefulWidget {
  final OrderEntity? orderEntity;
  final VoidCallback? onOrderUpdated;

  const OrderDetailsScreen({super.key, this.orderEntity, this.onOrderUpdated});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  late final OrderDetailsCubit _cubit;
  String? _lastParentState;
  bool shouldRefresh = false;

  @override
  void initState() {
    super.initState();
    _cubit = OrderDetailsCubit(getIt<ApiClient>(), getIt<FirestoreService>());

    if (widget.orderEntity != null) {
      _lastParentState = widget.orderEntity!.state;
      _cubit.getOrderDetails(widget.orderEntity!);
    }
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var locale = AppLocalizations.of(context);
    if (widget.orderEntity == null) return const SizedBox();
    return BlocProvider(
      create: (context) => _cubit,
      child: Scaffold(
        appBar: AppBar(
          title: Text(locale?.orderDetails ?? ""),
          backgroundColor: Colors.white,
          centerTitle: false,
          foregroundColor: Colors.black,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
        body: BlocConsumer<OrderDetailsCubit, OrderDetailsState>(
          listener: (context, state) {
            if (state is OrderDetailsLoaded) {
              if (state.order.state != _lastParentState) {
                _lastParentState = state.order.state;
              }
            }
          },
          builder: (context, state) {
            if (state is OrderDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is OrderDetailsError) {
              return Center(child: Text(state.message));
            } else if (state is OrderDetailsLoaded ||
                state is OrderDetailsUpdating) {
              final order =
              state is OrderDetailsLoaded
                  ? state.order
                  : (state as OrderDetailsUpdating).order;
              return _OrderDetailsContent(
                order: order,
                isUpdating: state is OrderDetailsUpdating,
                onOrderUpdated: widget.onOrderUpdated,
              );
            } else {
              return const Center(child: Text('No order data'));
            }
          },
        ),
      ),
    );
  }
}

class _OrderDetailsContent extends StatelessWidget {
  final OrderDetails order;
  final bool isUpdating;
  final VoidCallback? onOrderUpdated;

  const _OrderDetailsContent({
    required this.order,
    this.isUpdating = false,
    this.onOrderUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OrderDetailsTopSection(order: order, address: order.userAddress),
          OrderDetailsBottomSection(
            items: order.items,
            paymentMethod: order.paymentMethod,
            total: order.total,
          ),
          const SizedBox(height: 8),
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
                  'Total',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'EGP ${order.total}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ),
          if (order.state != 'canceled' && order.state != 'completed')...[
            const SizedBox(height: 8),
          ],
          SizedBox(height: 16,),
          UpdateOrderButtonWidget(
            order: order,
            isUpdating: isUpdating,
            onButtonClicked: (String buttonText) {
              _handleUpdateButtonClick(context, order, buttonText);
            },
          ),
        ],
      ),
    );
  }

  void _handleUpdateButtonClick(
      BuildContext context,
      OrderDetails order,
      String buttonText,
      ) {
    context.read<OrderDetailsCubit>().onUpdateButtonClicked(order, buttonText);
  }
}