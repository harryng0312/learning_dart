// import 'dart:async' as Async;
// import 'dart:math' as Math;
import 'dart:io' as IO;

void testInputStdin() {
  print("Enter your name :");

  // prompt for user input
  String? name = IO.stdin.readLineSync();

  // this is a synchronous method that reads user input
  print("Hello Mr. ${name}: ${name?.length}");
  print("End of main");
}

void main(List<String> args) {
  testInputStdin();
}
