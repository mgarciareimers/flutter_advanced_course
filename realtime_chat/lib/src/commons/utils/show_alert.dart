import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

// Constants.
import 'package:app/src/commons/constants/custom_colors.dart';

showAlert(BuildContext context, String title, String message, String actionText) {
  if (Platform.isIOS) {
    return showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          CupertinoDialogAction(
            child: Text(actionText),
            onPressed: () => Navigator.pop(context),
          )
        ],
      ),
    );
  }

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        MaterialButton(
          child: Text(actionText),
          onPressed: () => Navigator.pop(context),
          elevation: 5,
          textColor: CustomColors.BLUE_TUENTI,
        )
      ],
    ),
  );
}