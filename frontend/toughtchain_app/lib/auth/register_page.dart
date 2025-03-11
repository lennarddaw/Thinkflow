import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:toughtchain_app/widgets/colors.dart';

import '../widgets/components/sign_in_button.dart';
import '../widgets/components/textfield.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailnameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUserUp() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    try {
      if (passwordController.text == confirmPasswordController.text) {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailnameController.text,
          password: passwordController.text,
        );

        User? user = userCredential.user;

        if (user != null) {
          await FirebaseFirestore.instance
              .collection('userList')
              .doc(user.uid)
              .set({
            'uid': user.uid,
            'email': user.email,
            'createdAt': FieldValue.serverTimestamp(),
          });
        }

        if (mounted) {
          Navigator.pop(context);
        }
      } else {
        Navigator.pop(context);
        showErrorMessage('Passwörter stimmen nicht überein');
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage('Fehler bei der Registrierung: ${e.message}');
    }
  }

  void showErrorMessage(String textmessage) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Fehler'),
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
                // Logo
                Image.asset(
                  'lib/assets/img/netscanicon_white.png', // Passe ggf. den Pfad an
                  height: 130,
                  width: 130,
                  fit: BoxFit.contain,
                ),
                const SizedBox(height: 30),
                // App-Name
                const Text(
                  'ThinkFlow',
                  style: TextStyle(
                    color: ColorPalette.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'Roboto',
                  ),
                ),
                const SizedBox(height: 10),
                // Subheadline: Registrierung
                Text(
                  'Create an account',
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
                const SizedBox(height: 10),
                // Passwort bestätigen Textfeld
                MyTextField(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),
                const SizedBox(height: 25),
                // Register Button
                SignInButton(
                  onTap: signUserUp,
                  text: 'Register',
                ),
                const SizedBox(height: 50),
                // "Schon registriert? Jetzt einloggen" Link, linksbündig
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(
                          color: ColorPalette.white.withOpacity(0.7),
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 4),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          'login now',
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
