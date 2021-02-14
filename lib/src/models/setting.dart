import 'package:flutter/cupertino.dart';

class Setting {
  String appName;
  double defaultTax;
  String defaultCurrency;
  ValueNotifier<Locale> mobileLanguage = new ValueNotifier(Locale('en', ''));
  String appVersion;
  bool enableVersion = true;

  Setting();

  Setting.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      appName = jsonMap['app_name'] ?? null ?? '';
      mobileLanguage.value = Locale(jsonMap['mobile_language'] ?? "en", '');
      appVersion = jsonMap['app_version'] ?? '';
      enableVersion =
          jsonMap['enable_version'] == null || jsonMap['enable_version'] == '0'
              ? false
              : true;
      defaultTax = double.tryParse(jsonMap['default_tax']) ?? 0.0;
      defaultCurrency = jsonMap['default_currency'] ?? '';
      //print(appName);
    } catch (e) {
      print(e);
    }
  }

//  ValueNotifier<Locale> initMobileLanguage(String defaultLanguage) {
//    SharedPreferences.getInstance().then((prefs) {
//      return new ValueNotifier(Locale(prefs.get('language') ?? defaultLanguage, ''));
//    });
//    return new ValueNotifier(Locale(defaultLanguage ?? "en", ''));
//  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["app_name"] = appName;
    map["default_tax"] = defaultTax;
    map["default_currency"] = defaultCurrency;
    print(appName);
    return map;
  }
}
