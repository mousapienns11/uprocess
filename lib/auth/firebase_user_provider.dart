import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class UprocessFirebaseUser {
  UprocessFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

UprocessFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<UprocessFirebaseUser> uprocessFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<UprocessFirebaseUser>(
            (user) => currentUser = UprocessFirebaseUser(user));
