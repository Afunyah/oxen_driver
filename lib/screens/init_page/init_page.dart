import 'dart:async';
import 'package:amplify_datastore/amplify_datastore.dart';
import 'package:amplify_api/amplify_api.dart';
import 'package:amplify_flutter/categories/amplify_categories.dart';
import 'package:oxen_driver/models/ModelProvider.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:oxen_driver/auth/auth_utils.dart';
import 'package:oxen_driver/amplifyconfiguration.dart';
import 'package:oxen_driver/flutter_flow/flutter_flow_theme.dart';
import 'package:oxen_driver/flutter_flow/flutter_flow_util.dart';
import 'package:oxen_driver/flutter_flow/flutter_flow_widgets.dart';
import 'package:oxen_driver/screens/company_completion_pages/company_account_completion_page_1.dart';
import 'package:oxen_driver/screens/completion_wait_page/completion_wait_page.dart';
import 'package:oxen_driver/screens/driver_account_completion_pages/driver_account_completion_page_1.dart';
import 'package:oxen_driver/screens/home_page/home_page.dart';
import 'package:flutter/material.dart';
import 'package:oxen_driver/screens/role_selection_page/role_selection_page.dart';
import 'package:oxen_driver/globals.dart';

Future<void> configureAmplify() async {
  AmplifyAuthCognito authPlugin = AmplifyAuthCognito();
  AmplifyDataStore dataStorePlugin;
  dataStorePlugin = AmplifyDataStore(modelProvider: ModelProvider.instance);
  AmplifyAPI apiPlugin = AmplifyAPI();
  AmplifyStorageS3 s3Plugin = AmplifyStorageS3();
  await Amplify.addPlugins([authPlugin, dataStorePlugin, s3Plugin, apiPlugin]);

  // Once Plugins are added, configure Amplify. Note: Amplify can only be configured once.
  try {
    await Amplify.configure(amplifyconfig);
    // ignore: cancel_subscriptions

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
            Amplify.DataStore.clear();
          }
          break;
        case "SESSION_EXPIRED":
          {
            Amplify.DataStore.clear();
            print("USER IS SIGNED IN/SESSION EXPIRED");
          }
          break;
        default:
          print("SOME UNKNOWN AUTH HUBEVENT");
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
          Widget pageToPush;
          if (validSession) {
            // checkSession sets the global phone number and status
            await Globals.setRoleFromPref();
            dynamic userModel = await pullUserModel();

            if (userModel != null) {
              print(userModel.toString());
              if (userModel.totalConfirmation) {
                pageToPush = HomePageWidget();
              } else {
                pageToPush = CompletionWaitPageWidget();
              }
            } else {
              print('No user model loaded for user');
              switch (Globals.getRole()) {
                case 'driver':
                  pageToPush = DriverAccountCompletionPage1Widget();
                  break;
                case 'company':
                  pageToPush = CompanyAccountCompletionPage1Widget();
                  break;
                default:
                  print(
                      "USER MODEL PREF ERROR: UNABLE TO DETERMINE ROLE - ${Globals.getRole()}");
                  userSignOut();
                  pageToPush = RoleSelectionPageWidget();
              }
            }
          } else {
            print('No user model loaded -> selecting roles');
            pageToPush = RoleSelectionPageWidget();
          }

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => pageToPush,
              ),
              (route) => false);
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
