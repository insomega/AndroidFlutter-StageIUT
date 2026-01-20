import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/helper/GBSystem_snack_bar.dart';
import 'package:portail_salarie/GBSystem_X_Developpement/services/GBSystem_auth_service.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:portail_salarie/_RessourceStrings/GBSystem_Server_Strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EntrepriseService {
  //boubaker 13/01/2025 6146_2025_01_08_APK_Portail_salarie_affichage_ecran_code_entreprise_si_code_incorrect.mp4
  // Future<void>AccessUrlAndS19(BuildContext context,
  Future<bool> AccessUrlAndS19(BuildContext context,
      {required String agenceCode}) async {
    //boubaker 13/01/2025 6146_2025_01_08_APK_Portail_salarie_affichage_ecran_code_entreprise_si_code_incorrect.mp4
    bool EntrepriseCodeValide = false;
    await GBSystem_AuthService(context)
        .getSiteS19Client(clientName: agenceCode)
        .then(
      (value) async {
        print(value);
        //boubaker 13/01/2025 6146_2025_01_08_APK_Portail_salarie_affichage_ecran_code_entreprise_si_code_incorrect.mp4
        EntrepriseCodeValide = (value != null);
        if (value != null) {
          GbsSystemServerStrings.kMyBaseUrlStandard = value.SYSMENT_URL;
          GbsSystemServerStrings.kMyS19Standard = value.SYSMENT_S19 != null
              ? "${value.SYSMENT_URL}/BMServerR.dll/BMRest"
              : "";
          await SharedPreferences.getInstance().then((value2) {
            value2.setString(
                GbsSystemServerStrings.kS19, value.SYSMENT_S19 ?? "");
            value2.setString(GbsSystemServerStrings.kSiteWeb,
                "${value.SYSMENT_URL}/BMServerR.dll/BMRest");
            value2.setString(
                GbsSystemServerStrings.kClientName, value.SYSMENT_CODE);
          });
          showSuccesDialog(
              context, GbsSystemStrings.str_operation_effectuer.tr);
        } else {
          showErrorDialog(context,
              GbsSystemStrings.str_validat_svp_code_entreprise_invalid.tr);
        }
      },
    );
    //boubaker 13/01/2025 6146_2025_01_08_APK_Portail_salarie_affichage_ecran_code_entreprise_si_code_incorrect.mp4
    return EntrepriseCodeValide;

    // switch (agenceCode.toLowerCase()) {
    //   case "setif":
    //     {
    //       GbsSystemServerStrings.kClientNumber = "0";
    //       GbsSystemServerStrings.kMyBaseUrlStandard =
    //           "https://192.168.1.30:8010/BMServerR.dll/BMRest";
    //       GbsSystemServerStrings.kMyS19Standard = "";
    //       await SharedPreferences.getInstance().then((value) {
    //         value.setString(GbsSystemServerStrings.kS19, "");
    //         value.setString(GbsSystemServerStrings.kSiteWeb,
    //             "https://192.168.1.30:8010/BMServerR.dll/BMRest");
    //         value.setString(GbsSystemServerStrings.kClientName, "setif");
    //       });
    //     }
    //     break;
    //   case "setif2":
    //     {
    //       GbsSystemServerStrings.kClientNumber = "0";
    //       GbsSystemServerStrings.kMyBaseUrlStandard =
    //           "https://192.168.1.120/BMServerR.dll/BMRest";
    //       GbsSystemServerStrings.kMyS19Standard =
    //           "AF5BB23EE60F43C48DA4998C228578DF0AE9847AC8414FFDBB4B6ADBD361EEE86BCD6A91CDFC4AC2AA4BA0D767359F4D48D27623E658474B9385AF95247FC2DB";
    //       await SharedPreferences.getInstance().then((value) {
    //         value.setString(GbsSystemServerStrings.kS19,
    //             "AF5BB23EE60F43C48DA4998C228578DF0AE9847AC8414FFDBB4B6ADBD361EEE86BCD6A91CDFC4AC2AA4BA0D767359F4D48D27623E658474B9385AF95247FC2DB");
    //         value.setString(GbsSystemServerStrings.kSiteWeb,
    //             "https://192.168.1.120/BMServerR.dll/BMRest");
    //         value.setString(GbsSystemServerStrings.kClientName, "setif2");
    //       });
    //     }
    //     break;

    //   case "seris":
    //     {
    //       GbsSystemServerStrings.kClientNumber = "1";
    //       GbsSystemServerStrings.kMyBaseUrlStandard =
    //           "https://www.bmplanning.com/BMServerR.dll/BMRest";
    //       GbsSystemServerStrings.kMyS19Standard =
    //           "FF70DA1420C54D35A4B8EF7813E22F08973A983F329E4C4DB094B4D3C3173D2C8948947FBD6844B98E0C423C3A9A2CF2A66CFC1E8CCC428D8286EA2A32A47F89";
    //       await SharedPreferences.getInstance().then((value) {
    //         value.setString(GbsSystemServerStrings.kS19,
    //             "FF70DA1420C54D35A4B8EF7813E22F08973A983F329E4C4DB094B4D3C3173D2C8948947FBD6844B98E0C423C3A9A2CF2A66CFC1E8CCC428D8286EA2A32A47F89");
    //         value.setString(GbsSystemServerStrings.kSiteWeb,
    //             "https://www.bmplanning.com/BMServerR.dll/BMRest");
    //         value.setString(GbsSystemServerStrings.kClientName, "seris");
    //       });
    //     }
    //     break;

    //   case "demo":
    //     {
    //       GbsSystemServerStrings.kClientNumber = "2";
    //       GbsSystemServerStrings.kMyBaseUrlStandard =
    //           "https://www.bmplanning.com/BMServerR.dll/BMRest";
    //       GbsSystemServerStrings.kMyS19Standard =
    //           "AF5BB23EE60F43C48DA4998C228578DF0AE9847AC8414FFDBB4B6ADBD361EEE86BCD6A91CDFC4AC2AA4BA0D767359F4D48D27623E658474B9385AF95247FC2DB";
    //       await SharedPreferences.getInstance().then((value) {
    //         value.setString(GbsSystemServerStrings.kS19,
    //             "AF5BB23EE60F43C48DA4998C228578DF0AE9847AC8414FFDBB4B6ADBD361EEE86BCD6A91CDFC4AC2AA4BA0D767359F4D48D27623E658474B9385AF95247FC2DB");
    //         value.setString(GbsSystemServerStrings.kSiteWeb,
    //             "https://www.bmplanning.com/BMServerR.dll/BMRest");
    //         value.setString(GbsSystemServerStrings.kClientName, "demo");
    //       });
    //     }
    //     break;
    //   case "smart_ps":
    //     {
    //       GbsSystemServerStrings.kClientNumber = "3";
    //       GbsSystemServerStrings.kMyBaseUrlStandard =
    //           "https://www.bmplanning.com/BMServerR.dll/BMRest";
    //       GbsSystemServerStrings.kMyS19Standard =
    //           "D6F7933D1D8A4292AC06EE669A70FA8F6ABD5C3BAC7A488A9CB0371161E5DA8CCB88A1B6DB524BB8B26FDFC1AA2A1FE6578365F6E3EB459C8DE9E0FD2FA55DF6";
    //       await SharedPreferences.getInstance().then((value) {
    //         value.setString(GbsSystemServerStrings.kS19,
    //             "D6F7933D1D8A4292AC06EE669A70FA8F6ABD5C3BAC7A488A9CB0371161E5DA8CCB88A1B6DB524BB8B26FDFC1AA2A1FE6578365F6E3EB459C8DE9E0FD2FA55DF6");
    //         value.setString(GbsSystemServerStrings.kSiteWeb,
    //             "https://www.bmplanning.com/BMServerR.dll/BMRest");
    //         value.setString(GbsSystemServerStrings.kClientName, "smart_ps");
    //       });
    //     }
    //     break;
    //   case "maristelo_data":
    //     {
    //       GbsSystemServerStrings.kClientNumber = "4";
    //       GbsSystemServerStrings.kMyBaseUrlStandard =
    //           "https://www.bmplanning.com/BMServerR.dll/BMRest";
    //       GbsSystemServerStrings.kMyS19Standard =
    //           "6564328D57614B6AB3B1BB87B5D032D73A17A4E462224B88A59BBC83F37FEB10AFC349B63BEF47A58FC29CB48F226331123C933430DC4F2AAABAD18FA12825A1";
    //       await SharedPreferences.getInstance().then((value) {
    //         value.setString(GbsSystemServerStrings.kS19,
    //             "6564328D57614B6AB3B1BB87B5D032D73A17A4E462224B88A59BBC83F37FEB10AFC349B63BEF47A58FC29CB48F226331123C933430DC4F2AAABAD18FA12825A1");
    //         value.setString(GbsSystemServerStrings.kSiteWeb,
    //             "https://www.bmplanning.com/BMServerR.dll/BMRest");
    //         value.setString(
    //             GbsSystemServerStrings.kClientName, "maristelo_data");
    //       });
    //     }
    //     break;
    //   case "brinks":
    //     {
    //       GbsSystemServerStrings.kClientNumber = "5";
    //       GbsSystemServerStrings.kMyBaseUrlStandard =
    //           "https://bm-planning.brinks.lu/BMServerR.dll/BMRest";
    //       GbsSystemServerStrings.kMyS19Standard = "";
    //       await SharedPreferences.getInstance().then((value) {
    //         value.setString(GbsSystemServerStrings.kS19, "");
    //         value.setString(GbsSystemServerStrings.kSiteWeb,
    //             "https://bm-planning.brinks.lu/BMServerR.dll/BMRest");
    //         value.setString(GbsSystemServerStrings.kClientName, "brinks");
    //       });
    //     }
    //     break;

    //   case "brinks_test":
    //     {
    //       GbsSystemServerStrings.kClientNumber = "6";
    //       GbsSystemServerStrings.kMyBaseUrlStandard =
    //           "https://bmsoft-test.brinks.lu/BMServerR.dll/BMRest";
    //       GbsSystemServerStrings.kMyS19Standard = "";
    //       await SharedPreferences.getInstance().then((value) {
    //         value.setString(GbsSystemServerStrings.kS19, "");
    //         value.setString(GbsSystemServerStrings.kSiteWeb,
    //             "https://bmsoft-test.brinks.lu/BMServerR.dll/BMRest");
    //         value.setString(GbsSystemServerStrings.kClientName, "brinks_test");
    //       });
    //     }
    //     break;
    //   case "demo_test":
    //     {
    //       GbsSystemServerStrings.kClientNumber = "7";
    //       GbsSystemServerStrings.kMyBaseUrlStandard =
    //           "https://www.bmplanning.com:32625/BMServerR.dll/BMRest";
    //       GbsSystemServerStrings.kMyS19Standard =
    //           "AF5BB23EE60F43C48DA4998C228578DF0AE9847AC8414FFDBB4B6ADBD361EEE86BCD6A91CDFC4AC2AA4BA0D767359F4D48D27623E658474B9385AF95247FC2DB";
    //       await SharedPreferences.getInstance().then((value) {
    //         value.setString(GbsSystemServerStrings.kS19,
    //             "AF5BB23EE60F43C48DA4998C228578DF0AE9847AC8414FFDBB4B6ADBD361EEE86BCD6A91CDFC4AC2AA4BA0D767359F4D48D27623E658474B9385AF95247FC2DB");
    //         value.setString(GbsSystemServerStrings.kSiteWeb,
    //             "https://www.bmplanning.com:32625/BMServerR.dll/BMRest");
    //         value.setString(GbsSystemServerStrings.kClientName, "demo_test");
    //       });
    //     }
    //     break;
    //   case "onet":
    //     {
    //       GbsSystemServerStrings.kClientNumber = "8";
    //       GbsSystemServerStrings.kMyBaseUrlStandard =
    //           "https://www.bmplanning.com:32625/BMServerR.dll/BMRest";
    //       GbsSystemServerStrings.kMyS19Standard =
    //           "AEA31DFDCC9747759C9337860B532EE80C75FB4A4BD043CA978C55CC644482CDA0BD67B82D844F5F9D0E652E0452FB9DEE917992697E4DC6BFC0D91DEA31E8A2";
    //       await SharedPreferences.getInstance().then((value) {
    //         value.setString(GbsSystemServerStrings.kS19,
    //             "AEA31DFDCC9747759C9337860B532EE80C75FB4A4BD043CA978C55CC644482CDA0BD67B82D844F5F9D0E652E0452FB9DEE917992697E4DC6BFC0D91DEA31E8A2");
    //         value.setString(GbsSystemServerStrings.kSiteWeb,
    //             "https://www.bmplanning.com:32625/BMServerR.dll/BMRest");
    //         value.setString(GbsSystemServerStrings.kClientName, "onet");
    //       });
    //     }
    //     break;

    //   case "falck":
    //     {
    //       GbsSystemServerStrings.kClientNumber = "9";
    //       GbsSystemServerStrings.kMyBaseUrlStandard =
    //           "https://www.bmplanning.com/BMServerR.dll/BMRest";
    //       GbsSystemServerStrings.kMyS19Standard =
    //           "998C21AE51964A2497C072E98AF9721D3817DC5F11B84657983C438083F5EE7FE758EF4676774E0D916CBC487CAE3146A27B32A9207143A98535A3314C9F17E4";
    //       await SharedPreferences.getInstance().then((value) {
    //         value.setString(GbsSystemServerStrings.kS19,
    //             "998C21AE51964A2497C072E98AF9721D3817DC5F11B84657983C438083F5EE7FE758EF4676774E0D916CBC487CAE3146A27B32A9207143A98535A3314C9F17E4");
    //         value.setString(GbsSystemServerStrings.kSiteWeb,
    //             "https://www.bmplanning.com/BMServerR.dll/BMRest");
    //         value.setString(GbsSystemServerStrings.kClientName, "falck");
    //       });
    //     }
    //     break;
    // }
  }

  bool checkExisteClient({required String agenceCode}) {
    // List<String> allClient = [
    //   "setif",
    //   "setif_dev",
    //   "seris",
    //   "demo",
    //   "smart_ps",
    //   "maristelo_data",
    //   "brinks",
    //   "brinks_test",
    //   "demo_test",
    //   "onet",
    //   "falck"
    // ];
    // if (allClient.contains(agenceCode.toLowerCase())) {
    //   return true;
    // } else {
    //   return false;
    // }
    return true;
  }

  Future<String?> getCurrentClientName() async {
    String? name;
    await SharedPreferences.getInstance().then((value) {
      name = value.getString(GbsSystemServerStrings.kClientName);
    });
    return name;
  }
}
