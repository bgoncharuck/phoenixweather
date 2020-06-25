import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:phoenixweather_flutter_app/constants.dart';
import 'package:phoenixweather_flutter_app/services/firebase_auth.dart';

class LoginGoogleButton extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final theme= context.watch<IDefaultTheme>();
    return  FlatButton(
      child: Column(
        children: [
          Icon(
            Icons.account_circle,
            color: theme.accent,
            size: 64,
          ), 
          SizedBox(height: 32),
          Text(
            "Google",
            style: TextStyle(
              fontSize: 22
            ),
          ),
        ],
      ),
    onPressed: () {
      loginAction(
        context: context, 
        serviceLogin: GoogleLogin
      );
    }
    );
  }
}

Future<String> GoogleLogin(BuildContext context) async {
  final auth= context.read<FirebaseAuth >();
  final googleSignIn= context.read<GoogleSignIn>();

  try {
    final GoogleSignInAccount googleUser = await googleSignIn.signIn().catchError(
      // Will not work in DEBUG mode.
      // Test it in flutter run
      (err) {print(err.toString()); return 'local';}
    ) ;
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = (await auth.signInWithCredential(credential)).user;
    print("signed in " + user.displayName);
    return user.uid;
  }
  catch (e) {
    print(e.toString());
    return "local";
  }
}