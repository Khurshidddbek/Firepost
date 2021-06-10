import 'package:firebase_auth/firebase_auth.dart';
import 'package:firepost/pages/signin_page.dart';
import 'package:firepost/services/auth_service.dart';
import 'package:firepost/services/prefs_service.dart';
import 'package:firepost/services/utils_service.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';

class SignUpPage extends StatefulWidget {
  static final String id = 'signup_page';

  const SignUpPage({Key key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var isLoading = false;

  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var fullnameController = TextEditingController();

  _signUp() {
    var email = emailController.text.toString().trim();
    var password = passwordController.text.toString().trim();
    var fullname = fullnameController.text.toString().trim();

    if (email.isEmpty || password.isEmpty || fullname.isEmpty) {
      Utils.fireToast('Check your informations!');
    }
    else {
      setState(() {
        isLoading = true;
      });

      AuthService.signUpUser(context, fullname, email, password).then((firebaseUser) {
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
    else Utils.fireToast('Check your informations!');
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
                  controller: fullnameController,
                  decoration: InputDecoration(
                      hintText: 'Full Name'
                  ),
                ),

                SizedBox(height: 10,),

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
                    onPressed: _signUp,
                    color: Colors.blue,
                    child: Text('Sign Up', style: TextStyle(color: Colors.white),),
                  ),
                ),

                SizedBox(height: 15,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('Already have an Account? ', style: TextStyle(color: Colors.grey),),

                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, SignInPage.id);
                      },
                      child: Text('Sign In', style: TextStyle(fontWeight: FontWeight.bold),),
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
