import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trial3/widgets/Buttons.dart';

import '../api/book_api.dart';
import '../api/cart_api.dart';
import '../service/api_adress.dart';
import '../widgets/drawer.dart';
import 'cart_screen.dart';

class BookDetails extends StatelessWidget {
  static const routeName = '/product-details-screen';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments as int?;

    if (id == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Error"),
        ),
        body: const Center(
          child: Text("Invalid Item ID."),
        ),
      );
    }

    final book = Provider.of<BookState>(context).singleBook(id);
    final cart = Provider.of<CartState>(context).cartModel;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text("Item Details"),
        actions: [Button()],
      ),
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: [
              Image.network(
                "$baseUrl:8000${book.image}",
                fit: BoxFit.cover,
                height: 300,
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "${book.title}",
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      book.description ?? "No description available",
                      textAlign: TextAlign.justify,
                      style: const TextStyle(fontSize: 16),
                    ),
                    Row(
                      children: [
                        Text("Selling Prise: ",style: TextStyle(fontSize: 20),),
                        Text(
                          " \$${book.sellingPrice}",
                          style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
        Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: GestureDetector(
                onTap: () {
                  Provider.of<CartState>(context, listen: false).addToCart(id);
                  Navigator.of(context).pushNamed(CartScreens.routeName);
                },
                child: Container(
                  height: 80,
                  width: 350,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Text(
                        "Add to Cart",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      )
                    ],
                  ),
                ),
              ),
            ))
      ]),
    );
  }
}
