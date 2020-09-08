import 'package:da_muasachonline/shared/app_color.dart';
import 'package:da_muasachonline/shared/style/btn_style.dart';
import 'package:flutter/material.dart';


class NormalButton extends StatelessWidget {
  final VoidCallback onPressed;
 final String title;
  const NormalButton({Key key, this.onPressed, this.title});


  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: 200,
      height: 45,
      child: RaisedButton(

        onPressed: onPressed,
        color:  Colors.blueAccent,
        shape: RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(4.0)
        ),
        child: Text(
          title,
          style: BtnStyle.normal()
          ,
        ),
        ),
      );
  }
}
