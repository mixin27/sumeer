import 'dart:io';

import 'package:flutter/material.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> pickImageFromGallery(BuildContext context) async {
  File? image;
  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      image = File(pickedImage.path);
    }
  } catch (e) {
    showSnackBar(context: context, content: e.toString());
  }
  return image;
}

void showSnackBar({required BuildContext context, required String content}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}

Future<String> storeFileToFirebase(
    String path, File file, WidgetRef widgetRef) async {
  UploadTask uploadTask =
      FirebaseStorage.instance.ref().child(path).putFile(file);
  // uploadTask.snapshotEvents.listen((event) {
  //   widgetRef.read(imageUploadCountProvider.notifier).update(
  //         (state) =>
  //             event.bytesTransferred.toDouble() / event.totalBytes.toDouble(),
  //       );
  //   });
  TaskSnapshot snap = await uploadTask;

  String downloadUrl = await snap.ref.getDownloadURL();
  return downloadUrl;
}
