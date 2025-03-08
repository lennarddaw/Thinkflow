import 'package:flutter/material.dart';
import 'package:web3dart/web3dart.dart';
import 'package:http/http.dart';

void main() {
  runApp(const ThoughtChainApp());
}

class ThoughtChainApp extends StatefulWidget {
  const ThoughtChainApp({Key? key}) : super(key: key);

  @override
  _ThoughtChainAppState createState() => _ThoughtChainAppState();
}

class _ThoughtChainAppState extends State<ThoughtChainApp> {
  Web3Client? _web3client;
  String? _walletAddress;

  @override
  void initState() {
    super.initState();
    _web3client = Web3Client("https://goerli.infura.io/v3/YOUR_INFURA_PROJECT_ID", Client());
  }

  Future<void> connectWallet() async {
    // Beispiel: Benutzer gibt seine Wallet-Adresse ein
    setState(() {
      _walletAddress = "0x123456789abcdef";  // Ersetze dies mit echter Interaktion
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text("ThoughtChain DApp")),
        body: Center(
          child: _walletAddress == null
              ? ElevatedButton(
                  onPressed: connectWallet,
                  child: const Text("Mit Wallet verbinden"),
                )
              : Text("Verbunden mit: $_walletAddress"),
        ),
      ),
    );
  }
}
