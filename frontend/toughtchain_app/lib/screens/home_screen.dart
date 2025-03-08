import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final VoidCallback onConnectWallet;

  const HomeScreen({Key? key, required this.onConnectWallet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("ThoughtChain DApp")),
      body: Center(
        child: ElevatedButton(
          onPressed: onConnectWallet,
          child: const Text("Mit Wallet verbinden"),
        ),
      ),
    );
  }
}
