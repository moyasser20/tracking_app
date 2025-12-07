import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class FirestoreService {
  final FirebaseFirestore _firestore;

  FirestoreService(this._firestore);

  Future<void> sendOrderToUser({
    required String orderId,
    required String userId,
    required Map<String, dynamic> orderData,
  }) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('orders')
          .doc(orderId)
          .set(orderData, SetOptions(merge: true));
    } catch (e) {
      throw Exception('Failed to send order to user: $e');
    }
  }

  Future<void> updateOrderStatusForUser({
    required String orderId,
    required String userId,
    required String status,
  }) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('orders')
          .doc(orderId)
          .update({
        'state': status,
        'updatedAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to update order status: $e');
    }
  }

  Stream<DocumentSnapshot> getOrderStream(String userId, String orderId) {
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('orders')
        .doc(orderId)
        .snapshots();
  }

  Future<void> updateOrderButtonCallback({
    required String orderId,
    required String userId,
    required String currentState,
  }) async {
    try {
      await _firestore
          .collection('users')
          .doc(userId)
          .collection('orders')
          .doc(orderId)
          .update({
        'update_order_button': currentState,
        'button_last_clicked': FieldValue.serverTimestamp(),
        'last_updated': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Failed to update order button callback: $e');
    }
  }
}