import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/setting.dart';

ValueNotifier<Setting> setting = new ValueNotifier(new Setting());
final navigatorKey = GlobalKey<NavigatorState>();

Future<Setting> initSettings() async {
  Setting _setting;
  final String url = '${GlobalConfiguration().getString('api_url')}settings';
  try {
    final response = await http
        .get(url, headers: {HttpHeaders.contentTypeHeader: 'application/json'});
    if (response.statusCode == 200 &&
        response.headers.containsValue('application/json')) {
      if (json.decode(response.body)['data'] != null) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString(
            'settings', json.encode(json.decode(response.body)['data']));
        _setting = Setting.fromJSON(json.decode(response.body)['data']);
        setting.value = _setting;
        // ignore: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member
        setting.notifyListeners();
      }
    } else {}
  } catch (e) {
    return Setting.fromJSON({});
  }
  return setting.value;
}

Future<void> setDefaultLanguage(String language) async {
  if (language != null) {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language);
  }
}

Future<String> getDefaultLanguage(String defaultLanguage) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  if (prefs.containsKey('language')) {
    defaultLanguage = await prefs.get('language');
  }
  return defaultLanguage;
}
