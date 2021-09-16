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
  Uint8List cipherDataBuff = Uint8List(cipher.getOutputSize(data.length));
  // add AAD
  cipher.processAADBytes(aadBytes, 0, aadBytes.length);
  int inOff = 0;
  while (inOff < data.length) {
    inOff += cipher.processBlock(data, inOff, cipherDataBuff, inOff);
  }
  inOff += cipher.doFinal(cipherDataBuff, inOff);
  Uint8List cipherData = Uint8List.view(cipherDataBuff.buffer, 0, inOff);
  // cipherData = cipher.process(data);
  String cipherText = base64Encode(cipherData);
  print("Cipher text: ${cipherText} cipher len: ${cipherData.length}");

  // decrypt
  // cipher = GCMBlockCipher(AESFastEngine());
  cipher.reset();
  cipher.init(false, ivParams);
  cipher.processAADBytes(aadBytes, 0, aadBytes.length);
  Uint8List plainDataBuff = Uint8List(cipher.getOutputSize(cipherData.length));
  Uint8List cipherContetnBuff =
      Uint8List.view(cipherData.buffer, 0, cipherData.length - cipher.macSize);
  int outOff = 0;
  while (outOff < cipherContetnBuff.length) {
    outOff += cipher.processBlock(cipherData, outOff, plainDataBuff, outOff);
  }
  try {
    outOff += cipher.doFinal(plainDataBuff, outOff);
    print("doFinal outOff:${outOff}");
  } on InvalidCipherTextException catch (e) {
    print("ex:${e.message}");
  }
  print("do-outOff:${outOff}");
  Uint8List plainData = Uint8List.view(plainDataBuff.buffer, 0, outOff);
  // Uint8List plainData = cipher.process(cipherData);
  String plainText = utf8.decode(plainData);
  print("Plain text: ${plainText} plain len: ${plainData.length}");
}

Future<void> testSignature() async {
  // print("===== ECDSA 256 =====");
  // List<int> data = utf8.encode("cộng hòa xẫ hội chủ nghĩa việt nam");
  // Random rand = Random.secure();
  // int byteLen = 16;

  // HashAlgorithm hashAlgorithm = Sha256();
  // Ecdsa algorithm = Ecdsa.p256(hashAlgorithm);

  // EcKeyPair keyPair = await algorithm.newKeyPair();
  // EcKeyPairData keyPairData = await keyPair.extract();
  // print("key pair: ${keyPairData.toString()}");
}

Future<void> testKeyAgreement() async {}
void main(List<String> args) {
  Future.wait([
    // testMessageDigest(),
    testCrypto(),
    // testSignature()
  ]);
}
