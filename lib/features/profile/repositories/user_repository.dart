import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import '../models/user_model.dart';


class UserRepository {

  final FirebaseFirestore _firestore;
  final FirebaseStorage _firebaseStorage;

  UserRepository(
      {FirebaseFirestore? firestore, FirebaseStorage? firebaseStorage})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        _firebaseStorage = firebaseStorage ?? FirebaseStorage.instance;

  Future<UserModel?> getUser(String uid) async {
    DocumentSnapshot<Map<String, dynamic>> userDoc =
    await _firestore.collection('users').doc(uid).get();
    if (userDoc.exists) {
      return UserModel.fromMap(userDoc.data()!, uid);
    }
    return null;
  }

  Future<void> updateUser(UserModel user) async {
    await _firestore.collection('users').doc(user.uid).update(user.toMap());
  }

  Future<String> uploadProfilePhoto(String userId, File image) async {
    try {
      String fileName = basename(image.path);
      Reference firebaseStorageRef =
      _firebaseStorage.ref().child('uploads/$userId/$fileName.jpg');
      UploadTask uploadTask = firebaseStorageRef.putFile(image);
      final taskSnapshot = await uploadTask.whenComplete(() => null);
      return await taskSnapshot.ref.getDownloadURL();
    } catch (e) {
      print('Error uploading profile photo: $e');
      rethrow;
    }
  }

  }

