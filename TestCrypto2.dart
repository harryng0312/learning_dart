import 'dart:convert';
import 'dart:ffi';
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
      Uint8List.fromList(utf8.encode("cộng hòa xã hội chủ nghĩa việt nam"));
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
  cipher.init(true, ivParams);
  Uint8List cipherData = Uint8List(data.length + 16);
  // add AAD
  // cipher.processAADBytes(aadBytes, 0, aadBytes.length);
  int outOff = 0;
  while (outOff < data.length) {
    outOff += cipher.processBlock(data, outOff, cipherData, outOff);
  }
  int aadLen = cipher.doFinal(cipherData, outOff);

  String cipherText = base64Encode(cipherData);
  String macText = base64Encode(cipherData.sublist(cipherData.length - aadLen));
  print("Cipher text: ${cipherText} cipher len: ${cipherData.length}"
      "\nCipher mac: ${macText} aad len ${aadLen}");
  cipher.reset();
  // decrypt
  // cipher = GCMBlockCipher(AESFastEngine());
  cipher.init(false, ivParams);
  Uint8List cipherContentData = cipherData.sublist(0, cipherData.length - 16);
  Uint8List macData = cipherData.sublist(cipherData.length - 16);
  Uint8List plainData = Uint8List(cipherContentData.length);
  // cipherData[cipherData.length - 1] += 1;
  // add AAD
  // cipher.processAADBytes(aadBytes, 0, aadBytes.length);
  // outOff = 0;
  // while (outOff < plainData.length) {
  // outOff += cipher.processBlock(cipherData, outOff, plainData, outOff);
  // outOff += cipher.processBytes(cipherData, outOff, 16, plainData, outOff);
  // }
  plainData = cipher.process(cipherData);
  print("outoff:${outOff}");
  // aadLen = cipher.doFinal(cipherData, outOff);
  // try {
  // aadLen = cipher.doFinal(cipherData, plainData.length);
  cipher.validateMac();
  String plainText = utf8.decode(plainData);
  macText = base64Encode(macData);
  print("Plain text: ${plainText} plain len: ${plainData.length}"
      "\nCipher mac: ${macText} len ${aadLen}");
  // } on InvalidCipherTextException catch (e) {
  // print("ex:${e.message}");
  // }
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
  Future.wait([testMessageDigest(), testCrypto(), testSignature()]);
}
