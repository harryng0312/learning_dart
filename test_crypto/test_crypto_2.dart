import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';

import 'package:pointycastle/export.dart';

Future<void> testMessageDigest() async {
  print("===== SHA 256 =====");
  int bitLen = 256;
  String data = "cộng hòa xã hội chủ nghĩa việt nam";
  Digest sha256 = Digest("SHA-256");
  Uint8List input = Uint8List.fromList(utf8.encode(data));
  Uint8List output = Uint8List(bitLen ~/ 8);
  sha256.update(input, 0, input.length);
  int oLim = sha256.doFinal(output, 0);

  String b64Digest = await base64Encode(output);
  print("String len:${data.length} - data len:${input.length}");
  print("SHA 256:${b64Digest}");
}

Future<void> testCrypto() async {
  print("===== AES GCM 128 =====");
  Uint8List data =
      Uint8List.fromList(utf8.encode("cộng hòa xã hội chủ nghĩa việt nam   "
          "cộng hòa xã hội chủ nghĩa việt nam   "
          "cộng hòa xã hội chủ nghĩa việt nam   "
          "cộng hòa xã hội chủ nghĩa việt nam "));
  print("AES Data len:${data.length}");
  Random rand = Random.secure();
  int byteLen = 16;
  Uint8List keyBytes = Uint8List.fromList(
      List<int>.generate(byteLen, (index) => rand.nextInt(256)));
  Uint8List aadBytes = Uint8List.fromList(
      List<int>.generate(byteLen, (index) => rand.nextInt(256)));
  Uint8List iv = Uint8List.fromList(
      List<int>.generate(byteLen, (index) => rand.nextInt(256)));

  GCMBlockCipher cipher = GCMBlockCipher(AESFastEngine());
  // GCMBlockCipher cipher = GCMBlockCipher(BlockCipher("AES"));
  CipherParameters keyParams =
      KeyParameter.offset(keyBytes, 0, keyBytes.length);
  CipherParameters ivParams = ParametersWithIV(keyParams, iv);

  // encrypt
  cipher.reset();
  cipher.init(true, ivParams);
  // add AAD
  cipher.processAADBytes(aadBytes, 0, aadBytes.length);
  Uint8List cipherData = cipher.process(data);
  String cipherText = base64Encode(cipherData);
  print("Cipher text: ${cipherText} cipher len: ${cipherData.length}");

  // decrypt
  // cipher = GCMBlockCipher(AESFastEngine());
  cipher.reset();
  cipher.init(false, ivParams);
  cipher.processAADBytes(aadBytes, 0, aadBytes.length);
  Uint8List plainData = cipher.process(cipherData);
  String plainText = utf8.decode(plainData);
  print("Plain text: ${plainText} plain len: ${plainData.length}");
}

Future<void> testSignature() async {
  // print("===== ECDSA 256 =====");
  final data =
      Uint8List.fromList(utf8.encode("cộng hòa xẫ hội chủ nghĩa việt nam"));
  var random = Random.secure();
  var seed =
      Uint8List.fromList(List<int>.generate(32, (_) => random.nextInt(256)));
  FortunaRandom rand = FortunaRandom();
  rand.seed(KeyParameter(seed));

  ECKeyGeneratorParameters keyParams =
      ECKeyGeneratorParameters(ECCurve_secp256k1());

  ECKeyGenerator keyGenerator = ECKeyGenerator();
  keyGenerator.init(ParametersWithRandom(keyParams, rand));

  AsymmetricKeyPair<PublicKey, PrivateKey> keyPair =
      keyGenerator.generateKeyPair();

  ECDSASigner signer = ECDSASigner(SHA256Digest());

  // sign
  CipherParameters privateKeyParam = PrivateKeyParameter(keyPair.privateKey);
  signer.reset();
  ParametersWithRandom parametersWithRandom =
      ParametersWithRandom(privateKeyParam, rand);
  signer.init(true, parametersWithRandom);
  ECSignature signature = signer.generateSignature(data) as ECSignature;
  // verify
  PublicKeyParameter publicKeyParam = PublicKeyParameter(keyPair.publicKey);
  signer.reset();
  signer.init(false, publicKeyParam);
  bool verified = signer.verifySignature(data, signature);
  print("verified:${verified}");
}

Future<void> testKeyAgreement() async {}
void main(List<String> args) {
  Future.wait([
    // testMessageDigest(),
    // testCrypto(),
    testSignature()
  ]);
}
