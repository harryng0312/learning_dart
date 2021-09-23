import 'dart:core';
import 'oop/test_class.dart';

void testPrint() {
  TestClass test = new TestClass();
  test.Count = 1;
  test.disp();

  String i = "1";
  dynamic obj = null;
  var a = null;
  i = a ?? "0";
  print("i: ${i}");
  print("i: ${obj}");
}

void testException() {
  int x = 12;
  int y = 0;
  int? res = null;
  print("type:${x is Object}");
  // try {
  //   res = x ~/ y;
  // } on IntegerDivisionByZeroException catch (e) {
  //   print(e);
  // }
  try {
    res = x ~/ y;
  } on IntegerDivisionByZeroException {
    print("====");
  } catch (e) {
    print(e);
  }
}

void main() {
  TestSubClass s = TestSubClass();
  s.Count = 1;
  testPrint();
  testException();
}
