import 'dart:async';
import 'package:da_muasachonline/base/base_event.dart';
import 'package:da_muasachonline/data/remote/user_service.dart';
import 'package:da_muasachonline/data/repo/user_repo.dart';
import 'package:da_muasachonline/event/signin_fail_event.dart';
import 'package:da_muasachonline/event/signin_sucess_event.dart';
import 'package:da_muasachonline/event/singin_event.dart';
import 'package:da_muasachonline/module/signin/signin_bloc.dart';
import 'package:da_muasachonline/shared/app_color.dart';
import 'package:da_muasachonline/shared/widget/bloc_listener.dart';
import 'package:da_muasachonline/shared/widget/loading_task.dart';
import 'package:da_muasachonline/shared/widget/normal.button.dart';
import 'package:flutter/material.dart';
import 'package:da_muasachonline/base/base_widget.dart';
import 'package:provider/provider.dart';

class SignInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {


        return PageContainer(
          title: 'Đăng Nhập',
          di: [
            Provider.value
              (
              value: UserService(),
            ),
            ProxyProvider<UserService, UserRepo>(
              update: (context, userService, previous) =>
                   UserRepo(userService: userService),
            ),
          ],
          bloc: [],
          child: Container(

            child: SignInFormWidget(),
          ),
        );

  }
}
class SignInFormWidget extends StatefulWidget {
  @override
  _SignInFormWidgetState createState() => _SignInFormWidgetState();
}

class _SignInFormWidgetState extends State<SignInFormWidget> {
  final TextEditingController _txtPhoneController = TextEditingController();

  final TextEditingController _txtPassController = TextEditingController();

  handleEvent(BaseEvent event) {
    if (event is SignInSuccessEvent) {
      Navigator.pushReplacementNamed(context, '/home');
      return;
    }

    if (event is SignInFailEvent) {
      final snackBar = SnackBar(
        content: Text(event.errMessage),
        backgroundColor: Colors.red,
      );
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SignInBloc(userRepo: Provider.of(context)),
      child: Consumer<SignInBloc>(
        builder: (context, bloc, child) {
          return BlocListener<SignInBloc>(
            listener: handleEvent,
            child: LoadingTask(
              bloc: bloc,
              child: Container(
                padding: EdgeInsets.all(25),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        _buildPhoneField(bloc),
                        _buildPassField(bloc),
                        buildSignInButton(bloc),
                        _buildFooter(context),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildSignInButton(SignInBloc bloc){
    return StreamProvider<bool>.value(
      initialData: false,
      value: bloc.btnStream,
      child: Consumer<bool>(
        builder: (context, enable, child) =>  Container(
          margin: EdgeInsets.only(top: 5),
          child: NormalButton(
            title: 'Đăng Nhập',
            onPressed: enable ? (){
              bloc.event.add(SignInEvent(
                phone: _txtPhoneController.text,
                pass: _txtPassController.text,
              ),
              );
            } : null,
          ),
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context){
    return GestureDetector(
      onTap: (){},
      child: Container(
        margin: EdgeInsets.only(top: 20),
        padding: EdgeInsets.all(10),
        child: FlatButton(
          onPressed: (){
            Navigator.pushNamed(context, '/sign-up');
          },
          shape: RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(4.0)
          ),
          child: Text(
            'Đăng Ký Tài Khoản',
                style: TextStyle(color: AppColor.blue, fontSize: 17),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneField(SignInBloc bloc){
    return StreamProvider<String>.value(
      initialData: null,
      value: bloc.phoneStream,
      child: Consumer<String>(
        builder: (context, msg, child) => Container(
          margin: EdgeInsets.only(bottom: 15),
            child: TextField(
              controller: _txtPhoneController,
              onChanged: (text){
               bloc.phoneSink.add(text);

              },
              cursorColor: Colors.black38,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.phone,
                    color: AppColor.blue,
                  ),
                  hintText: '(+84) xxx xxx xxx',
                  errorText: msg,
                  labelText: 'Số Điện Thoại',
                labelStyle: TextStyle(color: AppColor.blue)
              ),
            ),
          ),
      ),
    );
//    );
  }

  Widget _buildPassField(SignInBloc bloc){
    return StreamProvider<String>.value(
      initialData: null,
      value: bloc.passStream,
      child: Consumer<String>(
        builder: (context, msg, child) => Container(
          margin: EdgeInsets.only(bottom: 25),
          child: TextField(
            controller: _txtPassController,
            onChanged: (text){
             bloc.passSink.add(text);
            },
            obscureText: true,
            cursorColor: Colors.black38,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.lock,
                  color: AppColor.blue,
                ),
                hintText: '*******',
                errorText: msg,
                labelText: 'Mật Khẩu'
            ),
          ),
        ),
      ),
    );
  }
}


