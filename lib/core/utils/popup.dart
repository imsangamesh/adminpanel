import 'package:adminpanel/core/themes/app_colors.dart';
import 'package:adminpanel/core/themes/app_text_styles.dart';
import 'package:adminpanel/core/widgets/my_buttons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Popup {
  //
  static void general() {
    alert(
      'Oops',
      'Sorry, something went wrong, please report us while We work on it.',
    );
  }

  /// ---------------------------------------------------------------- `EMPTY LIST`
  static Widget nill(String text) {
    return SizedBox(
      height: 150,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.bubble_chart_outlined, size: 30),
            const SizedBox(height: 5),
            Text(
              text,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  /// ---------------------------------------------------------------- `ALERT`
  static void alert(String title, String description, {bool? isDismissable}) {
    Get.defaultDialog(
      backgroundColor: AppColors.scaffold,
      barrierDismissible: isDismissable ?? true,
      //
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ----------------- title
          Padding(
            padding: const EdgeInsets.fromLTRB(7, 7, 7, 2),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      title,
                      style: GoogleFonts.quicksand(
                        textStyle: AppTStyles.heading.copyWith(
                          color: AppColors.prim,
                        ),
                      ),
                    ),
                  ),
                ),
                const MyCloseBtn()
              ],
            ),
          ),
          const Divider(color: AppColors.prim),
          // ----------------- description
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 15),
            child: Text(description, style: AppTStyles.body),
          ),
          // ----------------- button
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 5, 18, 0),
            child: SizedBox(
              width: double.infinity,
              child: MyOutlinedBtn(
                'Got it',
                () => Get.back(),
                radius: 15,
              ),
            ),
          ),
        ],
      ),
      //
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      titlePadding: EdgeInsets.zero,
      //
      middleText: '',
      middleTextStyle: const TextStyle(fontSize: 0),
      contentPadding: EdgeInsets.zero,
      //
    );
  }

  /// ---------------------------------------------------------------- `confirm`
  static void confirm(
    String title,
    String description, {
    required VoidCallback yesFun,
    bool? isDismissable = true,
    VoidCallback? noFun,
  }) {
    Get.defaultDialog(
      backgroundColor: AppColors.scaffold,
      barrierDismissible: isDismissable ?? true,
      //
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ----------------- title
          Padding(
            padding: const EdgeInsets.fromLTRB(7, 7, 7, 2),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      title,
                      style: GoogleFonts.quicksand(
                        textStyle: AppTStyles.heading.copyWith(
                          color: AppColors.prim,
                        ),
                      ),
                    ),
                  ),
                ),
                if (isDismissable == true) const MyCloseBtn()
              ],
            ),
          ),
          const Divider(color: AppColors.prim),
          // ----------------- description
          Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 15, 15),
            child: Text(description, style: AppTStyles.body),
          ),
          // ----------------- buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(width: 10),
                Expanded(
                  child: MyOutlinedBtn(
                    'Nope',
                    noFun ?? () => Get.back(),
                    icon: Icons.close_rounded,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 10, left: 10),
                  child: Text('|'),
                ),
                Expanded(
                  child: MyOutlinedBtn('Yup ', () {
                    Get.back();
                    yesFun();
                  }, icon: Icons.check_rounded),
                ),
                const SizedBox(width: 10),
              ],
            ),
          )
        ],
      ),
      //
      title: '',
      titleStyle: const TextStyle(fontSize: 0),
      titlePadding: EdgeInsets.zero,
      //
      middleText: '',
      middleTextStyle: const TextStyle(fontSize: 0),
      contentPadding: EdgeInsets.zero,
      //
    );
  }

  /// ---------------------------------------------------------------- `snack bar`
  static void snackbar(String message, {bool? status}) {
    Color myColor(int a) => status == null
        ? const Color(0xFFFFEBAF)
        : status
            ? const Color(0xFF79F17D)
            : const Color(0xFFE9746C);

    Get.showSnackbar(
      GetSnackBar(
        padding: const EdgeInsets.all(0),
        messageText: Container(
          padding: const EdgeInsets.symmetric(vertical: 7),
          decoration: BoxDecoration(
            color: myColor(170),
            borderRadius: BorderRadius.circular(5),
            border: Border.all(color: myColor(255)),
          ),
          child: Center(
            child: Text(
              message,
              style: AppTStyles.smallCaption.copyWith(
                overflow: TextOverflow.ellipsis,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        backgroundColor: Colors.transparent,
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
        duration: const Duration(milliseconds: 2000),
        isDismissible: false,
      ),
    );
  }

  /// ---------------------------------------------------------------- `loading`
  static void loading({String? label}) {
    Get.dialog(
      WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            bottom: label == null
                ? null
                : PreferredSize(
                    preferredSize: const Size(double.infinity, 30),
                    child: Container(
                      height: 30,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: AppColors.prim,
                        border: Border(
                          top: BorderSide(
                              color: AppColors.darkScaffoldBG, width: 2),
                          bottom: BorderSide(
                              color: AppColors.darkScaffoldBG, width: 2.5),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          label,
                          style:
                              const TextStyle(color: AppColors.darkScaffoldBG),
                        ),
                      ),
                    ),
                  ),
          ),
          body: LinearProgressIndicator(
            backgroundColor: AppColors.prim.withAlpha(50),
          ),
          // Column(
          //   mainAxisSize: MainAxisSize.max,
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   children: [
          //     const LinearProgressIndicator(),
          //     const Spacer(),
          //     CircleAvatar(
          //       radius: 22,
          //       backgroundColor: MyColors.prim.withAlpha(50),
          //       child: const Padding(
          //         padding: EdgeInsets.all(10),
          //         child: CircularProgressIndicator(
          //           strokeWidth: 5,
          //           color: MyColors.prim,
          //         ),
          //       ),
          //     ),
          //     const Spacer(),
          //   ],
          // ),
        ),
      ),
      barrierColor: AppColors.prim.withAlpha(10),
    );
  }

  static void terminateLoading() => Get.back();

  static Widget imageLoader(String imageUrl,
      {BoxFit? fit, double? height, double? width}) {
    return Image.network(
      imageUrl,
      fit: fit,
      height: height,
      width: width,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: SizedBox(
            child: SizedBox(
              width: 40,
              height: 40,
              child: CircularProgressIndicator(
                strokeWidth: 1.5,
                value: loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!,
              ),
            ),
          ),
        );
      },
    );
  }
}
