import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_WIDGET/GBSystem_button_entrer_sortie.dart';

class VacationWidget extends StatelessWidget {
  const VacationWidget({
    super.key,
    required this.numberVacation,
    this.onDemandeVacation, this.onSearchTap,
  });

  final int numberVacation;
  final void Function()? onDemandeVacation,onSearchTap;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
      child: Container(
        height: 180,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            border: Border.all(
                width: 0.4, color: Colors.grey, style: BorderStyle.solid),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: -40,
                blurRadius: 22,
                offset: const Offset(10, 40), // changes the shadow position
              ),
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: -40,
                blurRadius: 22,
                offset: const Offset(-10, -40), // changes the shadow position
              ),
            ]),
        child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: size.width * 0.02,
              vertical: size.width * 0.02,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      numberVacation.toString(),
                      style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w500,
                          color: Colors.green),
                    ),
                    const Text(
                      "Vacation Proposées",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black),
                    ),
                    ButtonEntrerSortieWithIconAndText(
                      number: null,
                      onTap: onDemandeVacation,
                      verPadd: size.width * 0.01,
                      horPadd: size.width*0.01,
                      icon: const Icon(
                        Icons.done,
                        color: Colors.white,
                      ),
                      color: Colors.green,
                      text: "Demander une vacation",
                    )
                  ],
                ),
                InkWell(
                  onTap: onSearchTap,
                  child: Icon(
                    Icons.person_search_rounded,
                    size: size.width * 0.15,
                    color: Colors.green,
                  ),
                )
              ],
            )),
      ),
    );
  }
}
