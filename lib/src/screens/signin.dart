import 'package:AloqStaq/config/ui_icons.dart';
import 'package:AloqStaq/src/controllers/user_controller.dart';
import 'package:AloqStaq/src/widgets/SocialMediaWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import '../data_repo/user_repo.dart' as user_repo;
import '../loader/helper.dart';

class SignInWidget extends StatefulWidget {
  @override
  _SignInWidgetState createState() => _SignInWidgetState();
}

class _SignInWidgetState extends StateMVC<SignInWidget> {
  bool _showPassword = false;
  UserController con;

  _SignInWidgetState() : super(UserController()) {
    con = controller;
  }

  @override
  void initState() {
    super.initState();
    if (user_repo.currentUser.value.token != null) {
      Navigator.of(context).pushReplacementNamed('/Tabs', arguments: 2);
    }
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: Helper.of(context).onWillPop,
      child: Scaffold(
        key: con.scaffoldKey,
        backgroundColor: Theme.of(context).accentColor,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                    margin: EdgeInsets.symmetric(vertical: 65, horizontal: 50),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Theme.of(context).primaryColor.withOpacity(0.6),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                    margin: EdgeInsets.symmetric(vertical: 85, horizontal: 20),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).primaryColor,
                        boxShadow: [
                          BoxShadow(
                              color:
                                  Theme.of(context).hintColor.withOpacity(0.2),
                              offset: Offset(0, 10),
                              blurRadius: 20)
                        ]),
                    child: Form(
                      key: con.loginForm,
                      child: Column(
                        children: <Widget>[
                          SizedBox(height: 25),
                          Text('Sign In',
                              style: Theme.of(context).textTheme.display3),
                          SizedBox(height: 20),
                          new TextFormField(
                            style:
                                TextStyle(color: Theme.of(context).accentColor),
                            keyboardType: TextInputType.emailAddress,
                            onSaved: (input) => con.user.email = input,
                            validator: (input) =>
                                !input.contains('@') ? "Invalid e-mail" : null,
                            decoration: new InputDecoration(
                              hintText: 'Email Address',
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .body1
                                  .merge(
                                    TextStyle(
                                        color: Theme.of(context).accentColor),
                                  ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .accentColor
                                          .withOpacity(0.2))),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).accentColor)),
                              prefixIcon: Icon(
                                UiIcons.envelope,
                                color: Theme.of(context).accentColor,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          new TextFormField(
                            style:
                                TextStyle(color: Theme.of(context).accentColor),
                            keyboardType: TextInputType.text,
                            onSaved: (input) => con.user.password = input,
                            obscureText: !_showPassword,
                            decoration: new InputDecoration(
                              hintText: 'Password',
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .body1
                                  .merge(
                                    TextStyle(
                                        color: Theme.of(context).accentColor),
                                  ),
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .accentColor
                                          .withOpacity(0.2))),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).accentColor)),
                              prefixIcon: Icon(
                                UiIcons.padlock_1,
                                color: Theme.of(context).accentColor,
                              ),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    _showPassword = !_showPassword;
                                  });
                                },
                                color: Theme.of(context)
                                    .accentColor
                                    .withOpacity(0.4),
                                icon: Icon(_showPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          FlatButton(
                            onPressed: () {},
                            child: Text(
                              'Forgot your password ?',
                              style: Theme.of(context).textTheme.body1,
                            ),
                          ),
                          SizedBox(height: 30),
                          FlatButton(
                            padding: EdgeInsets.symmetric(
                                vertical: 12, horizontal: 70),
                            onPressed: () {
                              // 2 number refer the index of Home page
                              con.login();
                            },
                            child: Text(
                              'Login',
                              style: Theme.of(context).textTheme.title.merge(
                                    TextStyle(
                                        color: Theme.of(context).primaryColor),
                                  ),
                            ),
                            color: Theme.of(context).accentColor,
                            shape: StadiumBorder(),
                          ),
                          SizedBox(height: 50),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pushNamed('/SignUp');
                },
                child: RichText(
                  text: TextSpan(
                    style: Theme.of(context).textTheme.title.merge(
                          TextStyle(color: Theme.of(context).primaryColor),
                        ),
                    children: [
                      TextSpan(text: 'Don\'t have an account ?'),
                      TextSpan(
                          text: ' Sign Up',
                          style: TextStyle(fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
