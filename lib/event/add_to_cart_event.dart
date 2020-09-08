import 'package:da_muasachonline/base/base_event.dart';
import 'package:da_muasachonline/shared/model/product.dart';

class AddToCartEvent extends BaseEvent {
  Product product;
  AddToCartEvent(this.product);
}
