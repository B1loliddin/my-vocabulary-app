import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:my_vocabulary_app/services/database_service.dart';

sealed class StorageService {
  static final FirebaseStorage storage = FirebaseStorage.instance;

  static Future<String> uploadFile(File file) async {
    final Reference image = storage.ref(Folder.wordImage).child(
          'img_${DateTime.now().toIso8601String()}${file.path.lastIndexOf('.')}',
        );

    final UploadTask uploadTask = image.putFile(file);
    await uploadTask.whenComplete(() {});

    return image.getDownloadURL();
  }
}
