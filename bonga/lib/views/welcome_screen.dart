import 'package:bonga/constants.dart';
import 'package:bonga/views/components/edit_detail.dart';
import 'package:bonga/views/components/major_button.dart';
import 'package:bonga/views/components/text.dart';
import 'package:flutter/material.dart';

import 'components/item_row.dart';

class WelcomeScreen extends StatelessWidget {

  final List<Widget> _appBanner = [
    AppText(
      'Bong',
      kFontWeightSemiBold,
      24.0,
      kTextPrimaryColour,
    ),
    Container(
      height: 24.0,
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
  ];

  final TextEditingController _forgotPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDefaultPrimaryColour,
      body: Center(
        child: PotraitWelcomeScreenBody(
          appBanner: _appBanner,
          forgotPasswordController: _forgotPasswordController,
        ),
      ),
    );
  }
}

class PotraitWelcomeScreenBody extends StatelessWidget {
  const PotraitWelcomeScreenBody({
    Key? key,
    required List<Widget> appBanner,
    required TextEditingController forgotPasswordController,
  })  : _appBanner = appBanner,
        _forgotPasswordController = forgotPasswordController,
        super(key: key);

  final List<Widget> _appBanner;
  final TextEditingController _forgotPasswordController;

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Container(
          height: MediaQuery.of(context).orientation == Orientation.portrait
              ? kSizeSetter(context, 'Height', 0.2)
              : kSizeSetter(context, 'Height', 0.1),
          child: Center(
            child: ItemRow(
              _appBanner,
              MainAxisAlignment.center,
            ),
          ),
        ),
        SizedBox(
          height: kSizeSetter(context, 'Height', 0.1),
        ),
        Container(
          height: MediaQuery.of(context).orientation == Orientation.portrait
              ? kSizeSetter(context, 'Height', 0.35)
              : kSizeSetter(context, 'Height', 0.6),
          child: Column(
            children: [
              MajorButton(
                onPress: () {
                  kNormalPush(context, '/registration');
                },
                buttonColour: kDarkPrimaryColour,
                buttonTextColour: kTextPrimaryColour,
                buttonText: 'REGISTRATION',
                buttonWidth:
                    kSizeSetter(context, 'Width', kAuthButtonWidthRatio),
                buttonHeight:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? kSizeSetter(context, 'Height', kAuthButtonHeightRatio)
                        : kSizeSetter(context, 'Height', 0.15),
                // kSizeSetter(context, 'Height', kAuthButtonHeightRatio),
              ),
              SizedBox(
                height:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? kSizeSetter(context, 'Height', 0.05)
                        : kSizeSetter(context, 'Height', 0.08),
              ),
              MajorButton(
                onPress: () {
                  kNormalPush(context, '/login');
                },
                buttonColour: kLightPrimaryColour,
                buttonTextColour: kPrimaryTextColour,
                buttonText: 'LOGIN',
                buttonWidth:
                    kSizeSetter(context, 'Width', kAuthButtonWidthRatio),
                buttonHeight:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? kSizeSetter(context, 'Height', kAuthButtonHeightRatio)
                        : kSizeSetter(context, 'Height', 0.15),
              ),
              SizedBox(
                height:
                    MediaQuery.of(context).orientation == Orientation.portrait
                        ? kSizeSetter(context, 'Height', 0.05)
                        : kSizeSetter(context, 'Height', 0.01),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    kShowBottomSheet(
                      context,
                      MediaQuery.of(context).orientation == Orientation.portrait
                          ? kSizeSetter(context, 'Height', 0.3)
                          : kSizeSetter(context, 'Height', 0.5),
                      EditDetail(
                        detailController: _forgotPasswordController,
                        hintText: 'Enter your email address',
                      ),
                    );
                  },
                  child: AppText(
                    'Forgot your password?',
                    kFontWeightSemiBold,
                    14.0,
                    kTextPrimaryColour,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}