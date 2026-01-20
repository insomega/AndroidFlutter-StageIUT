import 'package:flutter/material.dart';
import 'package:gbsystem_root/GBSystem_button_entrer_sortie.dart';
import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';
import 'package:get/get.dart';
//import 'button_entrer_sortie.dart';

class VacationWidget extends Card {
  const VacationWidget({super.key, required this.numberVacation, this.onDemandeVacation, this.onSearchTap});

  final Rx<int?> numberVacation;
  final void Function()? onDemandeVacation, onSearchTap;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(width: 0.4, color: Colors.grey, style: BorderStyle.solid),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10, spreadRadius: 1)],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.04, vertical: size.width * 0.02),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Text(
                    numberVacation.value != null ? numberVacation.value.toString() : 0.toString(),
                    style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w500, color: Colors.green),
                  ),
                ),
                Text(
                  GBSystem_Application_Strings.vacation_proposer.tr,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.black),
                ),
                ButtonEntrerSortieWithIconAndText(
                  number: null,
                  onTap: onDemandeVacation,
                  verPadd: size.width * 0.01,
                  horPadd: size.width * 0.02,
                  icon: const Icon(Icons.done, color: Colors.white),
                  color: Colors.green,
                  text: GBSystem_Application_Strings.demander_vacation.tr,
                ),
              ],
            ),
            InkWell(
              onTap: onSearchTap,
              child: Icon(Icons.person_search_rounded, size: size.width * 0.15, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
