import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toughtchain_app/widgets/colors.dart';

import '../widgets/components/sign_in_button.dart';
import '../widgets/components/textfield.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key, required this.onTap});

  final Function()? onTap;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailnameController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailnameController.text,
        password: passwordController.text,
      );

      if (mounted) {
        Navigator.pop(context);
      }
    } on FirebaseAuthException catch (e) {
      if (mounted) {
        Navigator.pop(context);
      }

      if (e.code == 'invalid-email') {
        showErrorMessage('No account found for this email');
      } else if (e.code == 'invalid-credential') {
        showErrorMessage('Wrong password, please try again');
      } else {
        showErrorMessage('Please make sure your data is correct');
      }
    }
  }

  void showErrorMessage(String textmessage) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(textmessage),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.black,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                
                // Logo einfügen
                Image.asset(
                  'lib/assets/img/netscanicon_white.png',
                  height: 130,
                  width: 130,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 30),
                
                // App-Name
                const Text(
                  'ToughtChain',
                  style: TextStyle(
                    color: ColorPalette.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Roboto',
                  ),
                ),
                const SizedBox(height: 10),
                
                // Sign In Subheadline
                Text(
                  'Sign in',
                  style: TextStyle(
                    color: ColorPalette.white.withOpacity(0.7),
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 25),
                
                // E-Mail Textfeld
                MyTextField(
                  controller: emailnameController,
                  hintText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(height: 10),
                
                // Passwort Textfeld
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 25),
                
                // Sign In Button
                SignInButton(onTap: signUserIn, text: 'Sign In'),
                const SizedBox(height: 50),
                
                // "Not a user yet? Register now" Link, linksbündig
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Not a user yet?',
                        style: TextStyle(
                          color: ColorPalette.white.withOpacity(0.7),
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'Register now',
                          style: TextStyle(
                            color: ColorPalette.emerald,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
