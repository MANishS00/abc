import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../account/login_screen.dart';
import '../screens/favorite_screen.dart';
import '../screens/home_screen.dart';
import '../screens/order_history.dart';

class AppDrawer extends StatefulWidget {
  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [

          Padding(
            padding: const EdgeInsets.symmetric(vertical: 100.0),
            child: SizedBox(
              height: 490,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      CustomListTile(
                        Icons.home,
                        'Home',
                            () => Navigator.of(context)
                            .pushReplacementNamed(HomeScreen.routeName),
                      ),
                      CustomListTile(
                        Icons.star,
                        'Favorites',
                            () => Navigator.of(context)
                            .pushReplacementNamed(FavoriteScreen.routeName),
                      ),
                      CustomListTile(
                        Icons.history,
                        'Orders History',
                            () => Navigator.of(context)
                            .pushReplacementNamed(OrderScreens.routeName),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.all(1),
                    child: CustomListTile(
                      Icons.logout,
                      'Logout',
                      _logout,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class CustomListTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onTap;

  CustomListTile(this.icon, this.text, this.onTap);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey.shade400),
          ),
        ),
        child: InkWell(
          splashColor: Colors.orangeAccent,
          onTap: () => onTap(),
          child: Container(
            height: 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon),
                    Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        text,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Icon(Icons.arrow_right),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
