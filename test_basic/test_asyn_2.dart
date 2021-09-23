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
  List<int> rs = List.filled(2, 0);
  DateTime start = DateTime.now();
  rs = await Future.wait([threadRun1(1), threadRun2(2)]);
  DateTime start2 = DateTime.now();
  Future<int> tr1 = Future.sync(() => threadRun1(1));
  Future<int> tr2 = Future.sync(() => threadRun2(2));
  rs[0] = await tr1;
  rs[1] = await tr2;
  DateTime finish = DateTime.now();
  print("End");
  print("result: ${rs[0]} ${rs[1]}");
  print("Time run1: ${start2.difference(start).inMilliseconds}\n"
      "Time run2: ${finish.difference(start2).inMilliseconds}");
}
