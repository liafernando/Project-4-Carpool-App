import 'package:firebase_database/firebase_database.dart';
import 'package:users_app/global/global.dart';

import '../models/user_model.dart';

class HelpingMethods {
  static void readCurrentOnline() async {
    currentFirebaseUser = fAuth.currentUser;
    DatabaseReference userRef = FirebaseDatabase.instance
        .ref()
        .child("users")
        .child(currentFirebaseUser!.uid);

    userRef.once().then((snap) {
      if (snap.snapshot.value != null) {
        userModelCurrentInfo = UserModel.fromSnapshot(snap.snapshot);
      }
    });
  }
}
