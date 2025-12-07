
class UpdateOrderStateResponse {
  final String message;
  final String orderId;
  final String state;

  UpdateOrderStateResponse({
    required this.message,
    required this.orderId,
    required this.state,
  });

  factory UpdateOrderStateResponse.fromJson(Map<String, dynamic> json) {
    final orders = json['orders'] as Map<String, dynamic>? ?? {};
    return UpdateOrderStateResponse(
      message: json['message']?.toString() ?? '',
      orderId: orders['_id']?.toString() ?? '',
      state: orders['state']?.toString() ?? '',
    );
  }
}