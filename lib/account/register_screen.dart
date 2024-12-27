import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../api/user_api.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const routeName = '/register-screen';

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _form = GlobalKey<FormState>();
  String _username = '';
  String _password = '';
  String _confpassword = '';

  void _registerNow() async {
    var isvalid = _form.currentState?.validate();
    if (!isvalid!) {
      return;
    }
    _form.currentState?.save();
    bool isregister = await Provider.of<UserState>(
      context,
      listen: false,
    ).registerNow(_username, _password);
    if (isregister) {
      Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
    } else {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Already Have registered"),
              actions: [
                // ignore: deprecated_member_use
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text("OK"),
                )
              ],
            );
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          child: Icon(
            Icons.arrow_back,
            size: 30,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
          }),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
              key: _form,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Icon(
                      Icons.person,
                      size: 100,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Username",
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.black, fontSize: 20),
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          validator: (v) {
                            if (v!.isEmpty) {
                              return "Enter your username";
                            }
                            return null;
                          },
                          onSaved: (v) {
                            _username = v!;
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Password",
                              style: TextStyle(fontSize: 20, color: Colors.grey)),
                          TextFormField(
                            style: TextStyle(color: Colors.black),
                            validator: (v) {
                              if (v!.isEmpty) {
                                return "Enter your password";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onChanged: (v) {
                              setState(() {
                                _confpassword = v;
                              });
                            },
                            onSaved: (v) {
                              _password = v!;
                            },
                            obscureText: true,
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Conform Password",
                            style: TextStyle(fontSize: 20, color: Colors.grey)),
                        TextFormField(
                          style: TextStyle(color: Colors.black),
                          validator: (v) {
                            if (_confpassword != v) {
                              return "Confirm dont match";
                            }
                            if (v!.isEmpty) {
                              return "Confirm your password";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onSaved: (v) {
                            _password = v!;
                          },
                          obscureText: true,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0,horizontal: 40),
                      child: ElevatedButton(
                        onPressed: _registerNow,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          padding: EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: Text(
                          "Register Me",
                          style: TextStyle(fontSize: 25, color: Colors.white),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account!",
                          style: TextStyle(fontSize: 20),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacementNamed(LoginScreen.routeName);
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.green, fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
