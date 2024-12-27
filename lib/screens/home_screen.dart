import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trial3/screens/search_field.dart';
import 'package:trial3/widgets/rough.dart';
import '../api/book_api.dart';
import '../api/cart_api.dart';
import '../widgets/Buttons.dart';
import '../widgets/drawer.dart';
import '../widgets/single_book.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home-screens';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _init = true;
  bool _isLoading = true;

  @override
  void didChangeDependencies() async {
    if (_init) {
      await Provider.of<CartState>(context, listen: false).getCartData();
      _isLoading =
      await Provider.of<BookState>(context, listen: false).getBooks();
      setState(() {});
    }
    _init = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider
        .of<CartState>(context)
        .cartModel;
    final book = Provider
        .of<BookState>(context)
        .books;

    if (!_isLoading) {
      return Scaffold(
        appBar: AppBar(centerTitle: true),
        body: const Center(child: Text("No data yet")),
      );
    }

    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        actions: const [
          Button()
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => SearchBook()));
                },
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(20)),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Icon(Icons.search),
                      ),
                      Text("Search the Item")
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 3),
                  child: GridView.builder(
                    itemCount: book.length,
                    gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 3 / 3,
                      crossAxisCount: 2,
                      mainAxisExtent: 270,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (ctx, i) {
                      return
                        // rough();
                        SingleBook(
                          id: book[i].id,
                          title: book[i].title,
                          image: book[i].image ?? '',
                          favorite: book[i].favorite,
                          key: ValueKey(book[i].id),
                        );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
