import 'dart:isolate';

int val = 10;

void foo(var message) {
  print('execution from foo ... the message is :${message}');
}

void testIsolate() {
  Isolate.spawn(foo, 'Hello!!');
  Isolate.spawn(foo, 'Greetings!!');
  Isolate.spawn(foo, 'Welcome!!');

  print('execution from main1');
  print('execution from main2');
  print('execution from main3');
}

void doTask(String msg) async {
  val++;
  print("${msg}:${val}");
  await Future.delayed(Duration(milliseconds: 100));
}

void testIsolateConcurency() {
  print("start ...");
  for (int i = 1; i <= 10; i++) {
    Isolate.spawn(doTask, "t${i}");
    Isolate.spawn(doTask, "t${i + 0.5}");
  }
  print("end ...");
}

void main() {
  // testIsolate();
  testIsolateConcurency();
}
