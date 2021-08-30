import 'package:flutter/material.dart';
import 'package:oxen_driver/auth/auth_utils.dart';
import 'package:oxen_driver/flutter_flow/flutter_flow_theme.dart';
import 'package:oxen_driver/flutter_flow/flutter_flow_widgets.dart';
import 'package:oxen_driver/screens/role_selection_page/role_selection_page.dart';

class CompletionWaitPageWidget extends StatefulWidget {
  const CompletionWaitPageWidget({Key? key}) : super(key: key);

  @override
  _CompletionWaitPageWidgetState createState() =>
      _CompletionWaitPageWidgetState();
}

class _CompletionWaitPageWidgetState extends State<CompletionWaitPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.secondaryColor,
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 1,
          decoration: BoxDecoration(
            color: FlutterFlowTheme.secondaryColor,
            // image: DecorationImage(
            //   fit: BoxFit.fill,
            //   image: Image.asset(
            //     'assets/images/bg_login.png',
            //   ).image,
            // ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Please wait for your account to be verified',
                      style: FlutterFlowTheme.bodyText2,
                    )
                  ],
                ),
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FFButtonWidget(
                          onPressed: () async {
                            await userSignOut();
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      RoleSelectionPageWidget(),
                                ),
                                (route) => false);
                          },
                          text: 'Logout',
                          options: FFButtonOptions(
                            width: 120,
                            height: 40,
                            color: Color(0xFF090F13),
                            textStyle: FlutterFlowTheme.subtitle1.override(
                              fontFamily: 'Poppins',
                              fontSize: 20,
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
                      ]))
            ],
          )),
    );
  }
}
