import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class Web3Service {
  final Web3Client _client;
  final String contractAddress = "0xYOUR_CONTRACT_ADDRESS";

  Web3Service()
      : _client = Web3Client(
          "https://goerli.infura.io/v3/YOUR_INFURA_PROJECT_ID",
          Client(),
        );

  Future<String> mintNFT(String userAddress, String metadataURI) async {
    final contract = DeployedContract(
      ContractAbi.fromJson('[{"inputs":[{"internalType":"string","name":"ideaURI","type":"string"}],"name":"mintIdea","outputs":[],"stateMutability":"nonpayable","type":"function"}]', "ThoughtNFT"),
      EthereumAddress.fromHex(contractAddress),
    );

    final function = contract.function("mintIdea");
    final credentials = EthPrivateKey.fromHex("YOUR_PRIVATE_KEY"); // Oder MetaMask-Wallet

    final transaction = Transaction.callContract(
      contract: contract,
      function: function,
      parameters: [metadataURI],
    );

    final txHash = await _client.sendTransaction(credentials, transaction, chainId: 5); // Goerli Chain
    return txHash;
  }
}
