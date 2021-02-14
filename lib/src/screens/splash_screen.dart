import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../controllers/splash_screen_controller.dart';
import '../data_repo/user_repo.dart' as user_repo;

class SplashScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashScreenState();
  }
}

class SplashScreenState extends StateMVC<SplashScreen> {
  SplashScreenController _con;

  SplashScreenState() : super(SplashScreenController()) {
    _con = controller;
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() {
    print(user_repo.currentUser.value.verified);
    _con.progress.addListener(() {
      double progress = 0;
      _con.progress.value.values.forEach((_progress) {
        progress += _progress;
      });
      if (progress == 100 &&
          user_repo.currentUser.value.token != null &&
          user_repo.currentUser.value.verified != '') {
        try {
          Navigator.of(context).pushReplacementNamed('/Tabs', arguments: 2);
        } catch (e) {}
      } else if (progress == 100 &&
          user_repo.currentUser.value.token != null &&
          user_repo.currentUser.value.verified == '') {
        try {
          Navigator.of(context).pushReplacementNamed('/Verify');
        } catch (e) {}
      } else if (user_repo.currentUser.value.token == null) {
        try {
          Navigator.of(context).pushReplacementNamed('/SignIn');
        } catch (e) {}
      }
      /*else if (progress == 100 && user_repo.currentUser.value.auth == null){
         try {
          Navigator.of(context).pushReplacementNamed('/SignIn', arguments: 2);
        } catch (e) {}
      }*/
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'img/facebook.png',
                width: 150,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 50),
              CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(Theme.of(context).hintColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
