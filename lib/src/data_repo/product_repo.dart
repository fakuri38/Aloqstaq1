import 'dart:convert';
import 'dart:io';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../loader/helper.dart';
import '../models/product.dart';
import '../models/review.dart';
import '../models/user.dart';
import '../data_repo/user_repo.dart' as userRepo;
import '../models/filter.dart';

Future<Stream<Product>> getProduct(String productId) async {
  Uri uri = Helper.getUri('api/products/$productId');
  uri = uri.replace(queryParameters: {
    'with':
        'market;category;options;optionGroups;productReviews;productReviews.user'
  });
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));
    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .map((data) {
      return Product.fromJSON(data);
    });
  } catch (e) {
    //print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Product.fromJSON({}));
  }
}

Future<Stream<Product>> getProductsByCategory(categoryId) async {
  Uri uri = Helper.getUri('api/products');
  Map<String, dynamic> _queryParams = {};
  SharedPreferences prefs = await SharedPreferences.getInstance();
  Filter filter =
      Filter.fromJSON(json.decode(prefs.getString('filter') ?? '{}'));
  _queryParams['with'] = 'market';
  _queryParams['search'] = 'category_id:$categoryId';
  _queryParams['searchFields'] = 'category_id:=';

  _queryParams = filter.toQuery(oldQuery: _queryParams);
  uri = uri.replace(queryParameters: _queryParams);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) {
      return Product.fromJSON(data);
    });
  } catch (e) {
    //print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Product.fromJSON({}));
  }
}

Future<Stream<Product>> getProductsOfMarket(String marketId,
    {List<String> categories}) async {
  Uri uri = Helper.getUri('api/products/categories');
  Map<String, dynamic> query = {
    'with': 'market;category;options;productReviews',
    'search': 'market_id:$marketId',
    'searchFields': 'market_id:=',
  };

  if (categories != null && categories.isNotEmpty) {
    query['categories[]'] = categories;
  }
  uri = uri.replace(queryParameters: query);
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) {
      return Product.fromJSON(data);
    });
  } catch (e) {
    //print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Product.fromJSON({}));
  }
}

Future<Stream<Product>> getTrendingProductsOfMarket(String marketId) async {
  Uri uri = Helper.getUri('api/products');
  uri = uri.replace(queryParameters: {
    'with': 'category;options;productReviews',
    'search': 'market_id:$marketId;featured:1',
    'searchFields': 'market_id:=;featured:=',
    'searchJoin': 'and',
  });
  // TODO Trending products only
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) {
      return Product.fromJSON(data);
    });
  } catch (e) {
    //print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Product.fromJSON({}));
  }
}

Future<Stream<Product>> getFeaturedProductsOfMarket(String marketId) async {
  Uri uri = Helper.getUri('api/products');
  uri = uri.replace(queryParameters: {
    'with': 'category;options;productReviews',
    'search': 'market_id:$marketId;featured:1',
    'searchFields': 'market_id:=;featured:=',
    'searchJoin': 'and',
  });
  try {
    final client = new http.Client();
    final streamedRest = await client.send(http.Request('get', uri));

    return streamedRest.stream
        .transform(utf8.decoder)
        .transform(json.decoder)
        .map((data) => Helper.getData(data))
        .expand((data) => (data as List))
        .map((data) {
      return Product.fromJSON(data);
    });
  } catch (e) {
    //print(CustomTrace(StackTrace.current, message: uri.toString()).toString());
    return new Stream.value(new Product.fromJSON({}));
  }
}
