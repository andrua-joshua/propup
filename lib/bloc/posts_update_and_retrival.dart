

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

//ignore:camel_case_types
class postsUpdateAndRetrival{
  static final user = FirebaseAuth.instance.currentUser;
  static final postsStore = FirebaseFirestore.instance.collection("posts");
  static final storageRf = FirebaseStorage.instance.ref();

  static Future<UploadTask> addPost() async{
    final imagePicker = ImagePicker();
          final imageFile = await imagePicker.pickImage(
            source: ImageSource.gallery);
            final file = File(imageFile!.path);

            final extStart = file.path.lastIndexOf('.');
            final ext = file.path.substring(extStart);
            String postName = DateTime.now().second.toString()+ext;
            final fileRef = storageRf.child("posts/"+postName);

            final task = fileRef.putFile(file);

            postsStore.doc(postName).set({
              "owner":user?.uid,
              "likes":0
            });

            return task;
  }
}