// import 'dart:async' as Async;
// import 'dart:math' as Math;
import 'dart:io' as IO;

Future<int> threadRun1(int val) async {
  print("into threadRun1");
  Future<int> rs = Future.delayed(Duration(seconds: 3)).then((value) => val);
  print("out from threadRun1");
  return rs;
}

Future<int> threadRun2(int val) async {
  print("into threadRun2");
  Future<int> rs = Future.delayed(Duration(seconds: 5)).then((value) => val);
  print("out from threadRun2");
  return rs;
}

Future<void> main(List<String> args) async {
  print("Begin");
  DateTime start = DateTime.now();

  // threadRun1(1);
  // threadRun2(2);
  Future<int> tr1 = Future.sync(() => threadRun1(1));
  Future<int> tr2 = Future.sync(() => threadRun2(2));
  int rs1 = await tr1;
  int rs2 = await tr2;
  DateTime finish = DateTime.now();
  print("End");
  print("result: ${rs1} ${rs2}");
  print("Time run: ${finish.difference(start).inMilliseconds}");
}
