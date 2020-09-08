import 'package:da_muasachonline/base/base_bloc.dart';
import 'package:da_muasachonline/base/base_event.dart';
import 'package:da_muasachonline/data/repo/order_repo.dart';
import 'package:da_muasachonline/data/repo/product_repo.dart';
import 'package:da_muasachonline/event/add_to_cart_event.dart';

import 'package:flutter/widgets.dart';
import 'package:da_muasachonline/shared/model/product.dart';
import 'package:da_muasachonline/shared/model/shopping_cart.dart';
import 'package:rxdart/rxdart.dart';


class HomeBloc extends BaseBloc with ChangeNotifier {
  final ProductRepo _productRepo;
  final OrderRepo _orderRepo;

  var _shoppingCart = ShoppingCart();

  static HomeBloc _instance;

  static HomeBloc getInstance({
    @required ProductRepo productRepo,
    @required OrderRepo orderRepo,
  }) {
    if (_instance == null) {
      _instance = HomeBloc._internal(
        productRepo: productRepo,
        orderRepo: orderRepo,
      );
    }
    return _instance;
  }

  HomeBloc._internal({
    @required ProductRepo productRepo,
    @required OrderRepo orderRepo,
  })  : _productRepo = productRepo,
        _orderRepo = orderRepo;

  final _shoppingCardSubject = BehaviorSubject<ShoppingCart>();

  Stream<ShoppingCart> get shoppingCartStream => _shoppingCardSubject.stream;
  Sink<ShoppingCart> get shoppingCartSink => _shoppingCardSubject.sink;

  @override
  void dispatchEvent(BaseEvent event) {
    switch (event.runtimeType) {
      case AddToCartEvent:
        handleAddToCart(event);
        break;
    }
  }

  handleAddToCart(event) {
    AddToCartEvent addToCartEvent = event as AddToCartEvent;
    _orderRepo.addToCart(addToCartEvent.product).then((shoppingCart) {
      _shoppingCart.orderId = shoppingCart.orderId;
      shoppingCartSink.add(shoppingCart);
    });
  }

  getShoppingCartInfo() {
    Stream<ShoppingCart>.fromFuture(_orderRepo.getShoppingCartInfo()).listen(
            (shoppingCart) {
          _shoppingCart = shoppingCart;
          shoppingCartSink.add(shoppingCart);
        }, onError: (err) {
      _shoppingCardSubject.addError(err);
    });
  }

  Stream<List<Product>> getProductList() {
    return Stream<List<Product>>.fromFuture(
      _productRepo.getProductList(),
    );
  }

  @override
  void dispose() {
    super.dispose();
    print("homepage close");
    _shoppingCardSubject.close();
  }
}
