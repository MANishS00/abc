import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/book_api.dart';
import '../api/cart_api.dart';
import '../screens/book_detail.dart';
import '../screens/cart_screen.dart';
import '../service/api_adress.dart';

class SingleBook extends StatelessWidget {
  final int id;
  final String title;
  final String image;
  final bool favorite;

  const SingleBook(
      {required Key key,
      required this.id,
      required this.title,
      required this.image,
      required this.favorite})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: GridTile(
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                BookDetails.routeName,
                arguments: id,
              );
            },
            child: Container(
              decoration: BoxDecoration(
                  border: Border.all(width: 1),
                  borderRadius: BorderRadius.circular(20)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  "$baseUrl:8000$image",
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          footer: Container(
            height: 100,
            width: 80,
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: GridTileBar(
              title: Text(title,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              trailing: GestureDetector(
                onTap: (){
                  Provider.of<CartState>(context, listen: false).addToCart(id);
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(child: Icon(Icons.add)),
                ),
              ),
              // leading: IconButton(
              //   onPressed: () {
              //     Provider.of<BookState>(context, listen: false)
              //         .favoriteButton(id);
              //   },
              //   icon: Icon(
              //     favorite ? Icons.star : Icons.star_border,
              //     color: Colors.yellow,
              //   ),
              // ),
            ),
          )),
    );
  }
}
