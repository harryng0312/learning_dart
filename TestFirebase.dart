import 'package:firebase/firebase.dart' as fb;

void connectToFirebase() {
  // fb.FirebaseOptions options = fb.FirebaseOptions();

  // .setCredentials(GoogleCredentials.getApplicationDefault())
  // .setDatabaseUrl("https://<DATABASE_NAME>.firebaseio.com/")
  // .build();

  fb.App fbApp = fb.initializeApp(
      apiKey: "AAAA6_cKBbs:AIzaSyAMZl2DAWmMmzJuUAs_dAFYw5VAa_kzvk8",
      authDomain: "harry-s-firebase-test.firebaseapp.com",
      databaseURL: "https://harry-s-firebase-test.firebaseio.com",
      projectId: "harry-s-firebase-test.appspot.com",
      storageBucket: "harry-s-firebase-test");

  fb.Database db = fb.database();
  fb.DatabaseReference ref = db.ref('messages');

  ref.onValue.listen((e) {
    fb.DataSnapshot datasnapshot = e.snapshot;
    // Do something with datasnapshot
  });
}

void main(List<String> args) {}
