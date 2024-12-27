import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/cart_model.dart';
import '../models/order_model.dart';
import '../service/api_adress.dart';

class CartState with ChangeNotifier {
  CartModel? _cartModel;
  List<OrderModel>? _orderList;

  Future<String?> _getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> getCartData() async {
    String url = '$baseUrl:8000/api/v1/cart/';
    String? token = await _getToken();

    if (token == null) return;

    try {
      final response = await http.get(Uri.parse(url), headers: {
        "Authorization": "token $token",
      });

      final data = json.decode(response.body) as Map;
      List<CartModel> cartList = [];

      if (data['error'] == false) {
        data['data'].forEach((element) {
          CartModel cartModel = CartModel.fromJson(element);
          cartList.add(cartModel);
        });
        _cartModel = cartList.isNotEmpty ? cartList[0] : null;
        notifyListeners();
      } else {
        print("Error: ${data['data']}");
      }
    } catch (e) {
      print("Error in getCartData: $e");
    }
  }

  Future<void> getOldOrders() async {
    String url = '$baseUrl:8000/api/v1/order/';
    String? token = await _getToken();

    if (token == null) return;

    try {
      final response = await http.get(Uri.parse(url), headers: {
        "Authorization": "token $token",
      });

      final data = json.decode(response.body) as Map;
      List<OrderModel> orderList = [];

      if (data['error'] == false) {
        data['data'].forEach((element) {
          OrderModel order = OrderModel.fromJson(element);
          orderList.add(order);
        });
        _orderList = orderList;
        notifyListeners();
      } else {
        print("Error: ${data['data']}");
      }
    } catch (e) {
      print("Error in getOldOrders: $e");
    }
  }

  Future<void> addToCart(int id) async {
    String url = '$baseUrl:8000/api/v1/addtocart/';
    String? token = await _getToken();

    if (token == null) return;

    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({'id': id}),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "token $token"
          });

      final data = json.decode(response.body) as Map;
      if (data['error'] == false) {
        await getCartData();
      }
    } catch (e) {
      print("Error in addToCart: $e");
    }
  }

  Future<void> deleteCartBook(int id) async {
    String url = '$baseUrl:8000/api/v1/deletecartbooks/';
    String? token = await _getToken();

    if (token == null) return;

    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({'id': id}),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "token $token"
          });

      final data = json.decode(response.body) as Map;
      if (data['error'] == false) {
        await getCartData();
      }
    } catch (e) {
      print("Error in deleteCartBook: $e");
    }
  }

  Future<bool> deleteCart(int id) async {
    String url = '$baseUrl:8000/api/v1/deletecart/';
    String? token = await _getToken();

    if (token == null) return false;

    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({'id': id}),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "token $token"
          });

      final data = json.decode(response.body) as Map;
      if (data['error'] == false) {
        await getCartData();
        _cartModel = null;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print("Error in deleteCart: $e");
      return false;
    }
  }

  Future<bool> orderCart(
      int cartId, String address, String email, String phone) async {
    String url = '$baseUrl:8000/api/v1/ordernow/';
    String? token = await _getToken();

    if (token == null) return false;

    try {
      final response = await http.post(Uri.parse(url),
          body: json.encode({
            "cartid": cartId,
            "address": address,
            "email": email,
            "phone": phone,
          }),
          headers: {
            "Content-Type": "application/json",
            "Authorization": "token $token"
          });

      final data = json.decode(response.body) as Map;
      if (data['error'] == false) {
        await getCartData();
        await getOldOrders();
        _cartModel = null;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      print("Error in orderCart: $e");
      return false;
    }
  }

  CartModel? get cartModel => _cartModel;

  List<OrderModel>? get oldOrders => _orderList;

  Future<void> increaseQuantity(int bookId) async {
    final url = 'http://yourapiurl.com/api/increase_quantity/';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token your_token',
      },
      body: json.encode({
        'id': bookId,
      }),
    );

    if (response.statusCode == 200) {
      print('Quantity increased');
    } else {
      print('Failed to increase quantity');
    }
  }

  Future<void> decreaseQuantity(int bookId) async {
    final url = 'http://yourapiurl.com/api/decrease_quantity/';
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Token your_token',
      },
      body: json.encode({
        'id': bookId,
      }),
    );

    if (response.statusCode == 200) {
      print('Quantity decreased');
    } else {
      print('Failed to decrease quantity');
    }
  }
}
