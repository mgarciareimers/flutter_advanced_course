import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Commons.
import 'package:app/src/commons/utils/app_localizations.dart';

// Constants.
import 'package:app/src/commons/constants/custom_colors.dart';
import 'package:app/src/commons/constants/sizes.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController textEditingController;
  FocusNode focusNode;

  @override
  void initState() {
    this.textEditingController = new TextEditingController();
    this.focusNode = new FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    this.textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: this._createAppBar(),
      backgroundColor: CustomColors.GRAY_LIGHT,
      body: Container(
        child: Column(
          children: [
           this._createMessagesList(),
            Divider(height: 1),
            this._createTextBox(),
          ],
        ),
      )
    );
  }

  AppBar _createAppBar() {
    return AppBar(
      backgroundColor: CustomColors.BLUE_TUENTI,
      centerTitle: true,
      title: Text('User Name', style: TextStyle(color: Colors.white)),
      actions: [
        Container(
          width: Sizes.MARGIN_12,
          margin: EdgeInsets.only(right: Sizes.MARGIN_16),
          decoration: BoxDecoration(
            color: Colors.green,
            shape: BoxShape.circle,
          ),
        )
      ],
    );
  }

  Widget _createMessagesList() {
    return  Flexible(
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        reverse: true,
        itemBuilder: (BuildContext context, int index) => this._createMessageItem(),
      ),
    );
  }

  Widget _createMessageItem() {
    return Container(

    );
  }

  Widget _createTextBox() {
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.all(Sizes.MARGIN_16),
          child: Row(
            children: [
              Flexible(
                child: TextField(
                  controller: this.textEditingController,
                  decoration: InputDecoration.collapsed(hintText: AppLocalizations.of(this.context).translate('typeAMessage'), hintStyle: TextStyle(color: CustomColors.GRAY)),
                  onChanged: (value) => this._onMessageChanged(),
                  onSubmitted: (value) => this._onMessageSubmitted(),
                  minLines: 1,
                  maxLines: 8,
                  focusNode: this.focusNode,
                ),
              ),

              SizedBox(width: Sizes.MARGIN_16),

              Container(
                child: Platform.isIOS
                  ? CupertinoButton(
                      padding: EdgeInsets.symmetric(horizontal: 0),
                      child: Text(
                        AppLocalizations.of(context).translate('send'),
                        style: TextStyle(color: this.textEditingController.text.trim().length <= 0 ? CustomColors.GRAY : CustomColors.BLUE_TUENTI)
                      ),
                      onPressed: () => this._onMessageSubmitted(),
                    )
                  : MaterialButton(child:
                      Text(
                        AppLocalizations.of(context).translate('send'),
                        style: TextStyle(color: this.textEditingController.text.trim().length <= 0 ? CustomColors.GRAY : CustomColors.BLUE_TUENTI)
                      ),
                      onPressed: () => this._onMessageSubmitted(),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method that is called when the user submits the message.
  void _onMessageSubmitted() async {
    if (this.textEditingController.text.trim().length <= 0) {
      return;
    }

    await this._sendMessage();

    this.textEditingController.clear();
    this.focusNode.requestFocus();
  }

  // Method that is called when the user changes the message.
  void _onMessageChanged() {
    this.setState(() {});
  }

  // Method that sends the message
  Future<void> _sendMessage() async {
    print('Hello');
  }
}
