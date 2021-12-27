import 'dart:convert';

import 'package:cryptography/cryptography.dart';

Future<void> testMessageDigest() async {
  final message = <int>[1, 2, 3];
  final sha256 = Sha256();
  final sink = sha256.newHashSink();
  sink.add(message);
  sink.close();
  final result = await sink.hash();
  print("lenght:${result.bytes.length} sha256: ${base64Encode(result.bytes)}");
}

Future<void> testEncryptMsg() async {
  final message = <int>[1, 2, 3];
  // AES-CTR with 128 bit keys and HMAC-SHA256 authentication.
  final algorithm = AesCtr.with128bits(
    macAlgorithm: Hmac.sha256(),
  );
  final secretKey = await algorithm.newSecretKey();
  final nonce = algorithm.newNonce();

  // Encrypt
  final secretBox = await algorithm.encrypt(
    message,
    nonce: nonce,
    secretKey: secretKey,
  );
  final cipherText = secretBox.cipherText;
  final macBytes = secretBox.mac.bytes;
  final cipherNone = secretBox.nonce;
  print('Nonce: ${cipherNone}');
  print('Ciphertext: ${cipherText}');
  print('MAC: ${macBytes}');

  // Decrypt
  final cipherMac = Mac(macBytes);
  final decryptSecretBox =
      SecretBox(cipherText, nonce: cipherNone, mac: cipherMac);
  // decryptSecretBox.concatenation(mac: false);
  final clearText = await algorithm.decrypt(
    decryptSecretBox,
    secretKey: secretKey,
  );
  print('Cleartext: $clearText');
}

Future<void> testSignature() async {}

void main(List<String> args) {
  Future.wait([
    testMessageDigest(),
    testEncryptMsg(),
    testSignature(),
  ]);
}
