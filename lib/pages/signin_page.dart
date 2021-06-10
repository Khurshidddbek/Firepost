import 'package:firebase_auth/firebase_auth.dart';
import 'package:firepost/pages/home_page.dart';
import 'package:firepost/pages/signup_page.dart';
import 'package:firepost/services/auth_service.dart';
import 'package:firepost/services/prefs_service.dart';
import 'package:firepost/services/utils_service.dart';
import 'package:flutter/material.dart';

class SignInPage extends StatefulWidget {
  static final String id = 'signin_page';

  const SignInPage({Key key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  var isLoading = false;

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  _signIn() {
    var email = emailController.text.toString().trim();
    var password = passwordController.text.toString().trim();

    if (email.isEmpty || password.isEmpty) {
      Utils.fireToast('Check your Email or Password!');
    }
    else {
      setState(() {
        isLoading = true;
      });

      AuthService.signInUser(context, email, password).then((firebaseUser) {
        _getFirebaseUser(firebaseUser);
      });
    }
  }

  void _getFirebaseUser(FirebaseUser firebaseUser) async {
    setState(() {
      isLoading = false;
    });
    if(firebaseUser != null) {
      await Prefs.saveUserId(firebaseUser.uid);

      Navigator.pushReplacementNamed(context, HomePage.id);
    }
    else Utils.fireToast('Check your Email or Password!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                      hintText: 'Email'
                  ),
                ),

                SizedBox(height: 10,),

                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                      hintText: 'Password'
                  ),
                ),

                SizedBox(height: 10,),

                Container(
                  height: 45,
                  width: double.infinity,
                  child: FlatButton(
                    onPressed: _signIn,
                    color: Colors.blue,
                    child: Text('Sign In', style: TextStyle(color: Colors.white),),
                  ),
                ),

                SizedBox(height: 15,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Don\'t hava an Account? ', style: TextStyle(color: Colors.grey),),

                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, SignUpPage.id);
                      },
                      child: Text('Sign Up', style: TextStyle(fontWeight: FontWeight.bold),),
                    ),
                  ],
                ),
              ],
            ),
          ),

          isLoading ?
          Center(
            child: CircularProgressIndicator(),
          ) :
              SizedBox.shrink(),
        ],
      ),
    );
  }
}
