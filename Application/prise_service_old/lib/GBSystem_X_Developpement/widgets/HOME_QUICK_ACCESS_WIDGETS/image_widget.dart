import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/APPLICATION_MODELS/GBSystem_image_with_model.dart';

import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget(
      {super.key,
      required this.imageWithModel,
      required this.isSelected,
      this.showBorder = true,
      this.onTap});
  final ImageWithModel imageWithModel;
  final bool isSelected, showBorder;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return showBorder
        ? InkWell(
            onTap: onTap,
            child: Container(
              height: 85,
              width: 85,
              padding: const EdgeInsets.all(3),
              clipBehavior: Clip.none,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: isSelected
                    ? GbsSystemServerStrings.str_primary_color
                    : Colors.transparent,
              ),
              child: Container(
                height: 80,
                width: 80,
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.shade300,
                ),
                child: Image.file(
                  File(imageWithModel.fileImage.path),
                  fit: BoxFit.cover,
                ),
              ),
            ))
        : Image.file(
            File(imageWithModel.fileImage.path),
            fit: BoxFit.cover,
          );
  }
}
