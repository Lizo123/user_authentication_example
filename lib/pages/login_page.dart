import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';

import 'package:user_authentication_example/resources/strings.dart';
import 'package:user_authentication_example/utils/TextFieldValidator.dart';
import 'package:provider/provider.dart';
import 'package:user_authentication_example/resources/colors.dart';
import 'package:user_authentication_example/resources/styles.dart';
import 'dart:io' show Platform;

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String email = "", password = "", passwordErrorText, emailErrorText;
  FocusNode emailFocus, passwordFocus;
  File _image = new File("");
  BuildContext childContext;

  @override
  void initState() {
    super.initState();
    emailFocus = FocusNode();
    passwordFocus = FocusNode();
    passwordErrorText = null;
    emailErrorText = null;
    emailFocus.addListener(() {
      if (!emailFocus.hasFocus) {
        if (!TextFieldValidator().emailValidator.isValid(email.toLowerCase())) {
          setState(() {
            emailErrorText = TextFieldValidator().emailValidator.errorText;
          });
        } else {
          setState(() {
            emailErrorText = null;
          });
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: primaryColor));
    return Scaffold(
        // resizeToAvoidBottomPadding: false,
        appBar: null,
        body: Builder(
            builder: (context) => GestureDetector(
                  child: Container(
                      child: Center(
                          child: Padding(
                              padding: EdgeInsets.only(
                                  top: 10, left: 20, right: 20, bottom: 10),
                              child: Form(
                                  key: _formKey,
                                  autovalidate: true,
                                  child: SingleChildScrollView(
                                      child: Column(
                                    children: <Widget>[
                                      welcomeTextWidget(context),
                                      loginDescriptionWidget(),
                                      loginWidget(),
                                      loginButtonWidget(),
                                      signInOptionsTextWidget(),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          signInWithGoogleButton(),
                                          signInWithAppleButton(),
                                          signInWithFacebookButton()
                                        ],
                                      ),
                                      signUpPageLinkWidget()
                                    ],
                                  )))))),
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                )));
  }

  Widget welcomeTextWidget(BuildContext context) {
    this.childContext = context;
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Align(
                alignment: Alignment.topCenter,
                child: Text(
                  welcomeToWeyan,
                  style: titleTextStyle,
                )),
          ),
        ],
      ),
    );
  }

  Widget loginDescriptionWidget() {
    return Padding(
      padding: EdgeInsets.only(bottom: 40),
      child: Center(
        child: Text(
          loginPageDescriptionText,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget loginWidget() {
    return Padding(
      padding: EdgeInsets.only(right: 20, left: 20),
      child: Container(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
            Text(
              emailText,
              style: SemiBoldTextStyle,
            ),
            TextFormField(
              textInputAction: TextInputAction.next,
              focusNode: emailFocus,
              decoration: InputDecoration(
                errorText: emailErrorText,
                contentPadding: EdgeInsets.only(top: 2, bottom: 2),
                isDense: true,
              ),
              onChanged: (emailValue) {
                email = emailValue;
              },
              onEditingComplete: () {
                emailValidation();
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text(passwordText, style: SemiBoldTextStyle),
            ),
            TextFormField(
              textInputAction: TextInputAction.done,
              focusNode: passwordFocus,
              obscureText: true,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(top: 2, bottom: 2),
                isDense: true,
                errorText: passwordErrorText,
              ),
              onChanged: (passwordValue) {
                password = passwordValue;
              },
              onEditingComplete: () {
                passwordValidation();
              },
            ),
            Padding(
                padding: EdgeInsets.only(top: 20),
                child: InkWell(
                    child: Text(
                      forgetPassText,
                      style: TextStyle(color: Colors.blue),
                    ),
                    onTap: () {
                      //  TODO: go to forget password page
                    }))
          ])),
    );
  }

  Widget loginButtonWidget() {
    return Padding(
      padding: EdgeInsets.all(40),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 50,
        child: RaisedButton(
          onPressed: () => validateInput(),
          color: primaryColor,
          textColor: whiteColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Text(signInText),
        ),
      ),
    );
  }

  Widget signInOptionsTextWidget() {
    return Padding(
        padding: EdgeInsets.only(bottom: 10), child: Text(signInOptionsText));
  }

  Widget signInWithGoogleButton() {
    return IconButton(
      icon: SvgPicture.asset(
        "assets/google.svg",
        width: 52,
        height: 52,
      ),
      onPressed: () {
      //  signInWithGoogle();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Under Development")));
      },
    );
  }

  signInWithGoogle() async {

  }

  Widget signInWithFacebookButton() {
    return IconButton(
      icon:  SvgPicture.asset("assets/facebook.svg",width: 50,height: 50,),
      onPressed: () {
        // signInWithFacebook();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(underDev)));
      },
    );
  }

  signInWithFacebook() async {}

  Widget signInWithAppleButton() {
    if (Platform.isAndroid) {
      return Container();
    }

    return IconButton(
      icon: Image(
        width: 50,
        height: 50,
        image: AssetImage("assets/apple.png"),
      ),
      onPressed: () {
        appleSignIn();
      },
    );
  }

  Widget signUpPageLinkWidget() {
    return Padding(
        padding: EdgeInsets.only(top: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(noAccountText),
            InkWell(
                child: Text(
                  signUpText,
                  style: TextStyle(color: Colors.blue),
                ),
                onTap: () {
                  // TODO go to signup page
                }),
          ],
        ));
  }

  void validateInput() {
    emailValidation();
    passwordValidation();

    FocusScope.of(context).unfocus();
    if (emailErrorText == null && passwordErrorText == null) {
      proceedSigningIn();
    }
  }

  void proceedSigningIn() async {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(signedSuccess)));
  }

  emailValidation() {
    if (TextFieldValidator().emailValidator.isValid(email.toLowerCase())) {
      setState(() {
        emailErrorText = null;
      });
    } else {
      setState(() {
        emailErrorText = TextFieldValidator().emailValidator.errorText;
      });
    }
  }

  passwordValidation() {
    if (password.isEmpty) {
      setState(() {
        passwordErrorText = requiredPassword;
      });
    } else {
      passwordErrorText = null;
    }
  }


  void appleSignIn() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(underDev)));
  }
}
