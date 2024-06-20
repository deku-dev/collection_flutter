import 'dart:convert';
import 'dart:io';

import 'package:apillon_flutter/libs/apillon.dart';
import 'package:apillon_flutter/modules/storage/storage.dart';
import 'package:apillon_flutter/types/storage.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:web3dart/web3dart.dart';

import 'ethereum_service.dart';

class NftService {
  final EthereumService _ethereumService;

  NftService(this._ethereumService);

  Future<String> mintNFT(String metadataUri) async {
    final ethClient = _ethereumService.client;
    final credentials = _ethereumService.credentials;

    final abiCode = await rootBundle.loadString('assets/YourContract.abi.json');
    final contractAddress = EthereumAddress.fromHex('YOUR_CONTRACT_ADDRESS');

    final contract = DeployedContract(
      ContractAbi.fromJson(abiCode, 'YourContract'),
      contractAddress,
    );

    final mintFunction = contract.function('mintNFT');
    final recipientAddress = await _ethereumService.getAddress();

    final result = await ethClient.sendTransaction(
      credentials,
      Transaction.callContract(
        contract: contract,
        function: mintFunction,
        parameters: [EthereumAddress.fromHex(recipientAddress), metadataUri],
      ),
      chainId: 1, // Mainnet chain ID, use 4 for Rinkeby
    );

    return result;
  }

  Future<String> pinFileToIpfs(File file) async {
    final storage = Storage(ApillonConfig(
      key: 'key',
      secret: 'secret',
    ));

    final fileBytes = file.readAsBytesSync();
    final result = await storage.bucket('testbucket').uploadFiles([
      FileMetadata(
        fileName: '',
        contentType: 'text/plain',
        content: fileBytes,
      )
    ], IFileUploadRequest());

    return result.toString();
  }

  Future<String> createMetadata(String title, String description, String imageUrl) async {
    final metadata = {
      'title': title,
      'description': description,
      'image': imageUrl,
    };

    final metadataJson = json.encode(metadata);
    final fileName = '${path.basenameWithoutExtension(imageUrl)}.json';
    final tempDir = await getTemporaryDirectory();
    final metadataFile = File('${tempDir.path}/$fileName');
    await metadataFile.writeAsString(metadataJson);

    return await pinFileToIpfs(metadataFile);
  }
}
