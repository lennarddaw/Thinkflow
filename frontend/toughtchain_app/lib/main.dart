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
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    // Initialisiere den Web3Client mit dem Goerli Testnetz von Infura
    _web3client = Web3Client(
      "https://goerli.infura.io/v3/YOUR_INFURA_PROJECT_ID", 
      Client()
    );
  }

  Future<void> connectWallet() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      // Hier könntest du den WalletConnect-Flow oder eine andere Methode einbinden
      // Beispiel: Öffne einen Dialog, in dem der Nutzer seine Wallet-Adresse eingibt
      // Simuliert hier die Verbindung
      await Future.delayed(const Duration(seconds: 2));
      setState(() {
        _walletAddress = "0x123456789abcdef"; // Ersetze dies durch echte Wallet-Verbindung
      });
    } catch (e) {
      setState(() {
        _errorMessage = "Verbindung fehlgeschlagen: $e";
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "ThoughtChain DApp",
      home: Scaffold(
        appBar: AppBar(title: const Text("ThoughtChain DApp")),
        body: Center(
          child: _isLoading
              ? const CircularProgressIndicator()
              : _walletAddress == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: connectWallet,
                          child: const Text("Mit Wallet verbinden"),
                        ),
                        if (_errorMessage != null) ...[
                          const SizedBox(height: 10),
                          Text(
                            _errorMessage!,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ],
                      ],
                    )
                  : Text("Verbunden mit: $_walletAddress"),
        ),
      ),
    );
  }
}
