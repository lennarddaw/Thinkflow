import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ThoughtChain DApp")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: const Text("Mit Wallet verbinden"),
        ),
      ),
    );
  }
}
