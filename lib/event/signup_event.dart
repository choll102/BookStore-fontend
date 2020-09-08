import 'package:flutter/widgets.dart';
import 'package:da_muasachonline/base/base_event.dart';

class SignUpEvent extends BaseEvent {
  String displayName;
  String phone;
  String pass;

  SignUpEvent({
    @required this.displayName,
    @required this.phone,
    @required this.pass,
  });
}