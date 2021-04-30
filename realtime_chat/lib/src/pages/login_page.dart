import 'package:app/src/commons/constants/sizes.dart';
import 'package:flutter/material.dart';

// Constants.
import 'package:app/src/commons/constants/custom_colors.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.GRAY_LIGHT,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _Logo(),
            _Form(),
            _Labels(),
            Text('Términos y condiciones de uso', style: TextStyle(fontSize: Sizes.FONT_14, color: Colors.black54, fontWeight: FontWeight.w200)),
          ],
        ),
      )
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
            Image(image: AssetImage('assets/logo.png'), width: 180,),
            SizedBox(height: Sizes.MARGIN_16),
            Text('Tuenti Chat', style: TextStyle(fontSize: Sizes.FONT_24, fontWeight: FontWeight.bold)),
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
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [

        ],
      ),
    );
  }
}

class _Labels extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('¿No tienes cuenta?', style: TextStyle(fontSize: Sizes.FONT_14, color: Colors.black54, fontWeight: FontWeight.w300)),
          SizedBox(height: Sizes.MARGIN_4),
          InkWell(
            child: Text('Crea una ahora', style: TextStyle(fontSize: Sizes.FONT_16, color: Colors.blue[600], fontWeight: FontWeight.bold))
          ),
        ],
      ),
    );
  }
}


