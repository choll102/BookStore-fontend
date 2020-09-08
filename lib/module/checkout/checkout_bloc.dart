import 'package:da_muasachonline/base/base_bloc.dart';
import 'package:da_muasachonline/base/base_event.dart';
import 'package:da_muasachonline/data/repo/order_repo.dart';
import 'package:da_muasachonline/event/confirm_oder_event.dart';
import 'package:da_muasachonline/event/pop_event.dart';
import 'package:da_muasachonline/event/update_cart_event.dart';
import 'package:da_muasachonline/shared/model/order.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class CheckoutBloc extends BaseBloc with ChangeNotifier {
  final OrderRepo _orderRepo;

  CheckoutBloc({
    @required OrderRepo orderRepo,
  }) : _orderRepo = orderRepo;

  final _orderSubject = BehaviorSubject<Order>();

  Stream<Order> get orderStream => _orderSubject.stream;
  Sink<Order> get orderSink => _orderSubject.sink;

  @override
  void dispatchEvent(BaseEvent event) {
    switch (event.runtimeType) {
      case UpdateCartEvent:
        handleUpdateCart(event);
        break;
      case ConfirmOrderEvent:
        handleConfirmOrder(event);
        break;
    }
  }

  handleConfirmOrder(event) {
    _orderRepo.confirmOrder().then((isSuccess) {
      processEventSink.add(ShouldPopEvent());
    });
  }

  handleUpdateCart(event) {
    UpdateCartEvent e = event as UpdateCartEvent;

    Observable.fromFuture(_orderRepo.updateOrder(e.product))
        .flatMap((_) => Observable.fromFuture(_orderRepo.getOrderDetail()))
        .listen((order) {
      orderSink.add(order);
    });
  }

  getOrderDetail() {
    Stream<Order>.fromFuture(
      _orderRepo.getOrderDetail(),
    ).listen((order) {
      orderSink.add(order);
    });
  }

  @override
  void dispose() {
    super.dispose();
    print('Kết thúc order');
    _orderSubject.close();
  }
}
