import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/models/SERVER_MODELS/GBSystem_message_model.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';

class ChatBubleAdverse extends StatelessWidget {
  const ChatBubleAdverse({super.key, required this.message});
  final MessageModel message;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: size.width * 0.02, vertical: size.height * 0.02),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          GBSystem_TextHelper().smallText(text: message.USR_LIB ?? "" , 
          textColor: Colors.grey.shade400
          ),
          Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.04,
                          vertical: size.height * 0.015),
                      width: size.width * 0.6,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(12),
                            bottomRight: Radius.circular(12),
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GBSystem_TextHelper().smallText(
                            text: message.SYSUM_MESSAGE,
                            textColor: Colors.black,
                            maxLines: 20,
                            fontWeight: FontWeight.normal,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: GBSystem_TextHelper().smallText(
                                  text:
                                      "${message.SYSUM_SEND_DATE.day}/${message.SYSUM_SEND_DATE.month}/${message.SYSUM_SEND_DATE.year} ${message.SYSUM_SEND_DATE.hour}:${message.SYSUM_SEND_DATE.minute}:${message.SYSUM_SEND_DATE.second}",
                                  textColor: const Color(0xff808080),
                                  maxLines: 1,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                              Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.list_bullet,
                                    color: Colors.grey.shade600,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  GBSystem_TextHelper().smallText(
                                    text: "${message.SYSUM_MSG_TYPE}",
                                    textColor: Colors.grey.shade600,
                                    maxLines: 1,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Positioned(
                top: -12,
                left: -12,
                child: Container(
                  decoration: BoxDecoration(boxShadow: [
                    BoxShadow(
                      color: GbsSystemStrings.str_primary_color,
                      spreadRadius: -28,
                      blurRadius: 8,
                      offset: const Offset(0, 0), // changes the shadow position
                    ),
                  ]),
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: GbsSystemStrings.str_primary_color,
                    child: GBSystem_TextHelper().smallText(
                        text:
                        message.USR_LIB != null && message.USR_LIB!.length >= 2 ?
                            "${message.USR_LIB!.substring(0, 1).toUpperCase()}${message.USR_LIB!.substring(1,2 ).toUpperCase()}" : "",
                        textColor: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class ChatBubleMe extends StatelessWidget {
  const ChatBubleMe({super.key, required this.message, this.onDeleteTap});
  final MessageModel message;
  final void Function()? onDeleteTap;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
       
       
        Visibility(
          visible: message.SYSUM_READ_DATE==null,
          child: InkWell(
            onTap: onDeleteTap,
            child: Icon(CupertinoIcons.delete_solid , color: Colors.red,)),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.02, vertical: size.height * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: size.width * 0.02),
                child: Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.04, vertical: size.height * 0.015),
                  width: size.width * 0.6,
                  decoration: BoxDecoration(
                      color: Colors.grey.shade800,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                        bottomLeft: Radius.circular(12),
                      )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GBSystem_TextHelper().smallText(
                        text: message.SYSUM_MESSAGE,
                        textColor: Colors.white,
                        maxLines: 20,
                        fontWeight: FontWeight.normal,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            child: GBSystem_TextHelper().smallText(
                              text:
                                  "${message.SYSUM_SEND_DATE.day}/${message.SYSUM_SEND_DATE.month}/${message.SYSUM_SEND_DATE.year} ${message.SYSUM_SEND_DATE.hour}:${message.SYSUM_SEND_DATE.minute}:${message.SYSUM_SEND_DATE.second}",
                              textColor: const Color(0xff808080),
                              maxLines: 1,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Row(
                            children: [
                              Icon(
                                CupertinoIcons.list_bullet,
                                color: Colors.grey.shade600,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              GBSystem_TextHelper().smallText(
                                text: "${message.SYSUM_MSG_TYPE}",
                                textColor: Colors.grey.shade600,
                                maxLines: 1,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
