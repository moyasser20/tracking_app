class UpdateOrderStateRequest {
  final String state;

  UpdateOrderStateRequest({required this.state});

  Map<String, dynamic> toJson() => {'state': state};
}
