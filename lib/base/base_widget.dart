import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:da_muasachonline/shared/app_color.dart';
import 'package:provider/single_child_widget.dart';

class PageContainer extends StatelessWidget {
  final String title;
  final Widget child;

  final List<SingleChildWidget> bloc;
  final List<SingleChildWidget> di;
  final List<Widget> actions;

  PageContainer({this.title, this.bloc, this.di, this.actions, this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ...di,
        ...bloc,
      ],
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
            actions: actions,
          ),
          body: child,
      ),
    );
  }
}

class NavigatorProvider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[],
      ),
    );
  }
}




