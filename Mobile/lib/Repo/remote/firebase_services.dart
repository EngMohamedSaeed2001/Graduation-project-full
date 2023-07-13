import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase;
class FirebaseServices{
  final firebase.FirebaseStorage storage = firebase.FirebaseStorage.instance ;

  Future<void> upload_image(
      File image,
      String email,
      String name
      ) async{
    try{
      await storage.ref("images/$email/$name").putFile(image) ;
    } on firebase.FirebaseException catch(e){
      print(e) ;
    }
  }

  Future<String> get_url(
      String email,
      String name) async{
    try{
      String url = await storage.ref("images/$email/").child("$name").getDownloadURL() ;
      return url ;
    }on firebase.FirebaseException catch(e){
      print(e) ;
    }
    return "" ;
  }
}