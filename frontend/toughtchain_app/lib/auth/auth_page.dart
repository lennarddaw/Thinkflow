import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../screens/home_screen.dart';
import 'login_or_register_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});


Future<void> checkUser(User user) async {
  try {
    final userRef = FirebaseFirestore.instance.collection('userList').doc(user.uid);

    final docSnapshot = await userRef.get();
    if (!docSnapshot.exists) {
      await userRef.set({
        'email': user.email,
        'uid': user.uid,
      });
    }
  } catch (e) {
    print('Error checking user: $e');
  }
}
 @override
Widget build(BuildContext context) {
  return Scaffold(
    body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          User user = snapshot.data!;
          String username = user.email ?? 'No Email';
          
          return FutureBuilder<void>(
            future: checkUser(user),
            builder: (context, futureSnapshot) {
              if (futureSnapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                return HomeScreen();
              }
            },
          );
        } else {
          return const LoginOrRegisterPage();
        }
      },
    ),
  );
}
}
