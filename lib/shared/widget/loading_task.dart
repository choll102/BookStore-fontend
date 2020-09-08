import 'package:da_muasachonline/base/base_bloc.dart';
import 'package:da_muasachonline/shared/widget/scale_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class LoadingTask extends StatelessWidget {
  final Widget child;
  final BaseBloc bloc;

  LoadingTask({
    @required this.child,
    @required this.bloc,
  });

  @override
  Widget build(BuildContext context) {
    return StreamProvider<bool>.value(
      value: bloc.loadingStream,
      initialData: false,
      child: Stack(
        children: <Widget>[
          child,
          Consumer<bool>(
            builder: (context, isLoading, child) => Center(
              child: isLoading
                  ? ScaleAnimation(
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: new BoxDecoration(
//                    color: Colors.white,
                    borderRadius: BorderRadius.all(
                      Radius.circular(10),
                    ),
                  ),
                  child: SpinKitPouringHourglass(
                    color: Colors.green,
                  ),
                ),
              )
                  : Container(),
            ),
          ),
        ],
      ),
    );
  }
}
