import 'package:adminpanel/core/constants/constants.dart';

class PrefKeys {
  static const isDarkMode = 'IS_DARK_MODE';
  static const isUser = 'IS_USER';

  /// ========================== `FIRESTORE`
  static final authID = auth.currentUser!.uid;
}

class FireKeys {
  static const students = 'STUDENTS';
  static const faculties = 'FACULTIES';
  static const placementMsgs = 'PLACEMENT_MESSAGES';
  static const messages = 'MESSAGES';
}
