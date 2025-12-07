import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarcking_app/core/contants/app_icons.dart';
import 'package:tarcking_app/core/extensions/extensions.dart';
import 'package:tarcking_app/features/myorders/presentation/view_model/my_order_states.dart';
import 'package:tarcking_app/features/myorders/presentation/widgets/myorders_container_widget.dart';
import 'package:tarcking_app/features/myorders/presentation/widgets/order_status_widget.dart';
import '../../../../core/common/widgets/custome_loading_indicator.dart';
import '../../../../core/l10n/translation/app_localizations.dart';
import '../../../../core/routes/route_names.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/get_localization_helper_function.dart';
import '../view_model/my_orders_cubit.dart';
import 'package:tarcking_app/features/homescreen/domain/entities/order_entity.dart' as HomeOrderEntity;
import 'package:tarcking_app/features/homescreen/domain/entities/user_entity.dart' as HomeUserEntity;
import 'package:tarcking_app/features/homescreen/domain/entities/store_entity.dart' as HomeStoreEntity;
import 'package:tarcking_app/features/homescreen/domain/entities/order_item_entity.dart' as HomeOrderItemEntity;
import 'package:tarcking_app/features/homescreen/domain/entities/product_entity.dart' as HomeProductEntity;
import 'package:tarcking_app/features/myorders/domain/entities/order_entity.dart' as MyOrderEntity;


class MyOrdersScreen extends StatefulWidget {
  const MyOrdersScreen({super.key});

  @override
  State<MyOrdersScreen> createState() => _MyOrdersScreenState();
}

class _MyOrdersScreenState extends State<MyOrdersScreen> {
  @override
  void initState() {
    super.initState();
    context.read<MyOrdersCubit>().getOrders();
  }

  // Conversion method to convert myorders OrderEntity to homescreen OrderEntity
  HomeOrderEntity.OrderEntity _convertToHomeOrderEntity(
      MyOrderEntity.OrderEntity myOrderEntity) {
    return HomeOrderEntity.OrderEntity(
      wrapperId: myOrderEntity.wrapperId,
      id: myOrderEntity.id,
      user: HomeUserEntity.UserEntity(
        id: myOrderEntity.user.id,
        firstName: myOrderEntity.user.firstName,
        lastName: myOrderEntity.user.lastName,
        email: myOrderEntity.user.email,
        gender: myOrderEntity.user.gender,
        phone: myOrderEntity.user.phone,
        photo: myOrderEntity.user.photo,
      ),
      orderItems: myOrderEntity.orderItems.map((item) => HomeOrderItemEntity.OrderItemEntity(
        id: item.id,
        product: HomeProductEntity.ProductEntity(
          id: item.product.id,
          title: item.product.title,
          slug: item.product.slug,
          description: item.product.description,
          imgCover: item.product.imgCover,
          images: item.product.images,
          price: item.product.price,
          priceAfterDiscount: item.product.priceAfterDiscount,
          quantity: item.product.quantity,
          sold: item.product.sold,
          category: item.product.category,
          occasion: item.product.occasion,
          rateAvg: item.product.rateAvg,
          rateCount: item.product.rateCount,
          createdAt: item.product.createdAt,
          updatedAt: item.product.updatedAt,
        ),
        price: item.price,
        quantity: item.quantity,
      )).toList(),
      totalPrice: myOrderEntity.totalPrice,
      paymentType: myOrderEntity.paymentType,
      isPaid: myOrderEntity.isPaid,
      isDelivered: myOrderEntity.isDelivered,
      state: myOrderEntity.state,
      orderNumber: myOrderEntity.orderNumber,
      store: HomeStoreEntity.StoreEntity(
        name: myOrderEntity.store.name,
        image: myOrderEntity.store.image,
        address: myOrderEntity.store.address,
        phoneNumber: myOrderEntity.store.phoneNumber,
        latLong: myOrderEntity.store.latLong,
      ),
      createdAt: myOrderEntity.createdAt,
      updatedAt: myOrderEntity.updatedAt,
    );
  }

  @override
  Widget build(BuildContext context) {
    final local = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: true,
        elevation: 0,
        leading: IconButton(
          iconSize: 24,
          icon: const Icon(Icons.arrow_back_ios_new_sharp, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          local.myOrdersTitle,
          style: theme.textTheme.titleLarge?.copyWith(fontSize: 24),
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<MyOrdersCubit, MyOrderStates>(
          listener: (context, state) {
            if (state is HomeErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            if (state is HomeLoadingState) {
              return const AppLoadingIndicator();
            } else if (state is HomeSuccessState) {
              final orders = state.ordersResponseEntity.orders;
              final completedOrders = orders
                  .where((o) => o.state.toLowerCase().trim() == "completed")
                  .length;


              final cancelledOrders = orders
                  .where((o) =>
              o.state.toLowerCase().trim() == "cancelled" ||
                  o.state.toLowerCase().trim() == "canceled")
                  .length;

              final inProgressOrders = orders
                  .where((o) => o.state.toLowerCase().trim() == "inprogress")
                  .length;

              return RefreshIndicator(
                onRefresh: () async {
                  await context.read<MyOrdersCubit>().getOrders();
                },
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Row(
                            children: [
                              OrderStatusWidget(
                                ordersNumber: inProgressOrders.toString(),
                                icon: AppIcons.inProgressIcon,
                                status: local.inProgressStatus,
                                backgroundColor:
                                Colors.orange.withOpacity(0.15),
                                iconColor: Colors.orange,
                              ),
                              const SizedBox(width: 20),
                              OrderStatusWidget(
                                ordersNumber: completedOrders.toString(),
                                icon: AppIcons.acceptedIcon,
                                status: local.completedStatus,
                                backgroundColor:
                                AppColors.green.withOpacity(0.15),
                                iconColor: AppColors.green,
                              ),
                              const SizedBox(width: 20),
                              OrderStatusWidget(
                                ordersNumber: cancelledOrders.toString(),
                                icon: AppIcons.cancelledIcon,
                                status: local.cancelledStatus,
                                backgroundColor:
                                AppColors.red.withOpacity(0.15),
                                iconColor: AppColors.red,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 30),

                        Text(
                          local.recentOrder,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            fontFamily: "Inter",
                          ),
                        ).setHorizontalPadding(context, 0.015),

                        const SizedBox(height: 30),

                        if (orders.isEmpty)
                          Center(
                            child: Text(
                              local.noOrdersFound,
                              style: const TextStyle(
                                  fontSize: 16, color: Colors.grey),
                            ),
                          )
                        else
                          Column(
                            children: orders.asMap().entries.map((entry) {
                              final index = entry.key;
                              final order = entry.value;

                              final userAddress = context
                                  .read<MyOrdersCubit>()
                                  .orderAddressMap[order.wrapperId] ??
                                  local.unknownAddress;

                              return Padding(
                                padding: const EdgeInsets.only(bottom: 25),
                                child: Builder(
                                  builder: (context) {
                                    final localizedState = getLocalizedOrderState(context, order.state);

                                    return GestureDetector(
                                      onTap: (){
                                        final homeOrderEntity = _convertToHomeOrderEntity(order);
                                        Navigator.pushNamed(
                                          context,
                                          AppRoutes.orderDetails,
                                          arguments: homeOrderEntity,
                                        );
                                      },
                                      child: MyOrderContainerWidget(
                                        orderState: localizedState.label,
                                        stateColor: localizedState.color,
                                        orderNumber: order.orderNumber,
                                        storeName: order.store.name,
                                        storeAddress: order.store.address,
                                        storeImage: order.store.image,
                                        userName: "${order.user.firstName} ${order.user.lastName}",
                                        userImage: order.user.photo,
                                        userAddress: userAddress,
                                        fallbackIndex: index,
                                      ),
                                    );

                                  },
                                ),
                              );
                            }).toList(),
                          ),
                      ],
                    ).setHorizontalPadding(context, 0.04),
                  ),
                ),
              );
            } else if (state is HomeErrorState) {
              return Center(child: Text(state.message));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}
