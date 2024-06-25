import 'package:firebase_auth/firebase_auth.dart';

class AuthService{
  //get instance of firebase
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  //get current user
  User? getCurrentUser(){
    return _firebaseAuth.currentUser;
  }
  //sign in
  Future<UserCredential> signIn(String email,String password) async {
    try{
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password
      );
      return userCredential;
    }
    on FirebaseAuthException catch(e){
      throw Exception(e.code);
    }
  }
  //sign up
  Future<void> signUp(String userName,String email,String password) async{
    try{
      //create a user email and password
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );
      //update the dispaly name
      await userCredential.user?.updateDisplayName(userName);
      //
      //reload the user to ensure the updated diplay name is reflected
      await userCredential.user?.reload();
      //login
     // await signOut();
      //return the user 
      // return userCredential;
    }
    on FirebaseAuthException catch(e){
      throw Exception(e.code);
    }
  }
  //sign out
  Future<void> signOut() async{
    await _firebaseAuth.signOut();
  }
  //reset password
  Future<void> resetPassword(String email) async{
    await _firebaseAuth.sendPasswordResetEmail(email: email);
  }
}