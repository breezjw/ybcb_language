
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

class AuthService {
  Logger logger = Logger();

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Stream<User?> onAuthChanged() {
    return _firebaseAuth.authStateChanges();
  }

  Future<String?> signInWithGoogle() async {
    await _googleSignIn.signOut();
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    await _firebaseAuth.signInWithCredential(credential);
    logger.d("HERE");
    User? user = _firebaseAuth.currentUser;

    logger.d("$user");

    return user?.uid;
  }

  Future<bool> isSignedIn() async {
    final currentUser = _firebaseAuth.currentUser;
    return currentUser != null;
  }

  Future<User> getCurrentUser() async {
    return _firebaseAuth.currentUser!;
  }

  Future<String?> getAccessToken() async {
    User? user = _firebaseAuth.currentUser;
    String? token =  await user?.getIdToken();

    return token;
  }

  Future<String?> getRefreshToken() async {
    User? user = await _firebaseAuth.currentUser;
    String? token = await user?.getIdToken(true);

    return token;
  }

  Future<List<void>> signOut() async {
    return Future.wait([
      _firebaseAuth.signOut(),
      _googleSignIn.signOut(),
    ]);
  }
}