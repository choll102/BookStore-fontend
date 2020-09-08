import 'package:da_muasachonline/base/base_event.dart';
import 'package:da_muasachonline/shared/model/product.dart';
import 'package:flutter/cupertino.dart';

class RemoveCartEvent extends BaseEvent{
  Product product;
  RemoveCartEvent(this.product);
}