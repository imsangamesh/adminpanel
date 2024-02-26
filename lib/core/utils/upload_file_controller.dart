import 'dart:developer';
import 'dart:io';

import 'package:adminpanel/core/constants/constants.dart';
import 'package:adminpanel/core/utils/popup.dart';
import 'package:firebase_storage/firebase_storage.dart';

class UploadFileController {
  // ======================= upload multiple files ===================
  static Future<Map<String, String>?> single(File file) async {
    try {
      Popup.loading(label: 'Uploading Files');

      final Map<String, String> fileData = {};

      TaskSnapshot taskSnapshot = await store.ref().child(timeId).putFile(file);
      fileData['name'] = file.uri.pathSegments.last;
      fileData['url'] = await taskSnapshot.ref.getDownloadURL();
      fileData['delete_ref'] = taskSnapshot.ref.fullPath;

      log(fileData.toString());
      // return fileData;
    } on FirebaseException catch (e) {
      Popup.alert(e.code, e.message.toString());
    } catch (e) {
      Popup.general();
    } finally {
      Popup.terminateLoading();
    }
    return null;
  }

  static Future<List<Map<String, String>>?> multiple(List<File> files) async {
    try {
      Popup.loading(label: 'Uploading Files');

      final List<Map<String, String>> filesDataList = [];
      for (var eachFile in files) {
        final Map<String, String> fileData = {};

        TaskSnapshot taskSnapshot =
            await store.ref().child(timeId).putFile(eachFile);

        fileData['name'] = eachFile.uri.pathSegments.last;
        fileData['url'] = await taskSnapshot.ref.getDownloadURL();
        fileData['delete_ref'] = taskSnapshot.ref.fullPath;

        filesDataList.add(fileData);
      }

      return filesDataList;
    } on FirebaseException catch (e) {
      Popup.alert(e.code, e.message.toString());
    } catch (e) {
      Popup.general();
    } finally {
      Popup.terminateLoading();
    }
    return null;
  }
  // ======================= upload event images ===================
  // static Future<List<String>?> newEventImages(
  //   String title,
  //   List<XFile> images,
  // ) async {
  //   try {
  //     List<String> imageUrls = [];
  //     Popup.progress(label: 'uploading...');

  //     for (int i = 0; i < images.length; i++) {
  //       TaskSnapshot taskSnapshot = await store
  //           .ref()
  //           .child('events')
  //           .child('$title _ $i')
  //           .putFile(File(images[i].path));

  //       imageUrls.add(await taskSnapshot.ref.getDownloadURL());
  //     }
  //     Get.back();
  //     return imageUrls;
  //   } on FirebaseException catch (e) {
  //     Get.back();
  //     Popup.alert(e.code, e.message.toString());
  //   } catch (e) {
  //     Get.back();
  //     Popup.general();
  //   }
  //   return null;
  // }

  // ======================= events firestore ===================
  // static updEventDataToFire(EventModel em) async {
  //   try {
  //     Popup.progress(label: 'updating');
  //     await fire.collection('events').doc(em.eid).set(em.toMap());

  //     Get.offAll(const HomeScreen());
  //     Popup.showSnackBar('new event updated.', yes: true, millSecs: 1800);
  //   } on FirebaseException catch (e) {
  //     Get.back();
  //     Popup.alert(e.code, e.message.toString());
  //   } catch (e) {
  //     Get.back();
  //     Popup.general();
  //   }
  // }
}
