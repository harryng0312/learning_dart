import 'package:firebase/firebase_io.dart' as fbio;

// void connectToFirebase() {
//   fb.App fbApp = fb.initializeApp(
//       apiKey: "AAAA6_cKBbs:AIzaSyAMZl2DAWmMmzJuUAs_dAFYw5VAa_kzvk8",
//       authDomain: "harry-s-firebase-test.firebaseapp.com",
//       databaseURL: "https://harry-s-firebase-test.firebaseio.com",
//       projectId: "harry-s-firebase-test.appspot.com",
//       storageBucket: "harry-s-firebase-test",
//       messagingSenderId: "1013461943739");

//   fb.Database db = fb.database();
//   fb.DatabaseReference dbRef = db.ref('messages');

//   dbRef.onValue.listen((e) {
//     fb.DataSnapshot datasnapshot = e.snapshot;
//     // Do something with datasnapshot
//     print("data: ${e.snapshot}");
//   });

//   fs.Firestore store = fb.firestore();
//   fs.CollectionReference collRef = store.collection('/dogs');
//   collRef.onSnapshot.listen((querySnapshot) {
//     querySnapshot.docChanges().forEach((change) {
//       if (change.type == "added") {
//         print("chagned:${change.doc.data()["name"]}");
//       }
//     });
//   });
// }

Future<void> testFirebaseClient() async {
  String basePath = "https://harry-s-firebase-test.firebaseio.com";
  fbio.FirebaseClient fbClient = fbio.FirebaseClient(
      "firebase/harry-s-firebase-test-firebase-adminsdk-nb76s-82ef0f4b73.json");
  String path = basePath +
      "/databases/documents/dogs.json"
          '?mask.fieldPaths=name&mask.fieldPaths=age&mask.fieldPaths=id&orderBy=id';
  var response = await fbClient.get(path);
  print("res:${response}");
}

void main(List<String> args) {
  // connectToFirebase();
  testFirebaseClient();
}
