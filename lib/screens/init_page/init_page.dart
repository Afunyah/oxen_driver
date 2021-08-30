import 'dart:async';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:oxen_driver/models/ModelProvider.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:oxen_driver/auth/auth_utils.dart';
import 'package:oxen_driver/amplifyconfiguration.dart';
import 'package:oxen_driver/flutter_flow/flutter_flow_theme.dart';
import 'package:oxen_driver/flutter_flow/flutter_flow_util.dart';
import 'package:oxen_driver/flutter_flow/flutter_flow_widgets.dart';
import 'package:oxen_driver/screens/completion_wait_page/completion_wait_page.dart';
import 'package:oxen_driver/screens/driver_account_completion_pages/driver_account_completion_page_1.dart';
import 'package:oxen_driver/screens/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:oxen_driver/screens/role_selection_page/role_selection_page.dart';
import 'package:oxen_driver/screens/splashscreen_page/splashscreen_page.dart';

import 'package:oxen_driver/globals.dart';

//import 'package:google_fonts/google_fonts.dart';
Future<void> configureAmplify() async {
  // Add Pinpoint and Cognito Plugins, or any other plugins you want to use
  AmplifyAuthCognito authPlugin = AmplifyAuthCognito();
  AmplifyDataStore dataStorePlugin =
      AmplifyDataStore(modelProvider: ModelProvider.instance);
  AmplifyStorageS3 s3Plugin = AmplifyStorageS3();
  Amplify.addPlugins([authPlugin, dataStorePlugin, s3Plugin]);

  // Once Plugins are added, configure Amplify. Note: Amplify can only be configured once.
  try {
    // await Amplify.configure(amplifyconfig).whenComplete(() => checkSession());\
    await Amplify.configure(amplifyconfig);
    StreamSubscription hubSubscription =
        Amplify.Hub.listen([HubChannel.Auth], (hubEvent) {
      switch (hubEvent.eventName) {
        case "SIGNED_IN":
          {
            print("USER IS SIGNED IN");
          }
          break;
        case "SIGNED_OUT":
          {
            print("USER IS SIGNED OUT");
          }
          break;
        case "SESSION_EXPIRED":
          {
            print("USER IS SIGNED IN/SESSION EXPIRED");
          }
          break;
        default:
          print("HERE");
      }
    });
  } on AmplifyAlreadyConfiguredException {
    print(
        "Tried to reconfigure Amplify; this can occur when your app restarts on Android.");
  }
}

class InitPageWidget extends StatefulWidget {
  InitPageWidget({Key? key}) : super(key: key);

  @override
  _InitPageWidgetState createState() => _InitPageWidgetState();
}

class _InitPageWidgetState extends State<InitPageWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) async {
      await Future.delayed(Duration(seconds: 4));
      await configureAmplify().then((validSession) {
        checkSession().then((validSession) async {
          print('ValidSession -> $validSession');
          if (validSession) {
            await Globals.setRoleFromPref();
            // checkSession sets the global phone number and status
            Rider? userModel = await pullUserModel();
            if (userModel != null) {
              Globals.setRider(userModel);
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
                    (route) => false); //to waiting
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
                          DriverAccountCompletionPage1Widget(),
                    ),
                    (route) => false);
              } else {
                return;
              }
            }
          } else {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                  builder: (context) => RoleSelectionPageWidget(),
                ),
                (route) => false);
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.primaryColor,
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
            ],
          ),
        ),
      ),
    );
  }
}
