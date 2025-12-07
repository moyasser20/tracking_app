import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreTestScreen extends StatefulWidget {
  const FirestoreTestScreen({super.key});

  @override
  State<FirestoreTestScreen> createState() => _FirestoreTestScreenState();
}

class _FirestoreTestScreenState extends State<FirestoreTestScreen> {
  String _status = 'Testing...';
  final List<String> _logs = [];

  void _addLog(String message) {
    setState(() {
      _logs.add('${DateTime.now().toString()}: $message');
    });
    print(message);
  }

  // Test 1: Basic Firestore Connection
  Future<void> _testBasicConnection() async {
    _addLog('🔌 Testing basic Firestore connection...');

    try {
      await FirebaseFirestore.instance
          .collection('test_connection')
          .doc('basic_test')
          .set({
        'message': 'Hello Firestore!',
        'timestamp': FieldValue.serverTimestamp(),
      });

      _addLog('✅ Basic write successful!');

      // Test read
      final doc = await FirebaseFirestore.instance
          .collection('test_connection')
          .doc('basic_test')
          .get();

      if (doc.exists) {
        _addLog('✅ Basic read successful! Data: ${doc.data()}');
      } else {
        _addLog('❌ Basic read failed - document not found');
      }

    } catch (e) {
      _addLog('❌ Basic connection failed: $e');
    }
  }

  // Test 2: Test Order Data Structure
  Future<void> _testOrderDataStructure() async {
    _addLog('\n📦 Testing order data structure...');

    try {
      final testOrderData = {
        'id': 'test_order_123',
        'state': 'pending',
        'orderNumber': '#TEST001',
        'createdAt': DateTime.now().millisecondsSinceEpoch,
        'pickupAddress': {
          'name': 'Test Store',
          'address': '123 Test Street',
          'phoneNumber': '+1234567890',
        },
        'userAddress': {
          'name': 'Test User',
          'address': '456 User Avenue',
          'phoneNumber': '+0987654321',
        },
        'items': [
          {
            'name': 'Test Product 1',
            'quantity': 2,
            'price': 100.0,
            'productId': 'prod_1',
          },
          {
            'name': 'Test Product 2',
            'quantity': 1,
            'price': 50.0,
            'productId': 'prod_2',
          }
        ],
        'total': 250.0,
        'paymentMethod': 'Cash on delivery',
        'driverId': 'test_driver_123',
        'lastUpdated': FieldValue.serverTimestamp(),
      };

      await FirebaseFirestore.instance
          .collection('users')
          .doc('test_user_123')
          .collection('orders')
          .doc('test_order_123')
          .set(testOrderData);

      _addLog('✅ Order data written successfully!');

      // Verify the data
      final doc = await FirebaseFirestore.instance
          .collection('users')
          .doc('test_user_123')
          .collection('orders')
          .doc('test_order_123')
          .get();

      if (doc.exists) {
        final data = doc.data();
        _addLog('✅ Order data verified! State: ${data?['state']}, Total: ${data?['total']}');
      }

    } catch (e) {
      _addLog('❌ Order data test failed: $e');
    }
  }

  // Test 3: Test Real-time Updates
  void _testRealtimeUpdates() {
    _addLog('\n🔄 Testing real-time updates...');

    FirebaseFirestore.instance
        .collection('users')
        .doc('test_user_123')
        .collection('orders')
        .doc('test_order_123')
        .snapshots()
        .listen((documentSnapshot) {
      if (documentSnapshot.exists) {
        final data = documentSnapshot.data();
        _addLog('📡 Real-time update: State changed to ${data?['state']}');
      }
    }, onError: (error) {
      _addLog('❌ Real-time updates error: $error');
    });
  }

  // Test 4: Test Order Status Updates
  Future<void> _testStatusUpdates() async {
    _addLog('\n🔄 Testing status updates...');

    try {
      // Simulate status updates
      final statuses = ['pending', 'inProgress', 'completed'];

      for (final status in statuses) {
        await FirebaseFirestore.instance
            .collection('users')
            .doc('test_user_123')
            .collection('orders')
            .doc('test_order_123')
            .update({
          'state': status,
          'lastUpdated': FieldValue.serverTimestamp(),
        });

        _addLog('✅ Status updated to: $status');
        await Future.delayed(const Duration(seconds: 2));
      }

    } catch (e) {
      _addLog('❌ Status updates failed: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    _runAllTests();
  }

  Future<void> _runAllTests() async {
    _addLog('🚀 Starting Firestore tests...');

    await _testBasicConnection();
    await _testOrderDataStructure();
    _testRealtimeUpdates();
    await _testStatusUpdates();

    _addLog('\n🎉 All tests completed!');
    setState(() {
      _status = 'Testing completed!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firestore Test'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Status: $_status',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _logs.length,
                itemBuilder: (context, index) {
                  final log = _logs[index];
                  final color = log.contains('❌') ? Colors.red :
                  log.contains('✅') ? Colors.green :
                  Colors.black;

                  return Text(
                    log,
                    style: TextStyle(color: color, fontSize: 12),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                ElevatedButton(
                  onPressed: _runAllTests,
                  child: const Text('Run Tests Again'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const FirestoreDataViewer(),
                      ),
                    );
                  },
                  child: const Text('View Firestore Data'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// Data viewer to see what's in Firestore
class FirestoreDataViewer extends StatelessWidget {
  const FirestoreDataViewer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Firestore Data Viewer')),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collectionGroup('orders')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final documents = snapshot.data!.docs;

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (context, index) {
              final doc = documents[index];
              final data = doc.data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Order: ${data['orderNumber'] ?? 'N/A'}',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text('State: ${data['state'] ?? 'N/A'}'),
                      Text('Total: EGP ${data['total'] ?? 'N/A'}'),
                      Text('Items: ${(data['items'] as List?)?.length ?? 0}'),
                      Text('ID: ${doc.id}'),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}