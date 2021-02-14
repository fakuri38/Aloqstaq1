import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../models/user.dart';
import '../loader/helper.dart';
import '../data_repo/user_repo.dart' as repo;
import 'package:shared_preferences/shared_preferences.dart';

class UserController extends ControllerMVC {
  User user = new User();
  bool hidepass = true;
  bool loading = false;
  OverlayEntry loader;
  GlobalKey<FormState> loginForm;
  GlobalKey<ScaffoldState> scaffoldKey;

  UserController() {
    loginForm = new GlobalKey<FormState>();
    loader = Helper.overlayLoader(context);
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  void register() async {
    FocusScope.of(context).unfocus();
    if (loginForm.currentState.validate()) {
      loginForm.currentState.save();
      Overlay.of(context).insert(loader);
      repo.register(user).then((value) {
        if (value != null) {
          Navigator.of(scaffoldKey.currentContext)
              .pushReplacementNamed('/Tabs', arguments: 2);
        } else {
          scaffoldKey?.currentState?.showSnackBar(SnackBar(
            content: Text('wrong email or password'),
          ));
        }
      }).catchError((e) {
        loader.remove();
        scaffoldKey?.currentState?.showSnackBar(SnackBar(
          content: Text('this email account exists'),
        ));
      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
    }
  }

  void login() async {
    print(repo.currentUser.value.verified);
    FocusScope.of(context).unfocus();
    if (loginForm.currentState.validate()) {
      loginForm.currentState.save();
      Overlay.of(context).insert(loader);
      repo.login(user).then((value) {
        print('Verified' + value.verified);
        if (value != null && value.token != null && value.verified != '') {
          Navigator.of(scaffoldKey.currentContext)
              .pushReplacementNamed('/Tabs', arguments: 2);
          print(value.verified);
          print(value != null && value.token != null);
        } else if (value.token != null && value.verified == '') {
          Navigator.of(scaffoldKey.currentContext)
              .pushReplacementNamed('/Verify');
        } else {
          scaffoldKey?.currentState?.showSnackBar(SnackBar(
            content: Text('wrong_email_or_password'),
          ));
        }
      }).catchError((e) {
        loader.remove();
        scaffoldKey?.currentState?.showSnackBar(SnackBar(
          content: Text('this account does not exist'),
        ));
      }).whenComplete(() {
        Helper.hideLoader(loader);
      });
    }
  }

  void home() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('current_user')) {
      Navigator.of(scaffoldKey.currentContext)
          .pushReplacementNamed('/Tabs', arguments: 2);
    }
  }
}
