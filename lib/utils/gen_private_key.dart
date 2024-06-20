import 'package:bip39/bip39.dart' as bip39;
import 'package:ed25519_hd_key/ed25519_hd_key.dart';
import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:hex/hex.dart';

const _storage = FlutterSecureStorage();

Future<String> generateAndEncryptPrivateKey() async {
  final mnemonic = bip39.generateMnemonic();
  final seed = bip39.mnemonicToSeed(mnemonic);
  final master = await ED25519_HD_KEY.getMasterKeyFromSeed(seed);
  final privateKey = await ED25519_HD_KEY.derivePath(
      "m/44'/60'/0'/0/0",
      master.key
  );
  final encryptedKey = await encryptPrivateKey(HEX.encode(privateKey.key));
  return encryptedKey;
}

Future<String> encryptPrivateKey(String privateKey) async {
  final keyString = await _storage.read(key: 'encryption_key');
  if (keyString == null) {
    throw Exception('Encryption key not found in secure storage');
  }
  final key = encrypt.Key.fromUtf8(keyString);
  final iv = encrypt.IV.fromLength(16);
  final encrypter = encrypt.Encrypter(encrypt.AES(key));
  final encrypted = encrypter.encrypt(privateKey, iv: iv);
  return encrypted.base64;
}
