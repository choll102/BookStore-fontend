
import 'package:da_muasachonline/network/book_client.dart';
import 'package:dio/dio.dart';

class ProductService {
  Future<Response> getProductList() {
    return BookClient.instance.dio.get(
      '/product/list',
    );
  }
}