import 'package:AloqStaq/config/ui_icons.dart';
import 'package:AloqStaq/src/models/user.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../controllers/profile_controller.dart';
import '../data_repo/user_repo.dart';

class DrawerWidget extends StatefulWidget {
  User _user = new User.init().getCurrentUser();
  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends StateMVC<DrawerWidget> {
  //ProfileController _con;

  _DrawerWidgetState() : super(ProfileController()) {}
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Drawer(
      child: ListView(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed('/Tabs', arguments: 1);
            },
            child: currentUser.value.token != null
                ? UserAccountsDrawerHeader(
                    decoration: BoxDecoration(
                      color: Theme.of(context).hintColor.withOpacity(0.1),
                    ),
                    accountName: Text(
                      currentUser.value.username,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    accountEmail: Text(
                      currentUser.value.email,
                      style: Theme.of(context).textTheme.caption,
                    ),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Theme.of(context).accentColor,
                      backgroundImage: AssetImage('img/facebook.png'),
                    ),
                  )
                : Container(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                    decoration: BoxDecoration(
                      color: Theme.of(context).hintColor.withOpacity(0.1),
                    ),
                    child: Row(
                      children: <Widget>[
                        Icon(
                          Icons.person,
                          size: 32,
                          color: Theme.of(context).accentColor.withOpacity(1),
                        ),
                        SizedBox(width: 30),
                        Text(
                          'Guest',
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ],
                    ),
                  ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Tabs', arguments: 2);
            },
            leading: Icon(
              UiIcons.home,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Home",
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Tabs', arguments: 0);
            },
            leading: Icon(
              UiIcons.bell,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Notifications",
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Orders', arguments: 0);
            },
            leading: Icon(
              UiIcons.inbox,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "My Orders",
              style: Theme.of(context).textTheme.subhead,
            ),
            trailing: Chip(
              padding: EdgeInsets.symmetric(horizontal: 5),
              backgroundColor: Colors.transparent,
              shape: StadiumBorder(
                  side: BorderSide(color: Theme.of(context).focusColor)),
              label: Text(
                '8',
                style: TextStyle(color: Theme.of(context).focusColor),
              ),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Tabs', arguments: 4);
            },
            leading: Icon(
              UiIcons.heart,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Wish List",
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          ListTile(
            dense: true,
            title: Text(
              "Products",
              style: Theme.of(context).textTheme.body1,
            ),
            trailing: Icon(
              Icons.remove,
              color: Theme.of(context).focusColor.withOpacity(0.3),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Categories');
            },
            leading: Icon(
              UiIcons.folder_1,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Categories",
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Brands');
            },
            leading: Icon(
              UiIcons.folder_1,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Brands",
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          ListTile(
            dense: true,
            title: Text(
              "Application Preferences",
              style: Theme.of(context).textTheme.body1,
            ),
            trailing: Icon(
              Icons.remove,
              color: Theme.of(context).focusColor.withOpacity(0.3),
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Help');
            },
            leading: Icon(
              UiIcons.information,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Help & Support",
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Tabs', arguments: 1);
            },
            leading: Icon(
              UiIcons.settings_1,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Settings",
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).pushNamed('/Languages');
            },
            leading: Icon(
              UiIcons.planet_earth,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              "Languages",
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          ListTile(
            onTap: () {
              if (currentUser.value.token != null) {
                logout().then((value) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/Tabs', (Route<dynamic> route) => false,
                      arguments: 2);
                });
              } else {
                Navigator.of(context).pushNamed('/SignIn');
              }
            },
            leading: Icon(
              UiIcons.upload,
              color: Theme.of(context).focusColor.withOpacity(1),
            ),
            title: Text(
              currentUser.value.token != null ? 'Logout' : 'Login/Register',
              style: Theme.of(context).textTheme.subhead,
            ),
          ),
          ListTile(
            dense: true,
            title: Text(
              "Version 0.0.1",
              style: Theme.of(context).textTheme.body1,
            ),
            trailing: Icon(
              Icons.remove,
              color: Theme.of(context).focusColor.withOpacity(0.3),
            ),
          ),
        ],
      ),
    );
  }
}
