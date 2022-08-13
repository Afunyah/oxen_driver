import 'package:oxen_driver/globals.dart';
import 'package:oxen_driver/flutter_flow/flutter_flow_theme.dart';
import 'package:oxen_driver/flutter_flow/flutter_flow_util.dart';
import 'package:oxen_driver/flutter_flow/flutter_flow_widgets.dart';
import 'package:oxen_driver/screens/login_page/login_page.dart';
import 'package:flutter/material.dart';

class RoleSelectionPageWidget extends StatefulWidget {
  RoleSelectionPageWidget({Key? key}) : super(key: key);

  @override
  _RoleSelectionPageWidgetState createState() =>
      _RoleSelectionPageWidgetState();
}

class _RoleSelectionPageWidgetState extends State<RoleSelectionPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.tertiaryColor,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 1,
        decoration: BoxDecoration(
            gradient: LinearGradient(
          colors: [Color(0xFF673AB7), Colors.orange],
          stops: [0, 1],
          begin: Alignment(0, -1),
          end: Alignment(0, 1),
        )),
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'oxen',
                      style: FlutterFlowTheme.title1.override(
                        fontFamily: 'Roboto',
                        fontSize: 96,
                        fontWeight: FontWeight.w300,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 2, 0, 20),
                              child: FFButtonWidget(
                                onPressed: () async {
                                  Globals.setRole('driver');
                                  await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            LoginPageWidget()),
                                  );
                                },
                                text: 'Driver',
                                options: FFButtonOptions(
                                  width: 200,
                                  height: 50,
                                  color: FlutterFlowTheme.primaryColor,
                                  textStyle:
                                      FlutterFlowTheme.subtitle2.override(
                                    fontFamily: 'Lexend Deca',
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  elevation: 3,
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                    width: 1,
                                  ),
                                  borderRadius: 8,
                                ),
                              ),
                            ),
                            FFButtonWidget(
                              onPressed: () async {
                                Globals.setRole('company');
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginPageWidget(),
                                  ),
                                );
                              },
                              text: 'Company',
                              options: FFButtonOptions(
                                width: 200,
                                height: 50,
                                color: Colors.white,
                                textStyle: FlutterFlowTheme.subtitle2.override(
                                  fontFamily: 'Lexend Deca',
                                  color: FlutterFlowTheme.primaryColor,
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
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
