import 'package:app/src/commons/constants/sizes.dart';
import 'package:flutter/material.dart';

// Constants.
import 'package:app/src/commons/constants/custom_colors.dart';

class ElevatedButtonCustom extends StatelessWidget {
  final Function(BuildContext context) onPressed;
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final double fontSize;

  const ElevatedButtonCustom({
    Key key,
    @required this.onPressed,
    @required this.text,
    this.backgroundColor = CustomColors.BLUE_TUENTI,
    this.textColor = Colors.white,
    this.fontSize = Sizes.FONT_14,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ElevatedButton(
        onPressed: () => this.onPressed(context),
        style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(2.0),
          backgroundColor: MaterialStateProperty.resolveWith<Color>((states) => this.backgroundColor),
          shape: MaterialStateProperty.resolveWith<OutlinedBorder>((states) => StadiumBorder()),
        ),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: Sizes.MARGIN_12 * 1.4),
          child: Center(
            child: Text(
              this.text,
              style: TextStyle(
                color: this.textColor,
                fontSize: this.fontSize,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
