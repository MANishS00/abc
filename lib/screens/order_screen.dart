import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/cart_api.dart';
import '../widgets/Buttons.dart';
import 'cart_screen.dart';
import 'order_history.dart';

class OrderNew extends StatefulWidget {
  static const routeName = '/order-now-screens';

  @override
  _OrderNewState createState() => _OrderNewState();
}

class _OrderNewState extends State<OrderNew> {
  bool _init = true;

  @override
  void didChangeDependencies() async {
    if (_init) {
      Provider.of<CartState>(context).getCartData();
      Provider.of<CartState>(context).cartModel;
      setState(() {});
    }
    _init = false;
    super.didChangeDependencies();
  }

  final _form = GlobalKey<FormState>();
  String _email = '';
  String _phone = '';
  String _address = '';

  void _orderNew() async {
    var isValid = _form.currentState?.validate();
    if (!isValid!) {
      return;
    }
    _form.currentState?.save();
    final cart = Provider.of<CartState>(context, listen: false).cartModel;
    bool order = await Provider.of<CartState>(context, listen: false)
        .orderCart(cart!.id, _address, _email, _phone);
    if (order) {
      Navigator.of(context).pushNamed(OrderScreens.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartState>(context).cartModel;
    return Scaffold(
        body: Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text("Order Now!!"),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(),
          padding: EdgeInsets.all(15),
          child: Column(children: <Widget>[
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Form(
                    key: _form,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          decoration: InputDecoration(hintText: "Email"),
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "Enter Your Email";
                            }
                            return null;
                          },
                          onSaved: (v) {
                            _email = v!;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(hintText: "Phone"),
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "Enter Your Phone Number";
                            }
                            return null;
                          },
                          onSaved: (v) {
                            _phone = v!;
                          },
                        ),
                        TextFormField(
                          decoration: InputDecoration(hintText: "Address"),
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "Enter Your Address";
                            }
                            return null;
                          },
                          onSaved: (v) {
                            _address = v!;
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _orderNew();
                          },
                          child: Text("Order"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(CartScreens.routeName);
                          },
                          child: Text("Edit Cart"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    ));
  }
}

/*

Padding(
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Form(
              key: _form,
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(hintText: "Email"),
                    validator: (v) {
                      if (v.isEmpty) {
                        return "Enter Your Email";
                      }
                      return null;
                    },
                    onSaved: (v) {
                      _email = v;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Phone"),
                    validator: (v) {
                      if (v.isEmpty) {
                        return "Enter Your Phone Number";
                      }
                      return null;
                    },
                    onSaved: (v) {
                      _phone = v;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(hintText: "Address"),
                    validator: (v) {
                      if (v.isEmpty) {
                        return "Enter Your Address";
                      }
                      return null;
                    },
                    onSaved: (v) {
                      _address = v;
                    },
                  ),
                  Row(
                    children: [
                      RaisedButton(
                        onPressed: () {
                          _orderNew();
                        },
                        child: Text("Order"),
                      ),
                      RaisedButton(
                        onPressed: () {
                          Navigator.of(context).pushNamed(CartScreens.routeName);
                        },
                        child: Text("Edit Cart"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

*/
