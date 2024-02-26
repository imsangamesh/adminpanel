import 'package:adminpanel/core/constants/constants.dart';
import 'package:adminpanel/core/constants/pref_keys.dart';
import 'package:adminpanel/core/error/app_error_handler.dart';
import 'package:adminpanel/core/themes/app_colors.dart';
import 'package:adminpanel/core/themes/app_text_styles.dart';
import 'package:adminpanel/core/utils/popup.dart';
import 'package:adminpanel/core/widgets/my_buttons.dart';
import 'package:adminpanel/core/widgets/my_dropdown_wrapper.dart';
import 'package:adminpanel/core/widgets/textfield_wrapper.dart';
import 'package:adminpanel/data/my_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateCoreData extends StatelessWidget {
  UpdateCoreData({super.key});

  final controller = TextEditingController();
  final options = ['Students', 'Faculties'];

  final selectedOption = 'Students'.obs;

  Future<void> updateDataToFirestore() async {
    if (controller.text.trim() == '') {
      Popup.alert(
        'Oops!',
        'Please input valid JSON data before proceeding',
      );
      return;
    }

    AppErrorHandler.firestore(
      () async {
        final querySnapshots = await fire.collection(FireKeys.students).get();
        for (var doc in querySnapshots.docs) {
          await doc.reference.delete();
        }

        const studentData = studentJson;
        WriteBatch studentsBatch = fire.batch();

        for (var each in studentData.entries) {
          final docRef = fire.collection(FireKeys.students).doc(each.key);
          studentsBatch.set(docRef, each.value);
        }

        fire.collection(selectedOption.value == 'Students'
            ? FireKeys.students
            : FireKeys.faculties);
        await studentsBatch.commit();
      },
      afterSuccess: () => Popup.snackbar('message'),
      loadingMsg: 'loading',
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: const Text('Update Core JSON Data')),
      body: Obx(
        () => GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),

              /// ------------------------------ `BODY`
              child: SizedBox(
                height: size.height - 80 - 40,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    /// ------------------------------ `SELECTOR DROP DOWN`
                    MyDropDownWrapper(
                      DropdownButton(
                        dropdownColor: AppColors.listTile,
                        underline: MyDropDownWrapper.transparentDivider,
                        isExpanded: true,
                        iconSize: 30,
                        icon: const Icon(Icons.arrow_drop_down),
                        value: selectedOption.value,
                        items: options
                            .map((String each) => DropdownMenuItem(
                                  value: each,
                                  child: Text(
                                    each,
                                    style: selectedOption() == each
                                        ? AppTStyles.button
                                        : null,
                                  ),
                                ))
                            .toList(),
                        onChanged: (String? newValue) =>
                            selectedOption(newValue!),
                      ),
                    ),

                    /// ------------------------------ `INPUT FIELD`
                    Expanded(
                      child: TextFieldWrapper(
                        TextField(
                          controller: controller,
                          expands: true,
                          maxLines: null,
                          textInputAction: TextInputAction.done,
                          decoration: InputDecoration(
                            hintText: '$selectedOption Json Data',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),

                    /// ------------------------------ `BODY`
                    MyElevatedBtn('Save', () => updateDataToFirestore())
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
