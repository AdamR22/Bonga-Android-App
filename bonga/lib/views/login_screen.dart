import 'package:bonga/constants.dart';
import 'package:bonga/controllers/authentication.dart';
import 'package:bonga/handlers/connectivity_handler.dart';
import 'package:bonga/handlers/size_setter_handler.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'components/form_field.dart';
import 'components/major_button.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDefaultPrimaryColour,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: SingleChildScrollView(
            child: LoginScreenForm(),
          ),
        ),
      ),
    );
  }
}

class LoginScreenForm extends StatefulWidget {
  @override
  State<LoginScreenForm> createState() => _LoginScreenFormState();
}

class _LoginScreenFormState extends State<LoginScreenForm> {
  final _loginFormKey = GlobalKey<FormState>();

  final _emailTextFieldController = TextEditingController();

  final _passwordTextFieldController = TextEditingController();

  bool _logginIn = false;

  void _loginUser(BuildContext context) async {
    bool userConnected = await checkConnectivity();
    bool userLoggedIn;

    setState(() {
      _logginIn = true;
    });

    if (userConnected) {
      userLoggedIn = await Authentication.loginUser(
        _emailTextFieldController.text,
        _passwordTextFieldController.text,
      );
      if (userLoggedIn) {
        setState(() {
          _logginIn = false;
        });
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      }
    } else {
      setState(() {
        _logginIn = false;
      });
      Fluttertoast.showToast(msg: 'No internet connection');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginFormKey,
      child: Column(
        children: [
          AuthFormField(
            textFieldController: _emailTextFieldController,
            hintText: 'Email Address',
            emptyFieldValidatorError: kEmptyEmailValidatorError,
            invalidFieldValidatorError: kInvalidEmailValidatorError,
            keyboardType: TextInputType.emailAddress,
            isPasswordField: false,
          ),
          SizedBox(
            height: sizeSetter(context, 'Height', 0.05),
          ),
          AuthFormField(
            textFieldController: _passwordTextFieldController,
            hintText: 'Password',
            emptyFieldValidatorError: kEmptyPasswordValidatorError,
            invalidFieldValidatorError: kInvalidPasswordValidatorError,
            keyboardType: TextInputType.visiblePassword,
            isPasswordField: true,
          ),
          SizedBox(
            height: sizeSetter(context, 'Height', 0.05),
          ),
          MajorButton(
            onPress: () {
              if (_loginFormKey.currentState!.validate()) {
                _loginUser(context);
              }
            },
            buttonColour: kDarkPrimaryColour,
            buttonTextColour: kTextPrimaryColour,
            buttonText: 'LOGIN',
            buttonWidth: sizeSetter(context, 'Width', kAuthButtonWidthRatio),
            buttonHeight:
                MediaQuery.of(context).orientation == Orientation.portrait
                    ? sizeSetter(context, 'Height', kAuthButtonHeightRatio)
                    : sizeSetter(context, 'Height', 0.15),
          ),
          _logginIn == true
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Container()
        ],
      ),
    );
  }
}
