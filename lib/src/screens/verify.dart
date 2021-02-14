import 'package:AloqStaq/config/ui_icons.dart';
import 'package:AloqStaq/src/widgets/SocialMediaWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../data_repo/user_repo.dart';

class VerifyWidget extends StatefulWidget {
  @override
  _VerifyWidgetState createState() => _VerifyWidgetState();
}

class _VerifyWidgetState extends State<VerifyWidget> {
  bool _showPassword = false;

  Widget build(BuildContext context) {
    return Scaffold(
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
                          color: Theme.of(context).hintColor.withOpacity(0.2),
                          offset: Offset(0, 10),
                          blurRadius: 20)
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 25),
                      Text('Verify',
                          style: Theme.of(context).textTheme.display3),
                      SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Image.asset(
                          'img/email.png',
                          width: 150,
                        ),
                      ),
                      Text(
                          'Please check your email address for verification, if there is no email press the button below to resend',
                          style: Theme.of(context).textTheme.headline4,
                          textAlign: TextAlign.center),
                      SizedBox(height: 20),
                      FlatButton(
                        padding:
                            EdgeInsets.symmetric(vertical: 12, horizontal: 70),
                        onPressed: () {
                          Navigator.of(context).pushNamed('/SignIn');
                        },
                        child: Text(
                          'Resend',
                          style: Theme.of(context).textTheme.title.merge(
                                TextStyle(
                                    color: Theme.of(context).primaryColor),
                              ),
                        ),
                        color: Theme.of(context).accentColor,
                        shape: StadiumBorder(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            FlatButton(
              onPressed: () {
                logout().then((value) {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      '/SignIn', (Route<dynamic> route) => false);
                });
              },
              child: RichText(
                text: TextSpan(
                  style: Theme.of(context).textTheme.title.merge(
                        TextStyle(color: Theme.of(context).primaryColor),
                      ),
                  children: [
                    TextSpan(text: 'Already Verified?'),
                    TextSpan(
                        text: ' Sign In',
                        style: TextStyle(fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
