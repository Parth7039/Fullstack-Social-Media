import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_media_fullstack/features/auth/domain/entities/app_user.dart';
import 'package:social_media_fullstack/features/auth/domain/repos/auth_repo.dart';

class FirebaseAuthRepo implements AuthRepo {

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  @override
  Future<AppUser?> getCurrentUser() async {
   //get current logged in user from database
    final firebaseUser = firebaseAuth.currentUser;

    //no user logged in...
    if(firebaseUser == null){
      return null;
    }
    return AppUser(
        uid: firebaseUser.uid,
        email: firebaseUser.email!,
        name: '',
    );
  }

  @override
  Future<AppUser?> loginWithEmailPassword(String email, String password) async{
    try{
      //attempt sign in
      UserCredential userCredential = await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);

      //create user
      AppUser user = AppUser(
          uid: userCredential.user!.uid,
          email: email,
          name: ''
      );


      return user;
    }
    catch(e){
      throw Exception('Login failed: $e');
    }
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<AppUser?> registerWithEmailPassword(String name, String email, String password) async{
    try{
      //attempt sign up
      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);

      //create user
      AppUser user = AppUser(
          uid: userCredential.user!.uid,
          email: email,
          name: name,
      );

      await firebaseFirestore.collection("users").doc(user.uid).set(user.tojson());

      return user;
    }
    catch(e){
      throw Exception('Sign up failed: $e');
    }
  }

}