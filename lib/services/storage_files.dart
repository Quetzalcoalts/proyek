import 'dart:io';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_storage/firebase_storage.dart'
    as Firebase_storage_import;

class Storage {
  final Firebase_storage_import.FirebaseStorage storage =
      Firebase_storage_import.FirebaseStorage.instance;
  Future<void> UploadFile(String filename, String Path) async {
    File file = File(Path);

    try {
      await storage.ref('test/$filename').putFile(file);
    } on firebase_core.FirebaseException catch (e) {
      print(e);
    }
  }

  Future<Firebase_storage_import.ListResult> listFiles() async {
    Firebase_storage_import.ListResult results =
        await storage.ref('test').listAll();
    results.items.forEach((Firebase_storage_import.Reference ref) {
      print('Found Files : ${ref}');
    });
    return results;
  }

  Future<String> downloadURL(String imageName) async {
    String downloadURL = await storage.ref('test/$imageName').getDownloadURL();
    return downloadURL;
  }
}
