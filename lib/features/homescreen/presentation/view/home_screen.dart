import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tarcking_app/core/extensions/extensions.dart';
import 'package:tarcking_app/core/theme/app_colors.dart';

import '../../../../core/common/widgets/custome_loading_indicator.dart';
import '../../../../core/contants/app_images.dart';
import '../viewmodel/home_cubit.dart';
import '../viewmodel/home_states.dart';
import '../widgets/order_container_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if (state is HomeErrorState) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (context, state) {
          if (state is HomeLoadingState) {
            return AppLoadingIndicator();
          } else if (state is HomeSuccessState) {
            final orders = state.ordersResponseEntity.orders;

            return RefreshIndicator(
              onRefresh: () async {
                await context.read<HomeCubit>().getOrders();
              },
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 70),
                    Row(
                      children: [
                        Image.asset(AppImages.floweryRider),
                      ],
                    ),
                    const SizedBox(height: 40),

                    ...orders.asMap().entries.map((entry) {
                      final index = entry.key;
                      final order = entry.value;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: OrderContainerWidget(
                          key: ValueKey(order.wrapperId),
                          orderEntity: order,
                          orderIndex: index,
                        ),
                      );
                    }),

                    const SizedBox(height: 50),
                  ],
                ).setHorizontalPadding(context, 0.04),
              ),
            );
          } else {
            return const Center(child: Text("No Data"));
          }
        },
      ),
    );
  }
}
