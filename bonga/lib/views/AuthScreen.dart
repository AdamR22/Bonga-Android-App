import 'package:bonga/constants.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDefaultPrimaryColour,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.3,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Bong',
                    style: TextStyle(
                      color: kTextPrimaryColour,
                      fontSize: 24.0,
                      fontFamily: 'Poppins',
                      fontWeight: kFontWeightSemiBold,
                    ),
                  ),
                  Container(
                    height: 23.0,
                    width: 24.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          'assets/images/app_icon.png',
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.35,
            child: Column(
              children: [
                TextButton(
                  onPressed: null,
                  child: Text(
                    'REGISTER',
                    style: TextStyle(
                      color: kTextPrimaryColour,
                      fontFamily: 'Poppins',
                      fontSize: 18.0,
                      fontWeight: kFontWeightSemiBold,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: kDarkPrimaryColour,
                    minimumSize: Size(
                      MediaQuery.of(context).size.width * 0.85,
                      MediaQuery.of(context).size.height * 0.08,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                TextButton(
                  onPressed: null,
                  child: Text(
                    'LOGIN',
                    style: TextStyle(
                      color: kPrimaryTextColour,
                      fontFamily: 'Poppins',
                      fontSize: 18.0,
                      fontWeight: kFontWeightSemiBold,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: kLightPrimaryColour,
                    minimumSize: Size(
                      MediaQuery.of(context).size.width * 0.85,
                      MediaQuery.of(context).size.height * 0.08,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                Expanded(
                  child: TextButton(
                    onPressed: null,
                    child: Text(
                      'Forgot your password?',
                      style: TextStyle(
                          color: kTextPrimaryColour,
                          fontFamily: 'Poppins',
                          fontWeight: kFontWeightSemiBold,
                          fontSize: 14.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}