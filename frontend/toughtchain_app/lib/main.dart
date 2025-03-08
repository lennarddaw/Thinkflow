import 'package:flutter/material.dart';
import 'package:flutter_web3/flutter_web3.dart';

void main() {
  runApp(const ThoughtChainApp());
}

class ThoughtChainApp extends StatefulWidget {
  const ThoughtChainApp({Key? key}) : super(key: key);

  @override
  _ThoughtChainAppState createState() => _ThoughtChainAppState();
}

class _ThoughtChainAppState extends State<ThoughtChainApp> {
  String? userAddress;

  Future<void> connectWallet() async {
    if (ethereum != null) {
      try {
        final accounts = await ethereum!.requestAccount();
        setState(() {
          userAddress = accounts.first;
        });
      } catch (e) {
        print("Fehler beim Verbinden: $e");
      }
    } else {
      print("Kein Ethereum-Anbieter gefunden");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("ThoughtChain DApp")),
        body: Center(
          child: userAddress == null
              ? ElevatedButton(
                  onPressed: connectWallet,
                  child: const Text("Mit MetaMask verbinden"),
                )
              : Text("Verbunden mit: $userAddress"),
        ),
      ),
    );
  }
}
