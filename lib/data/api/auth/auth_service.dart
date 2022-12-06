import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tryhard_showcase/data/api/auth/models/auth_user.dart';

import 'auth.dart';
import 'models/auth_error_descriptions.dart';
import 'models/auth_exception.dart';

class FirebaseAuthService implements AuthApi {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'profile',
    ],
  );

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  String? getAuthUserInfo() => _auth.currentUser?.uid;

  Future<bool> _isGoogleLoggedIn() async {
    try {
      return await _googleSignIn.isSignedIn();
    } catch (_) {
      return false;
    }
  }

  @override
  Future<AuthUser> googleLogIn() async {
    try {
      bool userSignedIn = await _isGoogleLoggedIn();
      if (userSignedIn && _auth.currentUser != null) {
        return AuthUser(
          userGuid: _auth.currentUser!.uid,
          name: _auth.currentUser!.displayName,
          email: _auth.currentUser!.email,
          photoUrl: _auth.currentUser!.photoURL,
        );
      } else {
        final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

        GoogleSignInAuthentication? googleSignInAuthentication = await googleUser?.authentication;

        if (googleSignInAuthentication != null) {
          AuthCredential credential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken,
          );

          UserCredential authResult = await _auth.signInWithCredential(credential);
          final user = authResult.user;
          return AuthUser(
            userGuid: user!.uid,
            name: user.displayName,
            email: user.email,
            photoUrl: user.photoURL,
          );
        } else {
          throw AuthException(
            code: 'auth-error',
            message: 'Logging in with Google is failed',
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      throw AuthException(
        code: e.code,
        message: e.message ?? 'An unknown error has occurred',
      );
    } on AuthException catch (_) {
      rethrow;
    } catch (_) {
      throw AuthException(
        code: 'auth-error',
        message: 'Logging in with Google is failed',
      );
    }
  }

  @override
  Future<AuthUser> userLogin({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return AuthUser(
        userGuid: result.user!.uid,
        name: result.user!.displayName,
        email: result.user!.email,
        photoUrl: result.user!.photoURL,
      );
    } on FirebaseAuthException catch (e) {
      throw AuthException(
        code: e.code,
        message: e.message ?? 'An unknown login error has occurred',
      );
    } catch (_) {
      throw AuthException(
        code: 'login-error',
        message: 'An unknown login error has occurred',
      );
    }
  }

  @override
  Future<void> userLogout() async {
    try {
      if (await _googleSignIn.isSignedIn() == true) {
        await _googleSignIn.signOut();
      }
      await _auth.signOut();
    } on FirebaseAuthException catch (e) {
      throw AuthException(
        code: e.code,
        message: e.message ?? 'Sign out error has occurred',
      );
    } catch (_) {
      throw AuthException(
        code: 'sign-out-error',
        message: 'Sign out error has occurred',
      );
    }
  }

  @override
  Future<AuthUser> userRegistration({
    required String email,
    required String password,
  }) async {
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return AuthUser(
        userGuid: result.user!.uid,
        name: result.user!.displayName,
        email: result.user!.email,
        photoUrl: result.user!.photoURL,
      );
    } on FirebaseAuthException catch (e) {
      final message = e.code == 'weak-password'
          ? AuthErrorDescriptions.weakPassword
          : e.code == 'email-already-in-use'
              ? AuthErrorDescriptions.emailAlreadyExists
              : e.message;
      throw AuthException(
        code: e.code,
        message: message ?? 'An unknown error has occurred',
      );
    } catch (_) {
      throw AuthException(
        code: 'error',
        message: 'An unknown error has occurred',
      );
    }
  }
}
