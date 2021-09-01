import 'dart:io';

import 'package:amplify_flutter/amplify.dart';
import 'package:amplify_storage_s3/amplify_storage_s3.dart';
import 'package:flutter/services.dart';
import 'package:oxen_driver/auth/auth_utils.dart';
import 'package:oxen_driver/models/ModelProvider.dart';
import 'package:oxen_driver/screens/completion_wait_page/completion_wait_page.dart';
import 'package:oxen_driver/screens/confirm_login_page/confirm_login_page.dart';
import 'package:file_picker/file_picker.dart';
import 'package:oxen_driver/flutter_flow/flutter_flow_theme.dart';
import 'package:oxen_driver/flutter_flow/flutter_flow_util.dart';
import 'package:oxen_driver/flutter_flow/flutter_flow_widgets.dart';
import 'package:oxen_driver/globals.dart';

import 'package:oxen_driver/screens/login_page/login_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:oxen_driver/screens/role_selection_page/role_selection_page.dart';

class CompanyAccountCompletionPage1Widget extends StatefulWidget {
  CompanyAccountCompletionPage1Widget({Key? key}) : super(key: key);

  @override
  _CompanyAccountCompletionPage1WidgetState createState() =>
      _CompanyAccountCompletionPage1WidgetState();
}

class _CompanyAccountCompletionPage1WidgetState
    extends State<CompanyAccountCompletionPage1Widget> {
  TextEditingController? companyNameController;
  TextEditingController? firstNameController;
  TextEditingController? lastNameController;
  TextEditingController? emailController;

  ScrollController? scrollController;

  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  List<PlatformFile>? paths;
  List<PlatformFile> persistentPathsList = [];
  bool loadingPath = false;

  @override
  void initState() {
    super.initState();

    scrollController =
        ScrollController(initialScrollOffset: 0.0, keepScrollOffset: true);
    companyNameController = TextEditingController();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
  }

  void openFileExplorer() async {
    setState(() => loadingPath = true);
    try {
      // directoryPath = null;
      paths = (await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowMultiple: true,
              onFileLoading: (FilePickerStatus status) => print(status),
              allowedExtensions: [
            'pdf',
            'jpeg',
            'jpg',
            'png',
            'doc',
            'docx',
            'rtf'
          ]))
          ?.files;

      if (paths != null) {
        for (var i = 0; i < paths!.length; i++) {
          PlatformFile file = paths![i];

          if (persistentPathsList.any(
              (e) => e.path.toString().compareTo(file.path.toString()) == 0)) {
            // Check for duplicate
            continue;
          }

          persistentPathsList.add(file);

          print(file.name);
          print(file.bytes);
          print(file.size);
          print(file.extension);
          print(file.path);
        }
      } else {
        print('User canceled the picker');
      }
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    setState(() {
      loadingPath = false;
    });
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
                                  controller: firstNameController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: "Manager\'s First Name",
                                    labelStyle:
                                        FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFF95A1AC),
                                    ),
                                    hintText: "Manager\'s First Name",
                                    hintStyle:
                                        FlutterFlowTheme.bodyText1.override(
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
                            ])),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                        child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: lastNameController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: "Manager\'s Surname",
                                    labelStyle:
                                        FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFF95A1AC),
                                    ),
                                    hintText: "Manager\'s Surname",
                                    hintStyle:
                                        FlutterFlowTheme.bodyText1.override(
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
                            ])),
                    Padding(
                        padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                        child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: companyNameController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    labelText: 'Company Name',
                                    labelStyle:
                                        FlutterFlowTheme.bodyText1.override(
                                      fontFamily: 'Poppins',
                                      color: Color(0xFF95A1AC),
                                    ),
                                    hintText: 'Company Name',
                                    hintStyle:
                                        FlutterFlowTheme.bodyText1.override(
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
                            ])),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FFButtonWidget(
                                  onPressed: () async {
                                    openFileExplorer();
                                  },
                                  text: 'Select files to upload',
                                  options: FFButtonOptions(
                                    width: 210,
                                    height: 40,
                                    color: Color(0xFF090F13),
                                    textStyle:
                                        FlutterFlowTheme.subtitle1.override(
                                      fontFamily: 'Poppins',
                                      fontSize: 16,
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
                        ],
                      ),
                    ),
                    Builder(
                      builder: (BuildContext context) => loadingPath
                          ? Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: const CircularProgressIndicator(),
                            )
                          : persistentPathsList.isNotEmpty
                              // paths != null && paths!.isNotEmpty
                              ? Container(
                                  margin: EdgeInsets.only(top: 10),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.black.withOpacity(0.5),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 0, 0, 20),
                                  height:
                                      MediaQuery.of(context).size.height * 0.35,
                                  child: RawScrollbar(
                                      controller: scrollController,
                                      thumbColor: Colors.black.withOpacity(0.5),
                                      isAlwaysShown: true,
                                      thickness: 6,
                                      radius: Radius.circular(8),
                                      child: ListView.separated(
                                        controller: scrollController,
                                        itemCount: persistentPathsList.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          final String name = 'File $index: ' +
                                              persistentPathsList
                                                  .map((e) => e.name)
                                                  .toList()[index];

                                          final path = persistentPathsList
                                              .map((e) => e.path)
                                              .toList()[index]
                                              .toString();

                                          return ListTile(
                                            title: Text(
                                              name,
                                            ),
                                            // subtitle: Text(path),
                                            dense: false,
                                            trailing: IconButton(
                                              iconSize: 32,
                                              icon: Icon(
                                                Icons.cancel,
                                                color:
                                                    Colors.redAccent.shade700,
                                              ),
                                              onPressed: () async {
                                                persistentPathsList
                                                    .removeAt(index);
                                                setState(
                                                    () => loadingPath = false);
                                              },
                                            ),
                                          );
                                        },
                                        separatorBuilder:
                                            (BuildContext context, int index) =>
                                                const Divider(),
                                      )),
                                )
                              : const SizedBox(),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 24, 0, 0),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FFButtonWidget(
                            onPressed: () async {
                              String dIdentifier =
                                  '${companyNameController!.text}-${firstNameController!.text}${lastNameController!.text}';

                              if (persistentPathsList.isNotEmpty) {
                                await uploadFiles(
                                        persistentPathsList, dIdentifier)
                                    .then((value) async {
                                  await registerCompany(
                                      Globals.getPhoneNumber(),
                                      firstNameController!.text,
                                      lastNameController!.text,
                                      companyNameController!.text);
                                });
                              }

                              await registerCompany(
                                  Globals.getPhoneNumber(),
                                  firstNameController!.text,
                                  lastNameController!.text,
                                  companyNameController!
                                      .text); //for testing, remove

                              Company? userModel = await pullUserModel();

                              Globals.setCompany(userModel!);

                              await Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        CompletionWaitPageWidget(),
                                  ),
                                  (route) => false);
                            },
                            text: 'Submit',
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
                                  textStyle:
                                      FlutterFlowTheme.subtitle1.override(
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
                            ])),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
