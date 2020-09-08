import 'package:da_muasachonline/base/base_event.dart';
import 'package:da_muasachonline/base/base_widget.dart';
import 'package:da_muasachonline/data/remote/user_service.dart';
import 'package:da_muasachonline/data/repo/user_repo.dart';
import 'package:da_muasachonline/event/signup_event.dart';
import 'package:da_muasachonline/event/signup_fail_event.dart';
import 'package:da_muasachonline/event/signup_sucess_event.dart';
import 'package:da_muasachonline/module/home/home_page.dart';
import 'package:da_muasachonline/module/signup/signup_bloc.dart';
import 'package:da_muasachonline/shared/app_color.dart';
import 'package:da_muasachonline/shared/widget/bloc_listener.dart';
import 'package:da_muasachonline/shared/widget/loading_task.dart';
import 'package:da_muasachonline/shared/widget/normal.button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PageContainer(
      title: 'Đăng Kí',
      di: [
        Provider.value(
          value: UserService(),
        ),
        ProxyProvider<UserService, UserRepo>(
          update: (context, userService, previous) =>
              UserRepo(userService: userService),
        ),
      ],
      bloc: [],
      child: SignUpFormWidget(),
    );
  }
}

class SignUpFormWidget extends StatefulWidget {
  @override
  _SignUpFormWidgetState createState() => _SignUpFormWidgetState();
}

class _SignUpFormWidgetState extends State<SignUpFormWidget> {
  final TextEditingController _txtDisplayNameController =
  TextEditingController();

  final TextEditingController _txtPhoneController = TextEditingController();
  final TextEditingController _txtPassController = TextEditingController();

  handleEvent(BaseEvent event) {
    if (event is SignUpSuccessEvent) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => HomePage()),
        ModalRoute.withName('/home'),
      );
      return;
    }

    if (event is SignUpFailEvent) {
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
      create: (_) => SignUpBloc(userRepo: Provider.of(context)),
      child: Consumer<SignUpBloc>(
        builder: (context, bloc, child) => BlocListener<SignUpBloc>(
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
                      _buildDisplayNameField(bloc),
                      _buildPhoneField(bloc),
                      _buildPassField(bloc),
                      buildSignUpButton(bloc),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDisplayNameField(SignUpBloc bloc) {
    return StreamProvider<String>.value(
      initialData: null,
      value: bloc.displayNameStream,
      child: Consumer<String>(
        builder: (context, msg, child) => Container(
          margin: EdgeInsets.only(bottom: 25),
          child: TextField(
            controller: _txtDisplayNameController,
            onChanged: (text) {
              bloc.displayNameSink.add(text);
            },
            cursorColor: Colors.black,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              icon: Icon(
                Icons.account_box,
                color: AppColor.blue,
              ),
              hintText: 'Nguyễn Văn A',
              errorText: msg,
              labelText: 'Họ Và Tên',
              labelStyle: TextStyle(color: AppColor.blue),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPhoneField(SignUpBloc bloc) {
    return StreamProvider<String>.value(
      initialData: null,
      value: bloc.phoneStream,
      child: Consumer<String>(
        builder: (context, msg, child) => Container(
          margin: EdgeInsets.only(bottom: 15),
          child: TextField(
            controller: _txtPhoneController,
            onChanged: (text) {
              bloc.phoneSink.add(text);
            },
            cursorColor: Colors.black,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
                icon: Icon(
                  Icons.phone,
                  color: AppColor.blue,
                ),
                hintText: '(+84) xxx xxx xxx',
                errorText: msg,
                labelText: 'Số Điện Thoại',
                labelStyle: TextStyle(color: AppColor.blue)),
          ),
        ),
      ),
    );
  }

  Widget _buildPassField(SignUpBloc bloc) {
    return StreamProvider<String>.value(
      initialData: null,
      value: bloc.passStream,
      child: Consumer<String>(
        builder: (context, msg, child) => Container(
          margin: EdgeInsets.only(bottom: 25),
          child: TextField(
            controller: _txtPassController,
            onChanged: (text) {
              bloc.passSink.add(text);
            },
            obscureText: true,
            cursorColor: Colors.black,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              icon: Icon(
                Icons.lock,
                color: AppColor.blue,
              ),
              hintText: '*******',
              errorText: msg,
              labelText: 'Mật Khẩu',
              labelStyle: TextStyle(color: AppColor.blue),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildSignUpButton(SignUpBloc bloc) {
    return StreamProvider<bool>.value(
      initialData: true,
      value: bloc.btnStream,
      child: Consumer<bool>(
        builder: (context, enable, child) => NormalButton(
          title: 'Đăng Kí',
          onPressed: enable
              ? () {
            bloc.event.add(
              SignUpEvent(
                displayName: _txtDisplayNameController.text,
                phone: _txtPhoneController.text,
                pass: _txtPassController.text,
              ),
            );
          }
              : null,
        ),
      ),
    );
  }
}
