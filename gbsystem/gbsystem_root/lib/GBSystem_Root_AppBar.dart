import 'package:flutter/material.dart';
import 'package:gbsystem_root/GBSystem_ScreenHelper.dart';
import 'package:gbsystem_translations/GBSystem_Application_Strings.dart';
import 'package:gbsystem_root/GBSystem_System_Strings.dart';
import 'GBSystem_Root_Params.dart';

class GBSystem_Root_AppBar extends StatelessWidget implements PreferredSizeWidget {
  const GBSystem_Root_AppBar({
    super.key,
    this.onDeconnexionTap,
    this.actionsBuilder, // 👈 boutons personnalisés
  });

  final void Function()? onDeconnexionTap;
  final List<Widget> Function(BuildContext)? actionsBuilder; // 👈

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02),
        vertical: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.01),
      ),
      decoration: const BoxDecoration(
        color: GBSystem_Application_Strings.str_primary_color,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// Logo + titre
          Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                GBSystem_System_Strings.str_logo_image_path,
                width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.14),
                height: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.14),
                color: Colors.white,
              ),
              Transform.translate(
                offset: const Offset(2, -12),
                child: Text(
                  GBSystem_Application_Params_Manager.instance.Title,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),

          /// Boutons à droite
          Row(
            children: [
              ...(actionsBuilder?.call(context) ?? []), // 👈 On insère ici les boutons passés en paramètre
              InkWell(
                onTap: onDeconnexionTap,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(
                    Icons.logout_outlined,
                    color: Colors.white,
                    size: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.08),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(90);
}




// class GBSystem_Root_AppBar extends StatelessWidget implements PreferredSizeWidget {
//   //const GBSystem_Root_AppBar({super.key, required this.imageSalarie, required this.salarie, this.onDeconnexionTap});
//   const GBSystem_Root_AppBar({super.key, this.onDeconnexionTap});

//   // final String? imageSalarie;
//   // final GBSystem_Serveur_Info_Model? salarie;
//   final void Function()? onDeconnexionTap;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(
//           //
//           horizontal: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.02),
//           vertical: GBSystem_ScreenHelper.screenHeightPercentage(context, 0.01)),
//       decoration: const BoxDecoration(color: GBSystem_Application_Strings.str_primary_color),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.asset(
//                 //
//                 GBSystem_System_Strings.str_logo_image_path,
//                 width: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.14),
//                 height: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.14),
//                 color: Colors.white,
//               ),
//               Transform.translate(
//                 offset: const Offset(2, -12),
//                 child: Text(
//                   //GBSystem_Application_Strings.str_app_name,
//                   GBSystem_Application_Params_Manager.instance.Title,
//                   style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.white),
//                 ),
//               ),
//             ],
//           ),
//           InkWell(
//             onTap: onDeconnexionTap,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 10),
//               child: Icon(Icons.logout_outlined, color: Colors.white, size: GBSystem_ScreenHelper.screenWidthPercentage(context, 0.08)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   Size get preferredSize => const Size.fromHeight(90);

 
// }
