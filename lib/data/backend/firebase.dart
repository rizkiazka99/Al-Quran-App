import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

Future<void> userSetup(String name, String email) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser!.uid.toString();
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  
  users.doc(uid).collection('personal_info').add({
    'name' : name,
    'email' : email
  });
}