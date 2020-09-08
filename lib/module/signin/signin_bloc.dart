import 'dart:async';
import 'package:da_muasachonline/base/base_bloc.dart';
import 'package:da_muasachonline/event/signin_fail_event.dart';
import 'package:da_muasachonline/event/signin_sucess_event.dart';
import 'package:da_muasachonline/event/signup_event.dart';
import 'package:da_muasachonline/shared/validation.dart';
import 'package:flutter/widgets.dart';
import 'package:da_muasachonline/base/base_event.dart';
import 'package:da_muasachonline/data/repo/user_repo.dart';
import 'package:da_muasachonline/event/singin_event.dart';
import 'package:rxdart/rxdart.dart';

class SignInBloc extends BaseBloc with ChangeNotifier {
  final _phoneSubject = BehaviorSubject<String>();
  final _passSubject = BehaviorSubject<String>();
  final _btnSubject = BehaviorSubject<bool>();

   UserRepo _userRepo;
  SignInBloc({@required UserRepo userRepo}) {
    _userRepo = userRepo;
validateForm();

  }

  var phoneVlidation = StreamTransformer<String, String>.fromHandlers(
    handleData: (phone, sink){
      if (Validation.isPhoneValid(phone)) {
      sink.add(null);
      return;
      }
      sink.add('số điện thoại không hợp lệ');
    }
  );
  var passVlidation = StreamTransformer<String, String>.fromHandlers(
      handleData: (pass, sink){
        if (Validation.isPassValid(pass)) {
          sink.add(null);
          return;
        }
        sink.add('mật khẩu quá ngắn');
      }
  );

  Stream<String> get phoneStream =>
      _phoneSubject.stream.transform(phoneVlidation);
  Sink<String> get phoneSink => _phoneSubject.sink;

  Stream<String> get passStream =>
      _passSubject.stream.transform(passVlidation);
  Sink<String> get passSink => _passSubject.sink;

  Stream<bool> get btnStream =>
      _btnSubject.stream;
  Sink<bool> get btnSink => _btnSubject.sink;

  validateForm() {
    Observable.combineLatest2(
      _phoneSubject,
      _passSubject,
          (phone, pass) {
        return Validation.isPhoneValid(phone) && Validation.isPassValid(pass);
      },
    ).listen((enable) {
      btnSink.add(enable);
    });
  }

  @override
  void dispatchEvent(BaseEvent event) {
   switch(event.runtimeType){
     case SignInEvent:
       handleSignIn(event);
       break;
     case SignUpEvent:

       break;
   }
  }

  handleSignIn(event) {
    btnSink.add(false); //Khi bắt đầu call api thì disable nút sign-in
    loadingSink.add(true); // show loading

    Future.delayed(Duration(seconds: 4), () {
      SignInEvent e = event as SignInEvent;
      _userRepo.signIn(e.phone, e.pass).then(
            (userData) {
          processEventSink.add(SignInSuccessEvent(userData));
        },
        onError: (e) {
          print(e);
          btnSink.add(true); //Khi có kết quả thì enable nút sign-in trở lại
          loadingSink.add(false); // hide loading
          processEventSink
              .add(SignInFailEvent(e.toString())); // thông báo kết quả
        },
      );
    });
  }


  @override
  void dispose() {
//     TODO: implement dispose

    print("singin close");

    _phoneSubject.close();
    _passSubject.close();
    _btnSubject.close();

  }

}


