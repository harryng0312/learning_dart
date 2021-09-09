import "dart:async";
import 'dart:core';
import "dart:io";

import 'dart:typed_data';

final String path = Directory.current.path + "/data/contact.txt";

Future<void> testReadFileAsync() async {
  File file = new File(path);
  Future<String> future = file.readAsString();
  // returns a futrue, this is Async method
  future.then((data) {
    print("lap 1:${data}");
    return data;
  }).then((data) {
    print("lap 2:${data}");
  });
  // f.then((data) => print("lap 2:${data}"));
  future.whenComplete(() {});
  // once file is read , call back method is invoked
  print("End of Read file");
  // this get printed first, showing fileReading is non blocking or async
}

Future<void> testReadRandomAccessFileAsync() async {
  File file = new File(path);
  Future<RandomAccessFile> futureRaf = file.open();
  // RandomAccessFile randomAccessFile = await futureRaf;
  RandomAccessFile raf = await futureRaf;
  List<int> contentList = [];
  int rCount = 10;
  while (true) {
    Uint8List buff = await raf.read(rCount);
    if (buff.isEmpty) {
      break;
    }
    contentList.addAll(buff);
  }
  await raf.close();
  String content = String.fromCharCodes(contentList);
  print("content: ${content}");
}

void main() {
  print("=== Start Main ===");
  testReadFileAsync();
  // testReadRandomAccessFileAsync();
  print("=== End Main ===");
}
