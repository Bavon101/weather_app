import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:fluttertoast/fluttertoast.dart';

double height(BuildContext context) => MediaQuery.of(context).size.height;
double width(BuildContext context) => MediaQuery.of(context).size.width;

Future<void> showOptionDialog(
    {required BuildContext context,
    required String title,
    required Widget content,
    List<Widget>? actions}) {
  return showPlatformDialog(
    context: context,
    builder: (_) => BasicDialogAlert(
      title: Text(title),
      content: content,
      actions: actions ?? <Widget>[
              BasicDialogAction(
                title: const Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
    ),
  );
}
showToast(String what, {Color? color, bool long = false, Color? backColor}) {
  Fluttertoast.showToast(
    backgroundColor: backColor,
    textColor: color ?? Colors.white,
    msg: what,
    toastLength: long  ? Toast.LENGTH_SHORT : Toast.LENGTH_LONG,
  );
}
