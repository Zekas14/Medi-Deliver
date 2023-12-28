import 'package:flutter/material.dart';
import 'package:medi_deliver/model/order.dart';
import 'package:medi_deliver/core/orderServices.dart';

class OrderProvider extends ChangeNotifier {
  List<Order> _orders = [];

  List<Order> get orders => _orders;

  Future<void> fetchOrders(String? userId) async {
    _orders = await OrderService.getOrdersForBuyer(userId);
    notifyListeners();
  }
}
