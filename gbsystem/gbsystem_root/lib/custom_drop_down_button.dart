import 'package:flutter/material.dart';
//import 'GBSystem_planning_dispo_model.dart';
//import 'GBSystem_AjoutGBSystem_convert_date_service.dart';
import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';
import 'package:gbsystem_translations/GBSystem_translation_strings.dart';

class CustomDropDownButtonString extends StatelessWidget {
  const CustomDropDownButtonString({super.key, required this.selectedItem, required this.listItems, required this.hint, this.onChanged, this.validator, this.onTap, this.width});
  final double? width;
  final String? selectedItem;
  final List<String?>? listItems;
  final String hint;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: width,
      padding: EdgeInsets.all(size.width * 0.01),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
          onTap: onTap,
          decoration: const InputDecoration(border: InputBorder.none),
          validator: validator,
          isExpanded: true,
          hint: selectedItem == null ? Center(child: Text(hint)) : Text(selectedItem!),
          initialValue: selectedItem,
          items: listItems?.map(
                    (item) => DropdownMenuItem<String>(
                      value: item,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [Text(item!, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500))],
                      ),
                    ),
                  )
                  .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class CustomDropDownSelectLanguage extends StatelessWidget {
  const CustomDropDownSelectLanguage({super.key, required this.selectedItem, required this.onChanged});

  final String? selectedItem;
  final void Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: DropdownButton<String>(
          value: selectedItem,
          underline: Container(height: 0, color: Colors.transparent),
          isDense: true,
          items: GBSystem_Translation_Strings.languages.map((lang) {
            final code = lang['code']!;
            final flag = lang['flag']!;
            return DropdownMenuItem<String>(
              value: code,
              child: Row(
                children: [
                  Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Image.asset(
                        'assets/images/flags/$flag',
                        width: 25,
                        height: 25,
                      )),
                  Text(code),
                ],
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

class CustomDropDownButtonTypeMessage extends StatelessWidget {
  const CustomDropDownButtonTypeMessage(
      {super.key, //
      required this.selectedItem,
      required this.listItems,
      required this.hint,
      this.onChanged,
      this.validator,
      this.onTap,
      this.width});
  final double? width;
  final String? selectedItem;
  final List<String?>? listItems;
  final String hint;
  final void Function()? onTap;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      width: width,
      padding: EdgeInsets.all(size.width * 0.01),
      decoration: BoxDecoration(
        color: GBSystem_Application_Strings.str_primary_color.withOpacity(0.5),
        border: Border.all(color: Colors.black, width: 1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButtonFormField<String>(
          onTap: onTap,
          decoration: const InputDecoration(border: InputBorder.none),
          validator: validator,
          isExpanded: true,
          hint: selectedItem == null
              ? Center(
                  child: Text(hint, style: const TextStyle(color: Colors.black)),
                )
              : Text(selectedItem!, style: const TextStyle(color: Colors.black)),
          initialValue: selectedItem,
          items: listItems?.map(
                    (item) => DropdownMenuItem<String>(
                      value: item,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            item!,
                            style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

// class CustomDropDownButtonNombreJourMax extends StatelessWidget {
//   const CustomDropDownButtonNombreJourMax({
//     super.key,
//     required this.selectedItem,
//     required this.listItems,
//     required this.hint,
//     this.onChanged,
//     this.validator,
//     this.onTap,
//     this.width,
//   });
//   final double? width;
//   final NombreJourMaxModel? selectedItem;
//   final List<NombreJourMaxModel?>? listItems;
//   final String hint;
//   final void Function()? onTap;
//   final String? Function(NombreJourMaxModel?)? validator;
//   final void Function(NombreJourMaxModel?)? onChanged;
//   @override
//   Widget build(BuildContext context) {
//     var size = MediaQuery.of(context).size;
//     return Container(
//       width: width,
//       padding: EdgeInsets.all(size.width * 0.01),
//       decoration: BoxDecoration(
//           color: Colors.white,
//           border: Border.all(color: Colors.black, width: 1),
//           borderRadius: BorderRadius.circular(12)),
//       child: DropdownButtonHideUnderline(
//         child: DropdownButtonFormField<NombreJourMaxModel>(
//             onTap: onTap,
//             decoration: const InputDecoration(border: InputBorder.none),
//             validator: validator,
//             isExpanded: true,
//             hint: selectedItem == null
//                 ? Center(child: Text(hint))
//                 : Text(selectedItem!.),
//             value: selectedItem,
//             items: listItems != null
//                 ? listItems!
//                     .map((item) => DropdownMenuItem<String>(
//                           value: item,
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 item!,
//                                 style: const TextStyle(
//                                     fontSize: 18, fontWeight: FontWeight.w500),
//                               ),
//                             ],
//                           ),
//                         ))
//                     .toList()
//                 : null,
//             onChanged: onChanged),
//       ),
//     );
//   }
// }
