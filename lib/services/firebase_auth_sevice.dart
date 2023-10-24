import 'package:firebase_auth/firebase_auth.dart';

Future<String?> getFirebaseAuthToken() async {
  final user = FirebaseAuth.instance.currentUser;
  if (user != null) {
    final tokenResult = await user.getIdToken();
    return tokenResult;
  }
  return null;
}
