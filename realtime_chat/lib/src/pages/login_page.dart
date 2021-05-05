import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Services.
import 'package:app/src/services/auth_service.dart';

// Commons.
import 'package:app/src/commons/utils/app_localizations.dart';
import 'package:app/src/commons/utils/show_alert.dart';

// Routes.
import 'package:app/src/routes/routes.dart';

// Constants.
import 'package:app/src/commons/constants/custom_colors.dart';
import 'package:app/src/commons/constants/sizes.dart';
import 'package:app/src/commons/constants/strings.dart';

// Widgets.
import 'package:app/src/widgets/text_field_custom.dart';
import 'package:app/src/widgets/elevated_button_custom.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.GRAY_LIGHT,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height * 0.95),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _Logo(),
                SizedBox(height: Sizes.MARGIN_16 * 1.5),
                _Form(),
                SizedBox(height: Sizes.MARGIN_16 * 1.5),
                _Labels(),
                SizedBox(height: Sizes.MARGIN_16 * 1.5),
                Text(AppLocalizations.of(context).translate('termsAndConditions'), style: TextStyle(fontSize: Sizes.FONT_14, color: Colors.black54, fontWeight: FontWeight.w200)),
                SizedBox(height: Sizes.MARGIN_16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.only(top: 50),
        child: Column(
          children: [
            Image(image: AssetImage('assets/logo.png'), width: MediaQuery.of(context).size.width * 0.38),
            SizedBox(height: Sizes.MARGIN_16),
            Text(AppLocalizations.of(context).translate('appName'), style: TextStyle(fontSize: Sizes.FONT_22, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  TextEditingController emailController;
  TextEditingController passwordController;

  @override
  void initState() {
    this.emailController = new TextEditingController();
    this.passwordController = new TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    this.emailController.dispose();
    this.passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AuthService authService = Provider.of<AuthService>(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: Sizes.MARGIN_16 * 2),
      child: Column(
        children: [
          TextFieldCustom(
            controller: this.emailController,
            hint: AppLocalizations.of(context).translate('email'),
            inputType: TextInputType.emailAddress,
            iconData: Icons.email_rounded,
          ),
          SizedBox(height: Sizes.MARGIN_16),
          TextFieldCustom(
            controller: this.passwordController,
            hint: AppLocalizations.of(context).translate('password'),
            obscureText: true,
            iconData: Icons.lock,
          ),
          SizedBox(height: Sizes.MARGIN_16),
          ElevatedButtonCustom(
            onPressed: (context) => authService.isLogging ? null : this._onLoginButtonClicked(context, authService),
            text: AppLocalizations.of(context).translate('login'),
            backgroundColor: authService.isLogging ? CustomColors.GRAY : CustomColors.BLUE_TUENTI,
          ),
        ],
      ),
    );
  }

  // Method that is called when the user clicks the "login" button.
  void _onLoginButtonClicked(BuildContext context, AuthService authService) async {
    FocusScope.of(context).unfocus();

    final Map<String, dynamic> response = await authService.login(this.emailController.text.trim(), this.passwordController.text.trim());

    if (!response[Strings.SUCCESS]) {
      return showAlert(context, AppLocalizations.of(context).translate('error'), response[Strings.MESSAGE], AppLocalizations.of(context).translate('ok')); // ERROR.
    }

    print(response);
  }
}

class _Labels extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(AppLocalizations.of(context).translate('notAnAccount'), style: TextStyle(fontSize: Sizes.FONT_14, color: Colors.black54, fontWeight: FontWeight.w300)),
          SizedBox(height: Sizes.MARGIN_4),
          InkWell(
            onTap: () => this._onCreateAccountLinkClicked(context),
            child: Text(AppLocalizations.of(context).translate('createAccountNow'), style: TextStyle(fontSize: Sizes.FONT_16, color: CustomColors.BLUE_TUENTI, fontWeight: FontWeight.bold))
          ),
        ],
      ),
    );
  }

  // Method that is called when the user clicks the "create account" link.
  void _onCreateAccountLinkClicked(BuildContext context) {
    Navigator.pushNamed(context, Routes.SIGN_UP_PAGE);
  }
}


