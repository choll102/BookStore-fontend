import 'dart:async';

import 'package:da_muasachonline/data/spref/spref.dart';
import 'package:da_muasachonline/shared/constant.dart';
import 'package:da_muasachonline/shared/model/user_data.dart';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:da_muasachonline/data/remote/user_service.dart';


class UserRepo {
UserService _userService;
UserRepo({@required UserService userService}) : _userService = userService;

Future<UserData> signIn(String phone , String pass) async {
  var c = Completer<UserData>();
try {
  var response = await _userService.signIn(phone, pass);
  var userData = UserData.fromJson(response.data['data']);
  if (userData != null) {
    SPref.instance.set(SPrefCache.KEY_TOKEN, userData.token);
    c.complete(userData);
  }
} on DioError catch (e){
  print(e.response.data);
  c.completeError('đăng nhập thất bại');
}
catch(e){
c.completeError(e);
}
return c.future;
  }
Future<UserData> signUp(String displayName, String phone, String pass) async {
  var c = Completer<UserData>();
  try {
    var response = await _userService.signUp(displayName, phone, pass);
    var userData = UserData.fromJson(response.data['data']);
    if (userData != null) {
      SPref.instance.set(SPrefCache.KEY_TOKEN, userData.token);
      c.complete(userData);
    }
  } on DioError catch(e) {
    print(e.response.data);
    c.completeError('Đăng Ký Thất Bại');
  } catch (e){
    c.completeError(e);
  }
  return c.future;
}
}