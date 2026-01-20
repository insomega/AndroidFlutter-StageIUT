import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';

class TypeDocumentWidget extends StatelessWidget {
  const TypeDocumentWidget(
      {super.key,
      required this.color,
      this.onAddTap,
      required this.text,
      required this.number,
      this.onTap,
      this.width});

  final Color color;
  final void Function()? onAddTap, onTap;
  final String text;
  final int number;
  final double? width;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 1,
              ),
            ],
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1, color: color),
            color: Colors.white),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    InkWell(
                        onTap: onAddTap,
                        child: Icon(
                          CupertinoIcons.add,
                          color: Colors.black54,
                        )),
                    SizedBox(
                      width: 10,
                    ),
                    GBSystem_TextHelper().smallText(
                        text: text,
                        maxLines: 2,
                        textColor: color,
                        fontWeight: FontWeight.bold),
                    SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              top: -20,
              right: -25,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100), color: color),
                child: Center(
                    child: GBSystem_TextHelper().smallText(
                        text: number.toString(), textColor: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
