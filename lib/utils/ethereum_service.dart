import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class EthereumService {
  final String rpcUrl;
  final String privateKey;
  late Web3Client _client;
  late EthPrivateKey _credentials;

  EthereumService(this.rpcUrl, this.privateKey) {
    _client = Web3Client(rpcUrl, Client());
    _credentials = EthPrivateKey.fromHex(privateKey);
  }

  Future<String> getAddress() async {
    final address = await _credentials.extractAddress();
    return address.hex;
  }

  Web3Client get client => _client;
  EthPrivateKey get credentials => _credentials;
}
