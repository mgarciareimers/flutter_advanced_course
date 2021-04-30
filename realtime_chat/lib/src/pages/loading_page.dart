import 'package:flutter/material.dart';

// Constants.
import 'package:app/src/commons/constants/custom_colors.dart';

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.GRAY_LIGHT,
      body: Center(
        child: Text('Loading'),
      ),
    );
  }
}
