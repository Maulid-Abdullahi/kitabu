import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AppFunction {
  // ignore: non_constant_identifier_names, missing_return
  Future<AppFunction> LoginFunction(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (userCredential != null) {}
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
    User user = FirebaseAuth.instance.currentUser;

    if (!user.emailVerified) {
      await user.sendEmailVerification();
    }
  }

  // ignore: non_constant_identifier_names, missing_return
  Future<AppFunction> RegisterFunction(
      String phone,
      String password,
      String email,
      String name,
      String location,
      String id,
      function,
      function2) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      if (userCredential != null) {
        createUser(phone, email, name, location, id, function2);
      }
    } on FirebaseAuthException catch (e) {
      print("Firebase exception");
      print(e.toString());
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        print("function us !" + function.toString());
        function();
      }
    } catch (e) {
      print(e);
    }
  }

  // ignore: non_constant_identifier_names
  void AuthState() {
    FirebaseAuth auth = FirebaseAuth.instance;
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  // ignore: missing_return
  Future<AppFunction> createUser(String phone, String email, String name,
      String location, String id, function) {
    final firestoreInstance = Firestore.instance;
    var firebaseUser = FirebaseAuth.instance.currentUser;
    firestoreInstance.collection("Master_Profile").doc(firebaseUser.uid).set({
      "Phone": phone,
      "Name": name,
      "Location": location,
      "Email": email,
      'ParentID': id
    }).then((_) {
      print("function us !" + function.toString());
      function();
      print("success!");
    });
  }

  // ignore: missing_return
  Future<AppFunction> createProfile(
      String name, String image, String classLevel,function) {
    final firestoreInstance = Firestore.instance;
    var firebaseUser = FirebaseAuth.instance.currentUser;
    firestoreInstance.collection("User_Profile").doc(firebaseUser.uid).set({
      "Name": name,
      "Image": image,
      "Class": classLevel,
      "MasterId": firebaseUser.uid.toString()
    }).then((_) {
      function();
      print("success!");
    });
  }

  // ignore: missing_return
  Future<AppFunction> continue_watching(String video_url, video_title, video_description, teacher, videoImage, video_time) {
    final firestoreInstance = Firestore.instance;
    var firebaseUser = FirebaseAuth.instance.currentUser;
    firestoreInstance.
    collection("User_Profile")
        .doc(firebaseUser.uid)
        .collection("continue_watching")
        .add({
      "teacher_name": teacher,
      "video_description": video_description,
      "video_title": video_title,
      "video_url": video_url,
      "video_time": video_time,
      "videoImage": videoImage,
      'key':video_title+teacher

    }).then((_) {
      print("function us !");
      print("success!");
    });
  }


}