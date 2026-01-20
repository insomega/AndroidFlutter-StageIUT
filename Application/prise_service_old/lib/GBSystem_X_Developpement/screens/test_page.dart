import 'package:flutter/material.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/APPLICATION_MODELS/GBSystem_salarie_photo_causerie_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/models/QUICK_ACCESS_MODELS/SERVER_MODEL/GBsystem_salarie_causerie_model.dart';
import 'package:gbs_new_project/GBSystem_X_Developpement/widgets/HOME_QUICK_ACCESS_WIDGETS/signature_causerie_widget.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Application_Strings.dart';
import 'package:gbs_new_project/_RessourceStrings/GBSystem_Server_Strings.dart';

class TestPage extends StatefulWidget {
  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Switch & Visibility Example'),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: new SignatureCauserieWidget(
              updateLoading: (p0) {
                print("loading");
              },
              isViewMode: false,
              previousSignature: null,
              causerieModel: null,
              salarie: GBSystemSalarieWithPhotoCauserieModel(
                  salarieCauserieModel: SalarieCuaserieModel(
                      SVR_IDF: "SVR_IDF",
                      SVR_CODE: "SVR_CODE",
                      SVR_LIB: "SVR_LIB",
                      ROW_ID: "ROW_ID",
                      VAC_END_HOUR: DateTime.now(),
                      VAC_START_HOUR: DateTime.now()),
                  imageSalarie: null)),
        ));
  }
}
