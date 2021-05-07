import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

// Services.
import 'package:app/src/services/auth_service.dart';

// Models.
import 'package:app/src/models/user_model.dart';

// Commons.
import 'package:app/src/commons/utils/app_localizations.dart';

// Routes.
import 'package:app/src/routes/routes.dart';

// Constants.
import 'package:app/src/commons/constants/sizes.dart';
import 'package:app/src/commons/constants/custom_colors.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final List<UserModel> users = [
    new UserModel(uid: '1', name: 'Rose', email: 'email1@email.com', isOnline: true),
    new UserModel(uid: '2', name: 'Fernando', email: 'email2@email.com', isOnline: true),
    new UserModel(uid: '3', name: 'Paquita', email: 'email3@email.com', isOnline: false),
  ];

  RefreshController refreshController;

  @override
  void initState() {
    this.refreshController = new RefreshController(initialRefresh: false);
    super.initState();
  }

  @override
  void dispose() {
    this.refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: this._createAppBar(),
      body: SmartRefresher(
        controller: this.refreshController,
        enablePullDown: true,
        header: WaterDropHeader(
          complete: Icon(Icons.check_circle, color: CustomColors.BLUE_TUENTI),
          waterDropColor: CustomColors.BLUE_TUENTI,
        ),
        child: this._createUserList(),
        onRefresh: () => this._loadUsers(),
      ),
    );
  }

  // Method that creates the app bar.
  AppBar _createAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      centerTitle: true,
      title: Text(AppLocalizations.of(context).translate('appName'), style: TextStyle(color: CustomColors.BLUE_TUENTI)),
      leading: InkWell(
        child: Icon(Icons.logout, color: Colors.black),
        onTap: () => this._onLogoutButtonClicked(),
      ),
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

  // Method that creates the user list.
  Widget _createUserList() {
    return ListView.separated(
      itemCount: this.users.length,
      itemBuilder: (BuildContext context, int index) => this._createUserListItem(this.users[index]),
      separatorBuilder: (BuildContext context, int index) => Divider(),
    );
  }

  // Method that creates the user list item.
  Widget _createUserListItem(UserModel user) {
    return ListTile(
      title: Text(user.name),
      leading: CircleAvatar(
        child: Text(user.name.substring(0, 2), style: TextStyle(color: Colors.white)),
        backgroundColor: CustomColors.BLUE_TUENTI,
      ),
      trailing: Container(
        width: Sizes.MARGIN_12,
        decoration: BoxDecoration(
          color: user.isOnline ? Colors.green : Colors.red,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  // Method that loads the users.
  void _loadUsers() async {
    await Future.delayed(Duration(milliseconds: 1000));
    this.refreshController.refreshCompleted();
    print('Complete!');
  }

  // Method that is called when the user clicks the logout button.
  void _onLogoutButtonClicked() {
    // TODO - Disconnect from socket server.

    AuthService.removeJWT();
    Navigator.pushReplacementNamed(this.context, Routes.LOGIN_PAGE);
  }
}
