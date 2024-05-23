import 'package:flutter/material.dart';
import 'package:muet_app_admin/utils/colors.dart';

class LoadingDialog {
  static void show(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          backgroundColor: backgroundColor,
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularProgressIndicator(color: darkBlueColor,),
              SizedBox(width: 20),
              Text("Uploading..."),
            ],
          ),
        );
      },
    );
  }

  static void hide(BuildContext context) {
    Navigator.pop(context);
  }
}
