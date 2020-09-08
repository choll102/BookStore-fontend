import 'dart:async';
import 'package:dio/dio.dart';
import 'package:da_muasachonline/data/remote/product_service.dart';
import 'package:da_muasachonline/shared/model/product.dart';
import 'package:da_muasachonline/shared/model/rest_error.dart';
import 'package:flutter/cupertino.dart';

class ProductRepo {
  ProductService _productService;

  ProductRepo({@required ProductService productService})
      : _productService = productService;

  Future<List<Product>> getProductList() async {
    var c = Completer<List<Product>>();
    try {
      var response = await _productService.getProductList();
      var productList = Product.parseProductList(response.data);
      c.complete(productList);
    } on DioError {
      c.completeError(RestError.fromData('Không có dữ liệu'));
    } catch (e) {
      c.completeError(e);
    }
    return c.future;
  }
}
