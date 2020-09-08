import 'package:da_muasachonline/base/base_event.dart';
import 'package:da_muasachonline/shared/model/product.dart';
import 'package:flutter/cupertino.dart';

class UpdateCartEvent extends BaseEvent {
  Product product;
  UpdateCartEvent(this.product);
}