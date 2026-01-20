import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/APPLICATION_MODELS/GBSystem_image_with_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_image_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBSystem_question_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/screens/HOME/add_image_screen/GBSystem_add_image_controller.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/services/GBSystem_image_picker_service.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/custom_button.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_QUICK_ACCESS_WIDGETS/image_widget.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:get/get.dart';

class AddImageScreen extends StatefulWidget {
  AddImageScreen({
    super.key,
    required this.questionModel,
    required this.updateUI,
    this.isNonTerminatedEval = false,
  });
  final QuestionModel questionModel;
  final Function updateUI;
  final bool isNonTerminatedEval;

  @override
  State<AddImageScreen> createState() => _AddImageScreenState();
}

class _AddImageScreenState extends State<AddImageScreen> {
  bool showNewPhotoOrSelected = true;

  void myUpdateUi() {
    setState(() {});
  }

  @override
  void initState() {
    if (widget.isNonTerminatedEval) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        gePhotosAlreadyAdded();
      });
    }
    showNewPhotoOrSelected = true;
    super.initState();
  }

  void updateShowNew(bool showNew) {
    setState(() {
      showNewPhotoOrSelected = showNew;
    });
  }

  Future<void> gePhotosAlreadyAdded() async {
    final AddImageController m = Get.put(
        AddImageController(context, questionModel: widget.questionModel));
    m.isLoading.value = true;
    // clear list first
    m.listImages.value = [];
    await GBSystem_AuthService(context)
        .getListImagesQuestion(questionModel: widget.questionModel)
        .then(
      (value) async {
        if (value != null) {
          for (var i = 0; i < value.length; i++) {
            await GBSystem_AuthService(context)
                .getImageDataForEvalNonTerminer(image: value[i])
                .then(
              (imageServer) async {
                if (imageServer != null) {
                  await ImagePickerService(context)
                      .generateXFileFromBase64(imageServer.fileImage,
                          imageServer.imageModel.IMAGE_TYPE)
                      .then(
                    (value) {
                      m.listImages.value.add(ImageWithModel(
                          fileImage: value,
                          imageModel: ImageModel(
                              Image_DEFAULT:
                                  imageServer.imageModel.IMAGE_DEFAULT,
                              Image_DESCRIPTION: null,
                              Image_IDF: imageServer.imageModel.IMAGE_IDF,
                              Image_UIDF: imageServer.imageModel.IMAGE_IDF,
                              LAST_UPDT: imageServer.imageModel.LAST_UPDT,
                              USER_IDF: imageServer.imageModel.USER_IDF,
                              USR_LIB: null,
                              LIEINSPSVRQU_IDF: null)));
                    },
                  );
                }
              },
            );
          }
        }
      },
    );
    m.isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    final AddImageController m = Get.put(
        AddImageController(context, questionModel: widget.questionModel));

    return Obx(() => Stack(
          children: [
            Scaffold(
              appBar: AppBar(
                elevation: 4.0,
                shadowColor: Colors.grey.withOpacity(0.5),
                toolbarHeight: 80,
                backgroundColor: GbsSystemServerStrings.str_primary_color,
                title: const Text(
                  GbsSystemStrings.str_add_images,
                  style: TextStyle(color: Colors.white),
                ),
                leading: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      CupertinoIcons.arrow_left,
                      color: Colors.white,
                    )),
              ),
              body: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          width: GBSystem_ScreenHelper.screenWidthPercentage(
                              context, 0.8),
                          height: GBSystem_ScreenHelper.screenHeightPercentage(
                              context, 0.5),
                          clipBehavior: Clip.hardEdge,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.shade300,
                          ),
                          child: Obx(
                            () => showNewPhotoOrSelected
                                ? m.imageFile.value != null
                                    ? Image.file(
                                        File(m.imageFile.value!.path),
                                        fit: BoxFit.cover,
                                      )
                                    : Center(
                                        child: Icon(
                                        Icons.image,
                                        color: Colors.grey,
                                        size: GBSystem_ScreenHelper
                                            .screenWidthPercentage(
                                                context, 0.2),
                                      ))
                                : m.selectedImage.value != null
                                    ? Obx(
                                        () => Image.file(
                                          File(m.selectedImage.value!.fileImage
                                              .path),
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : Center(
                                        child: Icon(
                                        Icons.image,
                                        color: Colors.grey,
                                        size: GBSystem_ScreenHelper
                                            .screenWidthPercentage(
                                                context, 0.2),
                                      )),
                          )),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomIconButton(
                            onTap: () async {
                              try {
                                m.bottomSheetImage(
                                    context, myUpdateUi, updateShowNew);
                              } catch (e) {
                                m.isLoading.value = false;
                                GBSystem_ManageCatchErrors().catchErrors(
                                  context,
                                  message: e.toString(),
                                  method: "bottomSheetImage",
                                  page: "GBSystem_add_image_screen",
                                );
                              }
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            width: GBSystem_ScreenHelper.screenWidthPercentage(
                                context, 0.8),
                            height: 80,
                            child: Visibility(
                              visible: m.listImages.value.isNotEmpty,
                              child: ListView.builder(
                                physics: const BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: m.listImages.value.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      child: Obx(
                                        () => ImageWidget(
                                            onTap: () {
                                              m.selectedImage.value =
                                                  m.listImages.value[index];
                                              setState(() {
                                                showNewPhotoOrSelected = false;
                                              });
                                            },
                                            imageWithModel:
                                                m.listImages.value[index],
                                            isSelected: m.selectedImage.value
                                                    ?.imageModel.Image_IDF ==
                                                m.listImages.value[index]
                                                    .imageModel.Image_IDF),
                                      ));
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            vertical:
                                GBSystem_ScreenHelper.screenHeightPercentage(
                                    context, 0.02)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CustomIconButton(
                              onTap: () {
                                Get.back();
                              },
                              icon: const Icon(
                                CupertinoIcons.arrow_left,
                                color: Colors.white,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: GBSystem_ScreenHelper
                                      .screenWidthPercentage(context, 0.03)),
                              child: CustomIconButton(
                                onTap: () async {
                                  try {
                                    if (m.selectedImage.value != null) {
                                      await m.deleteImageFromServer(
                                          imageWithModel:
                                              m.selectedImage.value!,
                                          questionModel: widget.questionModel);
                                      widget.updateUI();
                                      if (m.listImages.value.isNotEmpty) {
                                        m.selectedImage.value =
                                            m.listImages.value.first;
                                        setState(() {
                                          showNewPhotoOrSelected = false;
                                        });
                                      } else {
                                        setState(() {
                                          m.selectedImage.value = null;
                                        });
                                      }
                                    } else {
                                      showWarningDialog(context,
                                          GbsSystemStrings.str_no_image);
                                    }
                                  } catch (e) {
                                    m.isLoading.value = false;
                                    GBSystem_ManageCatchErrors().catchErrors(
                                      context,
                                      message: e.toString(),
                                      method: "deleteImageFromServer",
                                      page: "GBSystem_add_image_screen",
                                    );
                                  }
                                },
                                icon: const Icon(
                                  CupertinoIcons.delete,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            CustomButton(
                              text: GbsSystemStrings.str_valider,
                              color: GbsSystemServerStrings.str_primary_color,
                              onTap: () async {
                                try {
                                  if (m.imageFile.value != null) {
                                    await m.sendImageToServer(
                                        myImageFile: m.imageFile.value!,
                                        questionModel: widget.questionModel);
                                    widget.updateUI();
                                    setState(() {
                                      showNewPhotoOrSelected = true;
                                    });
                                  } else {
                                    showWarningDialog(
                                        context,
                                        GbsSystemStrings
                                            .str_please_upload_image);
                                  }
                                } catch (e) {
                                  m.isLoading.value = false;
                                  GBSystem_ManageCatchErrors().catchErrors(
                                    context,
                                    message: e.toString(),
                                    method: "sendImageToServer",
                                    page: "GBSystem_add_image_screen",
                                  );
                                }
                              },
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            m.isLoading.value ? Waiting() : Container()
          ],
        ));
  }
}
