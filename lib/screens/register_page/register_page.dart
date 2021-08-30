import 'package:oxen_driver/auth/auth_utils.dart';
import 'package:oxen_driver/screens/confirm_login_page/confirm_login_page.dart';

import 'package:oxen_driver/flutter_flow/flutter_flow_theme.dart';
import 'package:oxen_driver/flutter_flow/flutter_flow_util.dart';
import 'package:oxen_driver/flutter_flow/flutter_flow_widgets.dart';
import 'package:oxen_driver/globals.dart';

import 'package:oxen_driver/screens/login_page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPageWidget extends StatefulWidget {
  RegisterPageWidget({Key? key}) : super(key: key);

  @override
  _RegisterPageWidgetState createState() => _RegisterPageWidgetState();
}

class _RegisterPageWidgetState extends State<RegisterPageWidget> {
  TextEditingController? phoneNumberController;

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    phoneNumberController = TextEditingController();
    phoneNumberController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.primaryColor,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF673AB7), Colors.orange],
              stops: [0, 1],
              begin: Alignment(0, -1),
              end: Alignment(0, 1),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 50, 0, 30),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment(0, 0),
                            child: Text(
                              'oxen',
                              textAlign: TextAlign.center,
                              style: FlutterFlowTheme.title1.override(
                                fontFamily: 'Roboto',
                                color: Colors.white,
                                fontSize: 64,
                                fontWeight: FontWeight.w200,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: phoneNumberController,
                            obscureText: false,
                            decoration: InputDecoration(
                              labelText: 'Phone Number',
                              labelStyle: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                                color: Color(0xFF95A1AC),
                              ),
                              hintText: 'Phone Number',
                              hintStyle: FlutterFlowTheme.bodyText1.override(
                                fontFamily: 'Poppins',
                                color: Color(0xFF95A1AC),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFDBE2E7),
                                  width: 2,
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
                                  color: Color(0xFFDBE2E7),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                  topLeft: Radius.circular(8),
                                  topRight: Radius.circular(8),
                                ),
                              ),
                              filled: true,
                              fillColor: FlutterFlowTheme.tertiaryColor,
                              contentPadding:
                                  EdgeInsets.fromLTRB(16, 16, 0, 16),
                            ),
                            style: FlutterFlowTheme.bodyText1.override(
                              fontFamily: 'Poppins',
                              color: Color(0xFF2B343A),
                            ),
                            keyboardType: TextInputType.phone,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FFButtonWidget(
                          onPressed: () async {
                            final user =
                                await registerUser(phoneNumberController!.text);

                            if (!user) {
                              return;
                            }

                            await authUser(phoneNumberController!.text);

                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ConfirmLoginPageWidget(),
                              ),
                            );
                          },
                          text: 'Create Account',
                          options: FFButtonOptions(
                            width: 210,
                            height: 60,
                            color: Color(0xFF090F13),
                            textStyle: FlutterFlowTheme.subtitle1.override(
                              fontFamily: 'Poppins',
                              color: FlutterFlowTheme.tertiaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                            elevation: 3,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: 8,
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: FlutterFlowTheme.bodyText1.override(
                            fontFamily: 'Poppins',
                            color: FlutterFlowTheme.tertiaryColor,
                          ),
                        ),
                        FFButtonWidget(
                          onPressed: () async {
                            // await Navigator.popAndPushNamed(context, routeName);
                            await Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginPageWidget(),
                              ),
                            );
                          },
                          text: 'Login',
                          options: FFButtonOptions(
                            width: 70,
                            height: 30,
                            color: Color(0x00FFFFFF),
                            textStyle: FlutterFlowTheme.subtitle2.override(
                              fontFamily: 'Poppins',
                              color: Color(0xFF39D2C0),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                            elevation: 0,
                            borderSide: BorderSide(
                              color: Colors.transparent,
                              width: 1,
                            ),
                            borderRadius: 0,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
