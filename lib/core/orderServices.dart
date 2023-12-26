import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medi_deliver/model/cartItemModel.dart';
import 'package:medi_deliver/model/order.dart' as model;
import 'package:medi_deliver/model/product.dart';

class OrderService {
  // Add order to Firestore
  static Future<void> addOrderToFirestore(model.Order order) async {
    try {
      await FirebaseFirestore.instance.collection('orders').add({
        'orderId': order.orderId,
        'date': order.date,
        'buyerId': order.buyerId,
        'buyerName': order.buyerName,
        'buyerLocation': order.buyerLocation,
        'discount': order.discount,
        'status': order.orderStatus,
        'tax': order.tax,
        'totalAmount': order.calculateTotalAmount(),
        'items': order.Items.map((item) {
          return {
            'name': item.product.name,
            'quantity': item.quantity,
            'price': item.product.price,
          };
        }).toList(),
      });

      print('Order added to Firestore');
    } catch (error) {
      print('Error adding order to Firestore: $error');
    }
  }

  static Future<List<model.Order>> getOrdersForBuyer(String? buyerId) async {
    List<model.Order> orders = [];

    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('orders')
          .where('buyerId', isEqualTo: buyerId)
          .get();

      for (QueryDocumentSnapshot documentSnapshot in querySnapshot.docs) {
        Map<String, dynamic> data =
            documentSnapshot.data() as Map<String, dynamic>;

        List<CartItem> items = (data['items'] as List<dynamic>).map((itemData) {
          return CartItem(
            product: Product(
              category: '',
              description: '',
              imagePath: 'asset/images/categories/category2.jpg',
              name: itemData['name'],
              price: itemData['price'],
            ),
            quantity: itemData['quantity'],
          );
        }).toList();

        model.Order order = model.Order(
          orderId: data['orderId'],
          date: (data['date'] as Timestamp).toDate(),
          buyerId: data['buyerId'],
          buyerName: data['buyerName'],
          buyerLocation: data['buyerLocation'],
          Items: items,
          discount: data['discount'],
          tax: data['tax'],
        );

        order.calculateTotalAmount(); // Recalculate total amount

        orders.add(order);
      }

      print('Orders retrieved from Firestore for buyer $buyerId');
    } catch (error) {
      print('Error getting orders from Firestore: $error');
    }

    return orders;
  }
}
