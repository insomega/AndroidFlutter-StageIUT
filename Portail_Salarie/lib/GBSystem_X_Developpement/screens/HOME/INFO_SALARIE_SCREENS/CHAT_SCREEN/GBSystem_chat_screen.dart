import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_ScreenHelper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_manage_catch_errors.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_waiting.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/screens/HOME/INFO_SALARIE_SCREENS/CHAT_SCREEN/GBSystem_chat_screen_controller.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/GENERAL_WIDGETS/GBSystem_custom_text_field.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/widgets/HOME_WIDGET/CHAT_WIDGETS/chat_buble.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class GBSystemChatScreen extends StatefulWidget {
  const GBSystemChatScreen(
      {super.key, this.isCommingFromOut = false, this.updateUI});
  final bool isCommingFromOut;
  final Function? updateUI;
  @override
  State<GBSystemChatScreen> createState() => _GBSystemChatScreenState();
}

class _GBSystemChatScreenState extends State<GBSystemChatScreen> {
  final ScrollController _scrollController = ScrollController();
  TextEditingController controllerMessage = TextEditingController();
  int page = 1, rows = 20;
  int? count;

  @override
  void initState() {
    m.isLoading.value = true;

    GBSystem_AuthService(context)
        .getListMessages(page: page, rows: rows, isDesc: true)
        .then(
      (value) {
        m.isLoading.value = false;
        m.messagesController.setAllMessage =
            value?.listMessages?.reversed.toList();
        count = value?.count;
        page++;
      },
    );
    _scrollController.addListener(_scrollListenner);

    scrollToBottom();

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListenner() async {
    if (_scrollController.hasClients &&
        _scrollController.positions.isNotEmpty &&
        _scrollController.position.pixels <=
            _scrollController.position.minScrollExtent &&
        !_scrollController.position.outOfRange) {
      print("min scroll");
      if (page <= (count ?? 1)) {
        await GBSystem_AuthService(context)
            .getListMessages(page: page, rows: 20, isDesc: true)
            .then(
          (value) {
            count = value?.count;
            value?.listMessages?.forEach(
              (element) {
                page++;
                m.messagesController.setMessageToLeft = element;
                setState(() {});
              },
            );
          },
        );
      }
    }
  }

  RxBool isFirstTimeLoad = RxBool(true);
  final m =
      Get.put<GBSystemChatScreenController>(GBSystemChatScreenController());

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        m.isLoading.value = true;
        await GBSystem_AuthService(context).getNombreNotiChat().then(
          (value) {
            m.isLoading.value = false;

            if (value != null) {
              m.notificationController.setNbrNoti = value;
            } else {
              m.notificationController.setNbrNoti = "";
            }
          },
        );

        return true;
      },
      child: Obx(
        () => Stack(
          children: [
            Scaffold(
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                centerTitle: true,
                elevation: 4.0,
                shadowColor: GbsSystemStrings.str_primary_color,
                toolbarHeight: 80,
                backgroundColor: GbsSystemStrings.str_primary_color,
                title: Text(
                  GbsSystemStrings.str_messagerie.tr,
                  style: TextStyle(color: Colors.white),
                ),
                leading: widget.isCommingFromOut
                    ? InkWell(
                        onTap: () async {
                          m.isLoading.value = true;

                          await GBSystem_AuthService(context)
                              .getNombreNotiChat()
                              .then(
                            (value) {
                              m.isLoading.value = false;

                              if (value != null) {
                                m.notificationController.setNbrNoti = value;
                              } else {
                                m.notificationController.setNbrNoti = "";
                              }
                            },
                          );
                          Get.back();
                        },
                        child: const Icon(
                          CupertinoIcons.arrow_left,
                          color: Colors.white,
                        ),
                      )
                    : Container(),
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: GBSystem_ScreenHelper.screenWidthPercentage(
                      context, 0.05),
                ),
                child: Column(
                  children: [
                    // FutureBuilder(
                    //   future: GBSystem_AuthService(context).getListMessages(),
                    //   builder: (context, snapshot) {
                    //     if (snapshot.connectionState ==
                    //         ConnectionState.waiting) {
                    //       return Expanded(child: WaitingWidgets());
                    //     } else if (snapshot.hasData) {
                    //       scrollToBottom();
                    //       if (isFirstTimeLoad.value) {
                    //         print("object");
                    //         m.messagesController.setAllMessage = snapshot.data!;
                    //         isFirstTimeLoad.value = false;
                    //       }

                    //       return Expanded(
                    //         child: Obx(
                    //           () => ListView.builder(
                    //             controller: _scrollController,
                    //             itemCount: m.messagesController.getAllMessages
                    //                 ?.value?.length,
                    //             itemBuilder: (context, index) => m
                    //                         .messagesController
                    //                         .getAllMessages
                    //                         ?.value?[index]
                    //                         .SEND_SVR_IDF ==
                    //                     // m.salarie?.salarieModel.SVR_IDF
                    //                     m.salarieController.getSalarie
                    //                         ?.salarieModel.SVR_IDF
                    //                 ? ChatBubleMe(
                    //                     onDeleteTap: () async {
                    //                       try {
                    //                         await GBSystem_AuthService(context)
                    //                             .deleteMessage(
                    //                                 messageModel: m
                    //                                     .messagesController
                    //                                     .getAllMessages!
                    //                                     .value![index])
                    //                             .then((value) {
                    //                           setState(() {});
                    //                           // print(value);
                    //                         });
                    //                       } catch (e) {
                    //                         GBSystem_ManageCatchErrors()
                    //                             .catchErrors(context,
                    //                                 message: e.toString(),
                    //                                 method: "onDeleteTap",
                    //                                 page:
                    //                                     "GBSystem_chat_screen");
                    //                       }
                    //                     },
                    //                     message: m.messagesController
                    //                         .getAllMessages!.value![index],
                    //                   )
                    //                 : ChatBubleAdverse(
                    //                     message: m.messagesController
                    //                         .getAllMessages!.value![index],
                    //                   ),
                    //           ),
                    //         ),
                    //       );
                    //     } else {
                    //       return Expanded(child: Container());
                    //     }
                    //   },
                    // ),

                    Obx(
                      () => Expanded(
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount: m
                              .messagesController.getAllMessages?.value?.length,
                          itemBuilder: (context, index) => m
                                      .messagesController
                                      .getAllMessages
                                      ?.value?[index]
                                      .SEND_SVR_IDF ==
                                  // m.salarie?.salarieModel.SVR_IDF
                                  m.salarieController.getSalarie?.salarieModel
                                      .SVR_IDF
                              ? ChatBubleMe(
                                  onDeleteTap: () async {
                                    try {
                                      await GBSystem_AuthService(context)
                                          .deleteMessage(
                                              messageModel: m
                                                  .messagesController
                                                  .getAllMessages!
                                                  .value![index])
                                          .then((value) {
                                        m.messagesController.deleteMessage(m
                                            .messagesController
                                            .getAllMessages!
                                            .value![index]);
                                        setState(() {});
                                      });
                                    } catch (e) {
                                      GBSystem_ManageCatchErrors().catchErrors(
                                          context,
                                          message: e.toString(),
                                          method: "onDeleteTap",
                                          page: "GBSystem_chat_screen");
                                    }
                                  },
                                  message: m.messagesController.getAllMessages!
                                      .value![index],
                                )
                              : ChatBubleAdverse(
                                  message: m.messagesController.getAllMessages!
                                      .value![index],
                                ),
                        ),
                      ),
                    ),

                    Column(
                      children: [
                        SizedBox(
                          height: 50,
                          child: ListView.builder(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: m.listItems.length,
                            itemBuilder: (context, index) {
                              return Obx(() => InkWell(
                                    onTap: () async {
                                      m.selectedItem?.value =
                                          m.listItems[index];
                                    },
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 400),
                                      margin: EdgeInsets.symmetric(
                                          vertical: GBSystem_ScreenHelper
                                              .screenHeightPercentage(
                                                  context, 0.01),
                                          horizontal: GBSystem_ScreenHelper
                                              .screenWidthPercentage(
                                                  context, 0.01)),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: GBSystem_ScreenHelper
                                              .screenWidthPercentage(
                                                  context, 0.04)),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: m.listItems[index] ==
                                                m.selectedItem?.value
                                            ? GbsSystemStrings.str_primary_color
                                            : Colors.grey.shade400
                                                .withOpacity(0.9),
                                      ),
                                      child: Center(
                                        child: GBSystem_TextHelper().smallText(
                                            textColor: Colors.white,
                                            text: m.listItems[index]
                                                .toString()
                                                .tr),
                                      ),
                                    ),
                                  ));
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        CustomTextFieldMessage(
                          controller: controllerMessage,
                          keyboardType: TextInputType.text,
                          text:
                              GbsSystemStrings.str_ecrire_votre_message_ici.tr,
                          suffixIcon: const Icon(
                            Icons.send,
                            color: Colors.black45,
                          ),
                          onSuffixTap: () async {
                            try {
                              if (m.selectedItem!.value.isNotEmpty) {
                                if (controllerMessage.text.isNotEmpty) {
                                  await GBSystem_AuthService(context)
                                      .sendMessage(
                                          messageString: controllerMessage.text,
                                          type: getSelectedTypeValue(
                                              m.selectedItem!.value))
                                      .then((value) async {
                                    controllerMessage.text = "";

                                    m.messagesController.setMessageToRight =
                                        value!.first;
                                    setState(() {});
                                    await Future.delayed(
                                            Duration(milliseconds: 600))
                                        .then((value) {
                                      _scrollController.animateTo(
                                          _scrollController
                                              .position.maxScrollExtent,
                                          duration: Duration(milliseconds: 300),
                                          curve: Curves.linear);
                                    });
                                  });
                                } else {
                                  showErrorDialog(
                                      context,
                                      GbsSystemStrings
                                          .svp_ecrire_un_message.tr);
                                }
                              } else {
                                showErrorDialog(context,
                                    GbsSystemStrings.svp_select_type.tr);
                              }
                            } catch (e) {
                              GBSystem_ManageCatchErrors().catchErrors(context,
                                  message: e.toString(),
                                  method: "onSendMessage(onSuffixTap)",
                                  page: "GBSystem_chat_screen");
                            }
                          },
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            m.isLoading.value ? Waiting() : Container()
          ],
        ),
      ),
    );
  }

  void scrollToBottom() {
    try {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients &&
            _scrollController.positions.isNotEmpty) {
          _scrollController.jumpTo(_scrollController.position.maxScrollExtent +
              GBSystem_ScreenHelper.screenHeightPercentage(context, 0.2));
        }
      });
    } catch (e) {
      GBSystem_ManageCatchErrors().catchErrors(context,
          message: e.toString(),
          method: "_scrollController.jumpTo",
          page: "GBSystem_chat_screen");
    }
  }

  String getSelectedTypeValue(String selectedType) {
    if (selectedType == GbsSystemStrings.str_prise_de_service.tr) {
      return "SVC";
    } else if (selectedType == GbsSystemStrings.str_vacation.tr) {
      return "VAC";
    } else if (selectedType == GbsSystemStrings.str_cloturer.tr) {
      return "CLO";
    } else if (selectedType == GbsSystemStrings.str_absence.tr) {
      return "ABS";
    } else if (selectedType == GbsSystemStrings.str_info.tr) {
      return "INF";
    } else {
      return "SVC";
    }
  }
}
