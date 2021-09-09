import 'dart:convert';
import 'dart:math';
import 'package:cryptography/cryptography.dart';

Future<void> testMessageDigest() async {
  print("===== SHA256 =====");
  String data = "cộng hòa xã hội chủ nghĩa việt nam";
  Sha256 sha256 = Sha256();
  List<int> input = utf8.encode(data);
  Hash digest = await sha256.hash(input);
  String b64Digest = await base64Encode(digest.bytes);
  print("String len:${data.length} - data len:${input.length}");
  print("SHA 256:${b64Digest}");
}

Future<void> testCrypto() async {
  print("===== AES GCM =====");
  List<int> data = utf8.encode("cộng hòa xẫ hội chủ nghĩa việt nam");
  Random rand = Random.secure();
  int byteLen = 16;
  List<int> keyBytes =
      List<int>.generate(byteLen, (index) => rand.nextInt(256));
  List<int> addBytes =
      List<int>.generate(byteLen, (index) => rand.nextInt(256));
  List<int> iv = List<int>.generate(byteLen, (index) => rand.nextInt(256));

  AesGcm cipher = AesGcm.with128bits();
  // cipher.newSecretKeyFromBytes(keyBytes);
  SecretKey randKey = await cipher.newSecretKeyFromBytes(keyBytes);
  List<int> nonce = iv;
  List<int> add = addBytes;
  // List<int> randKeyBytes = await randKey.extractBytes();

  // encrypt
  SecretBox resultBox =
      await cipher.encrypt(data, secretKey: randKey, nonce: nonce, aad: add);
  List<int> c = resultBox.cipherText;
  String cipherText = base64Encode(c);
  String mac = base64Encode(resultBox.mac.bytes);
  print("Cipher text: ${cipherText}\nCipher mac: ${mac} len ${mac.length}");

  // decrypt
  List<int> macBytes = base64Decode(mac);
  SecretBox cryptedBox =
      SecretBox(base64Decode(cipherText), nonce: nonce, mac: Mac(macBytes));
  List<int> plainData =
      await cipher.decrypt(cryptedBox, secretKey: randKey, aad: add);
  String plainText = utf8.decode(plainData);
  print("Plain text: ${plainText}");

  // print("Set most bit: ${keyBytes[0] >> 7} ${keyBytes[15] >> 7}");
  // print("Rand most bit:${randKeyBytes[0] >> 7} ${randKeyBytes[15] >> 7}");
}

Future<void> testSignature() async {}

Future<void> testKeyAgreement() async {}
void main(List<String> args) {
  Future.wait([testMessageDigest(), testCrypto()]);
}
