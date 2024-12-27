import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trial3/widgets/Buttons.dart';
import 'package:trial3/widgets/Constrant.dart';
import 'package:http/http.dart' as http;

import '../api/cart_api.dart';
import '../service/api_adress.dart';
import 'home_screen.dart';
import 'order_screen.dart';

class CartScreens extends StatefulWidget {
  static const routeName = '/cart-screens';

  @override
  State<CartScreens> createState() => _CartScreensState();
}

class _CartScreensState extends State<CartScreens> {
  @override
  Widget build(BuildContext context) {

    final cart = Provider.of<CartState>(context).cartModel;
    final data = Provider.of<CartState>(context).oldOrders;

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

    if (cart == null)
      return Scaffold(
        appBar: AppBar(
          title: Text("No Cart"),
        ),
        body: Center(
          child: Text("No Card Found"),
        ),
      );
    else
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text("Cart Store!!"),
          actions: [ElevatedButton(
            onPressed: cart.cartBooks.length <= 0
                ? null
                : () async {
              bool isdelete = await Provider.of<CartState>(
                  context,
                  listen: false)
                  .deleteCart(cart.id);
              if (isdelete) {
                Navigator.of(context)
                    .pushReplacementNamed(HomeScreen.routeName);
              }
            },
            child: Text("Delate All"),
          ),],
        ),
        body: SafeArea(
          child: Stack(children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                Text("Sub Total: ${cart.total}",style: kboldtext,),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: ListView.builder(
                      itemCount: cart.cartBooks.length,
                      itemBuilder: (ctx, i) {
                        var item = cart.cartBooks[i];
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Image.network(
                                  "$baseUrl:8000${item.books[0].image}",
                                  fit: BoxFit.cover,
                                  height: 80,
                                  width: 80,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18.0),
                                      child: Text(item.books[0].title,
                                          style: kboldtext),
                                    ),
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.remove), onPressed: () {  },

                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  border: Border.all(
                                                      color: Colors.grey)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(12.0),
                                                child: Text("${item.quantity}"),
                                              )),
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.add),
                                          onPressed: () {
                                            increaseQuantity(i);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          Provider.of<CartState>(context,
                                                  listen: false)
                                              .deleteCartBook(item.id);
                                        },
                                        icon: Icon(Icons.close)),
                                    SizedBox(height: 20),
                                    Text("Price :${item.price}",
                                        style: kboldtext),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ]),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: SizedBox(
                  height: 80,
                  width: 350,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    onPressed: cart.cartBooks.length <= 0
                        ? null
                        : () {
                            Navigator.of(context).pushNamed(OrderNew.routeName);
                          },
                    child: Text("Let's Buy",style: TextStyle(color: Colors.white,fontSize: 20),),
                  ),
                ),
              ),
            ),
          ]),
        ),
      );
  }
}

/*
ListView.builder(
                  itemCount: cart.cartbooks.length,
                  itemBuilder: (ctx, i) {
                    var item = cart.cartbooks[i];
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item.book[0].title),
                                Text("Price : ${item.price}"),
                                Text("quantity : ${item.quantity}"),
                              ],
                            ),
                            RaisedButton(
                              color: Colors.greenAccent,
                              onPressed: () {
                                Provider.of<CartState>(context, listen: false)
                                    .deletecartbook(item.id);
                              },
                              child: Text("Delate"),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                ),
*/
