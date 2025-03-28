Future<int> sumStream(Stream<int> stream) async {
  var sum = 0;
  try {
    await for (var value in stream) {
      sum += value;
    }
  } catch (e) {
    return -1;
  }
  return sum;
}

Stream<int> countStream(int to) async* {
  for (int i = 1; i <= to; i++) {
    if (i == 4) {
      // throw Exception('Intentional exception');
    } else {
      yield i;
    }
  }
}

Future<void> main() async {
  var stream = countStream(10);
  var sum = await sumStream(stream);
  print(sum); // -1
}
