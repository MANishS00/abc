import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trial3/widgets/Constrant.dart';

import '../api/cart_api.dart';
import '../service/api_adress.dart';
import '../widgets/drawer.dart';
import 'cart_screen.dart';
class OrderScreens extends StatelessWidget {
  static const routeName = '/order-screens';

  @override
  Widget build(BuildContext context) {
    // Fetch the old orders from CartState
    final cartState = Provider.of<CartState>(context);
    final data = cartState.oldOrders;
    final cart = cartState.cartModel;

    return Scaffold(
      drawer: AppDrawer(),
      body: Scaffold(
        drawer: AppDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text("Order History!!"),
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(15),
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 3),
                    child: ListView.builder(
                      itemCount: data?.length ?? 0,
                      itemBuilder: (ctx, i) {
                        return Card(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: [

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Gmail: ${data![i].email}",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      "Mobile: ${data[i].phone}",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      "Address${data[i].address}",
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    Text(
                                      "Total : ${data[i].cart.total}",
                                      style: kboldtext,
                                    ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
