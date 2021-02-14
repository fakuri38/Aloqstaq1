import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
//import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../data_repo/setting_repo.dart' as settingRepo;
import '../data_repo/user_repo.dart' as userRepo;

class SplashScreenController extends ControllerMVC {
  ValueNotifier<Map<String, double>> progress = new ValueNotifier(new Map());
  GlobalKey<ScaffoldState> scaffoldKey;

  SplashScreenController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
    // Should define these variables before the app loaded
    progress.value = {"Setting": 0, "User": 0};
  }

  @override
  void initState() {
    super.initState();
    settingRepo.setting.addListener(() {
      print(settingRepo.setting.value.appName);
      if (settingRepo.setting.value.appName != null) {
        progress.value["Setting"] = 41;
        // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
        progress?.notifyListeners();
      }
    });

    userRepo.currentUser.addListener(() async {
      if (userRepo.currentUser.value.token != null) {
        progress.value["User"] = 59;
        /*await new Future.delayed(const Duration(seconds: 5));
        progress.value["Setting"] = 41;*/
        // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
        progress?.notifyListeners();
      }
    });
    Timer(Duration(seconds: 20), () {
      scaffoldKey?.currentState?.showSnackBar(SnackBar(
        content: Text('verify your internet connection'),
      ));
    });
  }
}
