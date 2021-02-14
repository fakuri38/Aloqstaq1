import 'package:AloqStaq/src/models/route_argument.dart';
/*import 'package:AloqStaq/src/screens/brand.dart';
import 'package:AloqStaq/src/screens/brands.dart';
import 'package:AloqStaq/src/screens/cart.dart';
import 'package:AloqStaq/src/screens/categories.dart';
import 'package:AloqStaq/src/screens/category.dart';
import 'package:AloqStaq/src/screens/checkout.dart';
import 'package:AloqStaq/src/screens/checkout_done.dart';*/
import 'package:AloqStaq/src/screens/help.dart';
import 'package:AloqStaq/src/screens/languages.dart';
import 'package:AloqStaq/src/screens/on_boarding.dart';
//import 'package:AloqStaq/src/screens/orders.dart';
import 'package:AloqStaq/src/screens/product.dart';
import 'package:AloqStaq/src/screens/signin.dart';
import 'package:AloqStaq/src/screens/signup.dart';
//import 'package:AloqStaq/src/widgets/signup22.dart';
import 'package:AloqStaq/src/screens/tabs.dart';
import 'package:AloqStaq/src/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:AloqStaq/src/screens/verify.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => OnBoardingWidget());
      case '/SignUp':
        return MaterialPageRoute(builder: (_) => SignUpWidget());
      case '/SignIn':
        return MaterialPageRoute(builder: (_) => SignInWidget());
      /*case '/Categories':
        return MaterialPageRoute(builder: (_) => CategoriesWidget());
      case '/Orders':
        return MaterialPageRoute(builder: (_) => OrdersWidget());
      case '/Brands':
        return MaterialPageRoute(builder: (_) => BrandsWidget());*/
      case '/Splash':
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case '/Verify':
        return MaterialPageRoute(builder: (_) => VerifyWidget());
//      case '/MobileVerification':
//        return MaterialPageRoute(builder: (_) => MobileVerification());
//      case '/MobileVerification2':
//        return MaterialPageRoute(builder: (_) => MobileVerification2());
      case '/Tabs':
        return MaterialPageRoute(
            builder: (_) => TabsWidget(
                  currentTab: args,
                ));
      /*case '/Category':
        return MaterialPageRoute(
            builder: (_) =>
                CategoryWidget(routeArgument: args as RouteArgument));
      case '/Brand':
        return MaterialPageRoute(
            builder: (_) => BrandWidget(routeArgument: args as RouteArgument));*/
      case '/Product':
        return MaterialPageRoute(
            builder: (_) =>
                ProductWidget(routeArgument: args as RouteArgument));
//      case '/Food':
//        return MaterialPageRoute(
//            builder: (_) => FoodWidget(
//              routeArgument: args as RouteArgument,
//            ));
      /*case '/Cart':
        return MaterialPageRoute(builder: (_) => CartWidget());*/
      /*case '/Checkout':
        return MaterialPageRoute(builder: (_) => CheckoutWidget());
      case '/CheckoutDone':
        return MaterialPageRoute(builder: (_) => CheckoutDoneWidget());*/
      case '/Help':
        return MaterialPageRoute(builder: (_) => HelpWidget());
      case '/Languages':
        return MaterialPageRoute(builder: (_) => LanguagesWidget());
//      case '/second':
//      // Validation of correct data type
//        if (args is String) {
//          return MaterialPageRoute(
//            builder: (_) => SecondPage(
//              data: args,
//            ),
//          );
//        }
//        // If args is not of the correct type, return an error page.
//        // You can also throw an exception while in development.
//        return _errorRoute();
      default:
        // If there is no such named route in the switch statement, e.g. /third
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Error'),
        ),
        body: Center(
          child: Text('ERROR'),
        ),
      );
    });
  }
}