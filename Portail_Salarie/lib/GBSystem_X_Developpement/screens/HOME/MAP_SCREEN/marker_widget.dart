import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_text_helper.dart';

class MarkerWidget extends StatefulWidget {
  const MarkerWidget({
    super.key,
    required this.message,
  });

  final String message;

  @override
  State<MarkerWidget> createState() => _MarkerWidgetState();
}

class _MarkerWidgetState extends State<MarkerWidget> {
  bool markerLocationVisibility = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          markerLocationVisibility
              ? markerLocationVisibility = false
              : markerLocationVisibility = true;
        });
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            child: Icon(
              CupertinoIcons.location_solid,
              color: Colors.blueAccent,
              size: 40,
            ),
          ),
          Visibility(
            visible: markerLocationVisibility,
            child: Positioned(
              top: -25,
              left: -25,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    border: Border.all(width: 1, color: Colors.grey.shade200),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: -40,
                        blurRadius: 22,
                        offset:
                            const Offset(10, 40), // changes the shadow position
                      ),
                    ]),
                child: GBSystem_TextHelper().smallText(text: widget.message),
              ),
            ),
          )
        ],
      ),
    );
  }
}
