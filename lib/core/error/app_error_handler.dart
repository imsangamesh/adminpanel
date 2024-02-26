import 'package:adminpanel/core/utils/popup.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class AppErrorHandler {
  /// --------------------------------- `FIRESTORE ERROR HANDLER`
  static void firestore(
    dynamic function, {
    required VoidCallback afterSuccess,
    String? loadingMsg,
  }) async {
    try {
      Popup.loading(label: loadingMsg);

      await function();

      Popup.terminateLoading();
      afterSuccess();
    } on FirebaseException catch (error) {
      Popup.terminateLoading();
      Popup.alert(error.code, error.message.toString());
    } catch (e) {
      Popup.terminateLoading();
      Popup.general();
    }
  }
}
