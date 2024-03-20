
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Ui {
  static showConfirmationAlert(BuildContext context,  VoidCallback? onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text("Are you sure to delete?"),
          actions: <Widget>[
            TextButton(
              child: const Text("NO"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),

            TextButton(
              child: const Text("YES"),
              onPressed: () {
                Navigator.of(context).pop();
                if(onConfirm!=null) {
                  onConfirm();
                }
              },
            ),
          ],
        );
      },
    );
  }

  static Future<void> showLoadingDialog(
      BuildContext context) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {

          return WillPopScope(
              onWillPop: () async => false,
              child: Container(color: Colors.white54.withAlpha(50),
                child: const Center(
                  child: CircularProgressIndicator(color: Colors.brown,),
                ),
              ));
        });
  }
}