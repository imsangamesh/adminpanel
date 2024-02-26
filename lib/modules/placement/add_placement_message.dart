import 'dart:io';

import 'package:adminpanel/core/constants/constants.dart';
import 'package:adminpanel/core/constants/pref_keys.dart';
import 'package:adminpanel/core/themes/app_colors.dart';
import 'package:adminpanel/core/themes/app_text_styles.dart';
import 'package:adminpanel/core/utils/popup.dart';
import 'package:adminpanel/core/utils/upload_file_controller.dart';
import 'package:adminpanel/core/widgets/my_dropdown_wrapper.dart';
import 'package:adminpanel/core/widgets/textfield_wrapper.dart';
import 'package:adminpanel/models/placement_msg_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AddPlacementMessage extends StatelessWidget {
  AddPlacementMessage({super.key});

  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();

  final _currentYear = 'First Year'.obs;
  final _years = ['First Year', 'Second Year', 'Third Year', 'Final Year'];

  final _attachImages = false.obs;
  final RxList<XFile> images = RxList([]);
  final RxList<Map<String, String>> imageUrls = RxList([]);

  final _attachFiles = false.obs;
  final RxList<PlatformFile> files = RxList([]);
  final RxList<Map<String, String>> fileUrls = RxList([]);

  /// - - - - - - - - - - - - - - - - - - - - - - - - - `IMAGES`
  pickImages() async {
    final result = await ImagePicker().pickMultiImage();

    if (result.isEmpty) {
      Popup.snackbar('you didn\'t pick any images', status: false);
      _attachImages(false);
      return;
    }
    images(result);
  }

  Future<bool> uploadImages(List<XFile> uploadImages) async {
    final imageFiles = uploadImages.map((e) => File(e.path)).toList();
    final urls = await UploadFileController.multiple(imageFiles);

    if (urls == null || urls.isEmpty) return false;

    imageUrls(urls);
    return true;
  }

  /// - - - - - - - - - - - - - - - - - - - - - - - - - `FILES`
  pickFiles() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
      allowMultiple: true,
    );
    if (result == null) {
      Popup.snackbar('you didn\'t pick any files', status: false);
      _attachFiles(false);
      return;
    }
    files(result.files);
  }

  Future<bool> uploadFiles(List<PlatformFile> uploadfiles) async {
    final files = uploadfiles.map((e) => File(e.path!)).toList();
    final urls = await UploadFileController.multiple(files);

    if (urls == null || urls.isEmpty) return false;

    fileUrls(urls);
    return true;
  }

  /// - - - - - - - - - - - - - - - - - - - - - - - - - `SUBMIT`
  uploadAndUpdateMessage() async {
    if (_bodyController.text.trim() == '') {
      Popup.alert(
        'Oops !',
        'hey, please fill out your new message before you submit.',
      );
      return;
    }

    try {
      if (_attachFiles()) {
        if (!await uploadFiles(files)) {
          Popup.general();
          return;
        }
      }
      if (_attachImages()) {
        if (!await uploadImages(images)) {
          Popup.general();
          return;
        }
      }

      final messageModel = PlacementMsgModel(
        id: timeId,
        title: _titleController.text,
        description: _bodyController.text,
        date: DateTime.now().toIso8601String(),
        year: _currentYear(),
        links: [],
        imageUrls: imageUrls,
        fileUrls: fileUrls,
        createdAt: Timestamp.now(),
      );

      Popup.loading(label: 'updating message');

      await fire
          .collection(FireKeys.placementMsgs)
          .doc(_currentYear.value)
          .collection(FireKeys.messages)
          .doc(messageModel.id)
          .set(messageModel.toMap());

      Popup.terminateLoading();
      Get.back(); // closing message-type screen
      Popup.snackbar('new message added!', status: true);
    } on FirebaseException catch (e) {
      Popup.terminateLoading();
      Popup.alert(e.code, e.message.toString());
    } catch (e) {
      Popup.terminateLoading();
      Popup.general();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Add new message')),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Obx(
              () => Column(
                children: [
                  const SizedBox(height: 3),

                  /// -------------------------------------- `title`
                  TextFieldWrapper(
                    TextField(
                      controller: _titleController,
                      maxLines: 1,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        hintText: 'Title',
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  /// --------------------------------------- `description`
                  TextFieldWrapper(
                    TextField(
                      controller: _bodyController,
                      maxLines: 15,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        hintText: 'Content',
                        border: InputBorder.none,
                      ),
                    ),
                  ),

                  MyDropDownWrapper(
                    DropdownButton(
                      dropdownColor: AppColors.listTile,
                      underline: MyDropDownWrapper.transparentDivider,
                      isExpanded: true,
                      iconSize: 30,
                      icon: const Icon(Icons.arrow_drop_down),
                      value: _currentYear(),
                      items: _years
                          .map((String each) => DropdownMenuItem(
                                value: each,
                                child: Text(
                                  '  $each',
                                  style: _currentYear() == each
                                      ? AppTStyles.button
                                      : null,
                                ),
                              ))
                          .toList(),
                      onChanged: (String? newValue) => _currentYear(newValue!),
                    ),
                  ),

                  /// --------------------------------------- `image check box`
                  CheckboxListTile(
                    title: const Text('Attach Images?'),
                    tileColor: AppColors.listTile,
                    value: _attachImages(),
                    onChanged: (val) {
                      _attachImages(val ?? false);
                      if (val == false) {
                        images.clear();
                      } else {
                        pickImages();
                      }
                    },
                  ),
                  if (images.isNotEmpty)
                    SizedBox(
                      width: double.infinity,
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.start,
                        children: images
                            .map((each) => Container(
                                  margin:
                                      const EdgeInsets.only(right: 5, top: 5),
                                  height: 50,
                                  width: 50,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.file(File(each.path),
                                        fit: BoxFit.cover),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  const SizedBox(height: 15),

                  /// --------------------------------------- `file check box`
                  CheckboxListTile(
                    title: const Text('Attach Files?'),
                    tileColor: AppColors.listTile,
                    value: _attachFiles(),
                    onChanged: (val) {
                      _attachFiles(val ?? false);
                      if (val == false) {
                        files.clear();
                      } else {
                        pickFiles();
                      }
                    },
                  ),
                  const SizedBox(height: 5),
                  if (files.isNotEmpty)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text('  ${files.length} files selected'),
                    ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: uploadAndUpdateMessage,
          label: Text('Send Message', style: AppTStyles.button),
        ),
      ),
    );
  }
}
