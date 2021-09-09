import 'dart:developer';

abstract class TestAbstractClass {
  int absInt = 0;
  void absAdd();
  void absAdd2() {
    this.absInt++;
  }
}

abstract class TestAbstractClass2 {
  int get absInt2;
  set absInt2(int);

  // int absInt2 = 0;
  void absSubtract();
  void absSubtract2() {
    absInt2--;
  }
}

mixin TestMixin2 on TestAbstractClass2 {
  // can not override on minix
  @override
  void absSubstract() {
    this.absInt2 -= 2;
  }

  void absSubtract3() {
    this.absInt2 -= 2;
  }
}

class TestClass extends TestAbstractClass2
    with TestMixin2
    implements TestAbstractClass {
  int _privCount = 0;
  int pubCount = 1;

  void set Count(value) {
    this._privCount = value;
  }

  int get Count {
    return this._privCount;
  }

  void disp() {
    print("Hello World");
  }

  @override
  void absAdd() {}

  @override
  int get absInt2 {
    return 0;
  }

  @override
  set absInt2(int) {
    // TODO: implement absInt2
  }

  @override
  void absAdd2() {
    // cannot call if abstract-class as an interface
    // super.absAdd2();
  }

  @override
  void absSubtract2() {
    super.absSubtract2();
  }

  @override
  // int absInt = 1;
  int get absInt {
    return 1;
  }

  set absInt(value) {
    // cannot call if abstract-class as an interface
    // super.absInt = value;
  }

  @override
  void absSubtract() {
    // TODO: implement absSubtract
  }
}

class TestSubClass extends TestClass {
  void set Count(value) {
    super._privCount = value;
    this.absAdd2();
    this.absInt = 34;
    print("this absInt : ${this.absInt}");
  }
}
