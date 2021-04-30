import 'package:flutter/material.dart';

// Constants.
import 'package:app/src/commons/constants/sizes.dart';
import 'package:app/src/commons/constants/custom_colors.dart';

class TextFieldCustom extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final Color backgroundColor;
  final double borderRadius;
  final TextInputType inputType;
  final bool obscureText;
  final IconData iconData;
  final Color iconColor;
  final Color hintColor;
  final double fontSize;

  const TextFieldCustom({
    Key key,
    @required this.controller,
    @required this.hint,
    this.backgroundColor = Colors.white,
    this.borderRadius = Sizes.INPUT_BORDER_RADIUS,
    this.inputType = TextInputType.text,
    this.obscureText = false,
    this.iconData,
    this.iconColor = CustomColors.BLUE_TUENTI,
    this.hintColor = Colors.black54,
    this.fontSize = Sizes.FONT_14,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: Sizes.MARGIN_6, top: Sizes.MARGIN_2, bottom: Sizes.MARGIN_2, right: Sizes.MARGIN_16 * 1.2),
      decoration: BoxDecoration(
        color: this.backgroundColor,
        borderRadius: BorderRadius.circular(this.borderRadius),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: Offset(0, 5),
            blurRadius: 5,
          ),
        ]
      ),
      child: Theme(
        child: TextField(
          autocorrect: false,
          keyboardType: this.inputType,
          decoration: InputDecoration(
            prefixIcon: this.iconData == null ? null : Icon(this.iconData),
            focusedBorder: InputBorder.none,
            border: InputBorder.none,
            hintText: this.hint,
            hintStyle: TextStyle(color: this.hintColor),
            contentPadding: EdgeInsets.symmetric(vertical: Sizes.MARGIN_16),
          ),
          style: TextStyle(fontSize: this.fontSize),
          controller: this.controller,
          obscureText: this.obscureText,
        ),
        data: Theme.of(context).copyWith(
          primaryColor: this.iconColor,
        ),
      ),
    );
  }
}
