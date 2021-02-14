import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../models/product.dart';
import '../data_repo/product_repo.dart';

class ProductController extends ControllerMVC {
  Product product;
  double quantity = 1;
  double total = 0;
  bool loadCart = false;
  GlobalKey<ScaffoldState> scaffoldKey;

  ProductController() {
    this.scaffoldKey = new GlobalKey<ScaffoldState>();
  }

  void listenForProduct({String productId, String message}) async {
    final Stream<Product> stream = await getProduct(productId);
    stream.listen((Product _product) {
      setState(() => product = _product);
    }, onError: (a) {
      print(a);
      scaffoldKey.currentState?.showSnackBar(SnackBar(
        content: Text('verify your internet connection'),
      ));
    }, onDone: () {
      if (message != null) {
        scaffoldKey.currentState?.showSnackBar(SnackBar(
          content: Text(message),
        ));
      }
    });
  }

  Future<void> refreshProduct() async {
    var _id = product.id;
    product = new Product();
    listenForProduct(productId: _id, message: 'product Refreshed Successfuly');
  }
}
