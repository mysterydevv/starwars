import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  Future<String> downloadImageUrl(String imageName) async {
    String downloadUrl = await FirebaseStorage.instance
        .ref()
        .child(imageName)
        .getDownloadURL();
    return downloadUrl;
  }
}
