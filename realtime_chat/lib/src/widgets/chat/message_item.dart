import 'package:flutter/material.dart';

// Models.
import 'package:app/src/commons/constants/custom_colors.dart';
import 'package:app/src/models/message_model.dart';

// Constants.
import 'package:app/src/commons/constants/sizes.dart';

class MessageItem extends StatelessWidget {
  final MessageModel message;
  final AnimationController animationController;

  final String myUid = '1'; // TODO - Delete

  const MessageItem({
    Key key,
    @required this.message,
    @required this.animationController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: this.animationController,
      child: SizeTransition(
        sizeFactor: CurvedAnimation(parent: this.animationController, curve: Curves.easeOut),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: Sizes.MARGIN_16, vertical: Sizes.MARGIN_4),
          alignment: message.uid == this.myUid ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
            padding: EdgeInsets.symmetric(horizontal: Sizes.MARGIN_16, vertical: Sizes.MARGIN_8),
            decoration: BoxDecoration(
              color: CustomColors.BLUE_TUENTI.withOpacity(message.uid == this.myUid ? 0.2 : 1),
              borderRadius: BorderRadius.circular(Sizes.MESSAGE_BORDER_RADIUS),
            ),
            child: Text(message.text, style: TextStyle(color: message.uid == this.myUid ? CustomColors.BLUE_TUENTI : Colors.white)),
          ),
        ),
      ),
    );
  }
}
