import 'package:injectable/injectable.dart';

import '../../domain/entities/meta_data_entity.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/entities/order_item_entity.dart';
import '../../domain/entities/order_response_entity.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/entities/store_entity.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/home_repo.dart';
import '../data_sources/home_remote_datasource.dart';

@LazySingleton(as: HomeRepo)
class HomeRepoImpl implements HomeRepo {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepoImpl(this.remoteDataSource);

  @override
  Future<OrdersResponseEntity> getOrders() async {
    final dto = await remoteDataSource.getOrders();

    final orders =
        (dto.orders ?? []).map((orderDto) {
          final orderItems =
              (orderDto.orderItems ?? []).map((itemDto) {
                return OrderItemEntity(
                  id: itemDto.id ?? "",
                  product: ProductEntity(
                    id: itemDto.product?.id ?? "",
                    title: itemDto.product?.title ?? "Unknown Product",
                    slug: "",
                    description: "",
                    imgCover: "",
                    images: [],
                    price: itemDto.product?.price ?? 0,
                    quantity: 0,
                    sold: 0,
                    category: "",
                    occasion: "",
                    rateAvg: 0.0,
                    rateCount: 0,
                    createdAt: DateTime.now(),
                    updatedAt: DateTime.now(),
                  ),
                  price: itemDto.price ?? 0,
                  quantity: itemDto.quantity ?? 0,
                );
              }).toList();

          return OrderEntity(
            wrapperId: orderDto.id ?? "",
            id: orderDto.id ?? "",
            user: UserEntity(
              id: orderDto.user?.id ?? "",
              firstName: orderDto.user?.firstName ?? "",
              lastName: orderDto.user?.lastName ?? "",
              email: orderDto.user?.email ?? "",
              gender: orderDto.user?.gender ?? "",
              phone: orderDto.user?.phone ?? "",
              photo: orderDto.user?.photo ?? "",
            ),
            orderItems: orderItems,
            totalPrice: orderDto.totalPrice ?? 0,
            paymentType: orderDto.paymentType ?? "",
            isPaid: orderDto.isPaid ?? false,
            isDelivered: orderDto.isDelivered ?? false,
            state: orderDto.state ?? "",
            orderNumber: orderDto.orderNumber ?? "",
            store: StoreEntity(
              name: orderDto.store?.name ?? "",
              image: orderDto.store?.image ?? "",
              address: orderDto.store?.address ?? "",
              phoneNumber: orderDto.store?.phoneNumber ?? "",
              latLong: orderDto.store?.latLong ?? "",
            ),
            createdAt: _safeParseDate(orderDto.createdAt),
            updatedAt: _safeParseDate(orderDto.updatedAt),
          );
        }).toList();

    final metadata = Metadata(
      currentPage: dto.metadata?['currentPage'] ?? 1,
      totalPages: dto.metadata?['totalPages'] ?? 1,
      totalItems: dto.metadata?['totalItems'] ?? 0,
      limit: dto.metadata?['limit'] ?? 10,
    );

    return OrdersResponseEntity(
      message: dto.message ?? "",
      metadata: metadata,
      orders: orders,
    );
  }

  DateTime _safeParseDate(String? date) {
    if (date == null) return DateTime.now();
    try {
      return DateTime.parse(date);
    } catch (_) {
      return DateTime.now();
    }
  }
}
