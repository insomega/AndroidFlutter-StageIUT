import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/APPLICATION_MODELS/GBSystem_image_with_model.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:image/image.dart' as img;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_question_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_image_picker_service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class AddImageController extends GetxController {
  AddImageController(this.context, {required this.questionModel});
  //params
  BuildContext context;
  QuestionModel questionModel;
//
  Rx<XFile?> imageFile = Rx<XFile?>(null);
  Rx<List<ImageWithModel>> listImages = Rx<List<ImageWithModel>>([]);
  Rx<Image?> picture = Rx<Image?>(null);
  Rx<ImageWithModel?> selectedImage = Rx<ImageWithModel?>(null);
  RxBool isLoading = RxBool(false);

  @override
  void onInit() {
    listImages.value = questionModel.listImages ?? [];
    super.onInit();
  }

  void bottomSheetImage(
      context, Function myUpdateUi, Function myUpdateShowNew) {
    Get.bottomSheet(
      backgroundColor: Colors.white,
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(CupertinoIcons.camera),
              title: const Text(
                GbsSystemStrings.str_from_camera,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.normal),
              ),
              onTap: () async {
                if (await ImagePickerService(context)
                        .cameraPermissionGranted() ==
                    false) {
                  Permission.camera.request();
                }
                if (await ImagePickerService(context)
                    .cameraPermissionGranted()) {
                  imageFile.value =
                      await ImagePickerService(context).pickImageFromCamera();

                  if (imageFile.value != null) {
                    picture.value = Image.file(File(imageFile.value!.path));
                    // myUpdateUi();

                    myUpdateShowNew(true);

                    Get.back();
                  }
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.image),
              title: const Text(
                GbsSystemStrings.str_from_gallerie,
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                    fontStyle: FontStyle.normal),
              ),
              onTap: () async {
                print(await ImagePickerService(context)
                    .storagePermissionGranted());
                if (await ImagePickerService(context)
                        .storagePermissionGranted() ==
                    false) {
                  Permission.storage.request();
                }
                if (await ImagePickerService(context)
                    .storagePermissionGranted()) {
                  imageFile.value =
                      await ImagePickerService(context).pickImageFromGallerie();

                  if (imageFile.value != null) {
                    picture.value = Image.file(File(imageFile.value!.path));
                    // myUpdateUi();
                    myUpdateShowNew(true);

                    Get.back();
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future sendImageToServer(
      {required XFile myImageFile,
      required QuestionModel questionModel}) async {
    isLoading.value = true;
    String base64Image = base64Encode(File(myImageFile.path).readAsBytesSync());
    String type = ImagePickerService(context).getFileType(myImageFile);
    String imgVign = await compressFile(myImageFile);
    // await generateThumbnail(myImageFile);

    await GBSystem_AuthService(context)
        .sendReponseImage(
            imageType: type,
            questionModel: questionModel,
            imageBytes: base64Image,
            imageVign: imgVign)
        .then((images) {
      if (images != null) {
        showSuccesDialog(context, GbsSystemStrings.str_image_added);

        listImages.value
            .add(ImageWithModel(fileImage: myImageFile, imageModel: images[0]));
        //new
        questionModel.listImages = listImages.value;

        // imageFile.value = null;
        isLoading.value = false;

        questionModel.nombreImages = listImages.value.length;
        questionModel.questionWithoutMemoModel.NBR_PHOTO =
            listImages.value.length.toString();
      } else {
        isLoading.value = false;

        showErrorDialog(context, GbsSystemStrings.str_image_not_added);
      }
    });
  }

  Future deleteImageFromServer(
      {required ImageWithModel imageWithModel,
      required QuestionModel questionModel}) async {
    isLoading.value = true;
    await GBSystem_AuthService(context)
        .sendReponseDeleteImage(
            questionModel: questionModel, imageModel: imageWithModel.imageModel)
        .then((images) {
      if (images != null) {
        int index = listImages.value.indexOf(imageWithModel);
        listImages.value.removeAt(index);
        //new
        questionModel.listImages = listImages.value;

        isLoading.value = false;
        showSuccesDialog(context, GbsSystemStrings.str_image_deleted);
        questionModel.nombreImages = listImages.value.length;
        questionModel.questionWithoutMemoModel.NBR_PHOTO =
            listImages.value.length.toString();
      } else {
        isLoading.value = false;

        showErrorDialog(context, GbsSystemStrings.str_image_not_deleted);
      }
    });
  }

  Future<String> compressFile(XFile file) async {
    // Get the temporary directory to store the compressed file
    final tempDir = await getTemporaryDirectory();
    final tempPath =
        '${tempDir.path}/compressed_image.png'; // You can choose a different file name or extension

    var result = await FlutterImageCompress.compressWithFile(
      file.path,
      quality: 10,
    );

    // Write the compressed image to the temporary file
    final compressedFile = File(tempPath)..writeAsBytesSync(result!);

    // Read the image bytes
    List<int> imageBytes = await File(compressedFile.path).readAsBytes();

    // Decode the image using the image package
    img.Image originalImage = img.decodeImage(Uint8List.fromList(imageBytes))!;

    // Encode the thumbnail as base64
    List<int> thumbnailBytes = img.encodePng(originalImage);
    String base64Thumbnail = base64Encode(thumbnailBytes);

    // Return the new XFile pointing to the compressed image
    return base64Thumbnail;
  }

  Future<String> generateThumbnail(XFile imageFile) async {
    // Read the image bytes
    List<int> imageBytes = await File(imageFile.path).readAsBytes();

    // Decode the image using the image package
    img.Image originalImage = img.decodeImage(Uint8List.fromList(imageBytes))!;

    print("orig width ${originalImage.width}");
    print("orig height ${originalImage.height}");

    print("new width ${(originalImage.width * 0.1).toInt()}");
    print("new height ${(originalImage.height * 0.1).toInt()}");

    // Resize the image to create a thumbnail
    img.Image thumbnail = img.copyResize(
      originalImage,
      width: (originalImage.width * 0.1).toInt(), //50,
      height: (originalImage.height * 0.1).toInt(), // 50
    );

    // Encode the thumbnail as base64
    List<int> thumbnailBytes = img.encodePng(thumbnail);
    String base64Thumbnail = base64Encode(thumbnailBytes);

    return base64Thumbnail;
  }
}
