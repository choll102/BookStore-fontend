import 'package:flutter/widgets.dart';
import 'package:da_muasachonline/base/base_event.dart';
 class SignInEvent extends BaseEvent{
   String phone;
   String pass;

   SignInEvent({@required this.phone , @required this.pass});
 }