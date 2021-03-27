import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_sign_in/google_sign_in.dart';

final _auth = FirebaseAuth.instance;
final googleSignIn = GoogleSignIn();

bool authSignedIn;
String uid;
String userEmail;
String name;
String imageUrl;

Future<String> registerWithEmailPassword(String email, String password) async {
  await Firebase.initializeApp();

  final userCredential = await _auth.createUserWithEmailAndPassword(
    email: email,
    password: password,
  );

  final user = userCredential.user;

  if (user != null) {
    assert(user.uid != null);
    assert(user.email != null);

    uid = user.uid;
    userEmail = user.email;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    return 'Successfully registered, User UID: ${user.uid}';
  }

  return null;
}

Future<String> signInWithEmailPassword(String email, String password) async {
  await Firebase.initializeApp();

  final userCredential = await _auth.signInWithEmailAndPassword(
    email: email,
    password: password,
  );

  final User user = userCredential.user;

  if (user != null) {
    assert(user.uid != null);
    assert(user.email != null);

    uid = user.uid;
    userEmail = user.email;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final User currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);

    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('auth', true);

    return 'Successfully logged in, User UID: ${user.uid}';
  }

  return null;
}

Future<String> signOut() async {
  await _auth.signOut();

  final prefs = await SharedPreferences.getInstance();
  prefs.setBool('auth', false);

  uid = null;
  userEmail = null;

  return 'User signed out';
}

Future<String> signInWithGoogle() async {
  // Initialize Firebase
  await Firebase.initializeApp();

  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

  final credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );

  final userCredential = await _auth.signInWithCredential(credential);
  final user = userCredential.user;

  if (user != null) {
    assert(user.uid != null);
    assert(user.email != null);
    assert(user.displayName != null);
    assert(user.photoURL != null);

    uid = user.uid;
    name = user.displayName;
    userEmail = user.email;
    imageUrl = user.photoURL;

    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    final currentUser = _auth.currentUser;
    assert(user.uid == currentUser.uid);

    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('auth', true);

    return 'Google sign in successful, User UID: ${user.uid}';
  }

  return null;
}

void signOutGoogle() async {
  await googleSignIn.signOut();
  await _auth.signOut();

  final prefs = await SharedPreferences.getInstance();
  prefs.setBool('auth', false);

  uid = null;
  name = null;
  userEmail = null;
  imageUrl = null;

  print("User signed out of Google account");
}
