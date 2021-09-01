import 'package:oxen_driver/auth/auth_utils.dart';

import 'package:oxen_driver/flutter_flow/flutter_flow_theme.dart';
import 'package:oxen_driver/flutter_flow/flutter_flow_util.dart';

import 'package:oxen_driver/flutter_flow/flutter_flow_widgets.dart';
import 'package:oxen_driver/globals.dart';
import 'package:oxen_driver/models/ModelProvider.dart';
import 'package:oxen_driver/screens/company_completion_pages/company_account_completion_page_1.dart';
import 'package:oxen_driver/screens/completion_wait_page/completion_wait_page.dart';
import 'package:oxen_driver/screens/driver_account_completion_pages/driver_account_completion_page_1.dart';
import 'package:oxen_driver/screens/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oxen_driver/screens/role_selection_page/role_selection_page.dart';

class ConfirmLoginPageWidget extends StatefulWidget {
  const ConfirmLoginPageWidget({Key? key}) : super(key: key);

  @override
  _ConfirmLoginPageWidgetState createState() => _ConfirmLoginPageWidgetState();
}

class _ConfirmLoginPageWidgetState extends State<ConfirmLoginPageWidget> {
  TextEditingController? codeController;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    codeController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: FlutterFlowTheme.primaryColor,
        automaticallyImplyLeading: false,
        leading: Icon(
          Icons.chevron_left_rounded,
          color: FlutterFlowTheme.tertiaryColor,
          size: 32,
        ),
        title: Text(
          'Code Verification',
          style: FlutterFlowTheme.title2.override(
            fontFamily: 'Poppins',
            color: FlutterFlowTheme.tertiaryColor,
          ),
        ),
        actions: [],
        centerTitle: false,
        elevation: 0,
      ),
      backgroundColor: FlutterFlowTheme.primaryColor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 1,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF649EFC), Color(0xFFC6EAFF)],
            stops: [0, 1],
            begin: Alignment(0, -1),
            end: Alignment(0, 1),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: TextFormField(
                controller: codeController,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Enter the verification code',
                  labelStyle: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Poppins',
                    color: Color(0x98FFFFFF),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8),
                    ),
                  ),
                  filled: true,
                  fillColor: Color(0xFF3124A1),
                  contentPadding: EdgeInsets.fromLTRB(20, 24, 20, 24),
                ),
                style: FlutterFlowTheme.bodyText1.override(
                  fontFamily: 'Roboto',
                  color: FlutterFlowTheme.tertiaryColor,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
              child: FFButtonWidget(
                onPressed: () async {
                  if (codeController!.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Enter SMS verification code.'),
                      ),
                    );
                    return;
                  }

                  final phoneVerifiedUser =
                      await confirmUserLogin(codeController!.text);

                  if (!phoneVerifiedUser) {
                    return;
                  }

                  dynamic userModel;
                  switch (Globals.getRole()) {
                    case 'driver':
                      userModel = await pullUserModel();
                      if (userModel != null) Globals.setRider(userModel);
                      break;
                    case 'company':
                      userModel = await pullUserModel();
                      if (userModel != null) Globals.setCompany(userModel);
                      break;
                    default:
                      userModel = null;
                      break;
                  }

                  if (userModel != null) {
                    print(userModel.toString());

                    if (userModel.totalConfirmation) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomePageWidget(),
                          ),
                          (route) => false);
                    } else {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CompletionWaitPageWidget(),
                          ),
                          (route) => false);
                    }
                  } else {
                    print('no user model loaded');
                    if (Globals.getRole() == 'driver') {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                DriverAccountCompletionPage1Widget(),
                          ),
                          (route) => false);
                    } else if (Globals.getRole() == 'company') {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CompanyAccountCompletionPage1Widget(),
                          ),
                          (route) => false);
                    } else {
                      print(
                          "USER MODEL PREF ERROR: UNABLE TO DETERMINE ROLE - ${Globals.getRole()}");
                      userSignOut();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RoleSelectionPageWidget(),
                          ),
                          (route) => false);
                    }
                  }
                },
                text: 'Verify Code',
                options: FFButtonOptions(
                  width: 230,
                  height: 60,
                  color: FlutterFlowTheme.tertiaryColor,
                  textStyle: FlutterFlowTheme.subtitle2.override(
                    fontFamily: 'Poppins',
                    color: FlutterFlowTheme.primaryColor,
                  ),
                  elevation: 3,
                  borderSide: BorderSide(
                    color: Colors.transparent,
                    width: 1,
                  ),
                  borderRadius: 8,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
