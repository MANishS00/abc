import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/cart_api.dart';
import '../screens/cart_screen.dart';

class Button extends StatelessWidget {
  const Button({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartState>(context).cartModel;
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(CartScreens.routeName);
      },
      child: Container(
        height: 20,
        width: 50,
        child: Row(
          children: [
            Icon(Icons.shopping_cart),
            Text(
              cart != null ? "${cart.cartBooks.length}" : '',
            ),
          ],
        ),
      ),
    );
  }
}
