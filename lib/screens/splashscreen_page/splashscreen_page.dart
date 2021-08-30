// import 'package:oxen_driver/auth/auth_utils.dart';

// import 'package:oxen_driver/flutter_flow/flutter_flow_theme.dart';
// import 'package:oxen_driver/flutter_flow/flutter_flow_util.dart';
// import 'package:oxen_driver/flutter_flow/flutter_flow_widgets.dart';
// import 'package:oxen_driver/screens/login_page/login_page.dart';
// import 'package:oxen_driver/screens/register_page/register_page.dart';
// import 'package:flutter/material.dart';
// //import 'package:google_fonts/google_fonts.dart';

// class SplashScreenPageWidget extends StatefulWidget {
//   SplashScreenPageWidget({Key? key}) : super(key: key);

//   @override
//   _SplashScreenPageWidgetState createState() => _SplashScreenPageWidgetState();
// }

// class _SplashScreenPageWidgetState extends State<SplashScreenPageWidget> {
//   final scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: scaffoldKey,
//       backgroundColor: FlutterFlowTheme.tertiaryColor,
//       body: Container(
//         width: MediaQuery.of(context).size.width,
//         height: MediaQuery.of(context).size.height * 1,
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//               colors: [Color(0xFF673AB7), Colors.orange],
//               stops: [0, 1],
//               begin: Alignment(0, -1),
//               end: Alignment(0, 1),
//             )
//           // image: DecorationImage(
//           //   fit: BoxFit.fill,
//           //   image: Image.asset(
//           //     'assets/images/bg_login.png',
//           //   ).image,
//           // ),
//         ),
//         child: Padding(
//           padding: EdgeInsets.fromLTRB(0, 40, 0, 0),
//           child: Column(
//             mainAxisSize: MainAxisSize.max,
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Expanded(
//                 child: Row(
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text(
//                       'oxen',
//                       style: FlutterFlowTheme.title1.override(
//                         fontFamily: 'Roboto',
//                         fontSize: 96,
//                         fontWeight: FontWeight.w300,
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: Row(
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Expanded(
//                       child: Padding(
//                         padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
//                         child: Column(
//                           mainAxisSize: MainAxisSize.max,
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.fromLTRB(0, 2, 0, 20),
//                               child: FFButtonWidget(
//                                 onPressed: () async {
//                                   await Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                       builder: (context) =>
//                                           RegisterPageWidget(),
//                                     ),
//                                   );
//                                 },
//                                 text: 'Register',
//                                 options: FFButtonOptions(
//                                   width: 200,
//                                   height: 50,
//                                   color: FlutterFlowTheme.primaryColor,
//                                   textStyle:
//                                       FlutterFlowTheme.subtitle2.override(
//                                     fontFamily: 'Lexend Deca',
//                                     color: Colors.white,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                   elevation: 3,
//                                   borderSide: BorderSide(
//                                     color: Colors.transparent,
//                                     width: 1,
//                                   ),
//                                   borderRadius: 8,
//                                 ),
//                               ),
//                             ),
//                             FFButtonWidget(
//                               onPressed: () async {
//                                 await Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => LoginPageWidget(),
//                                   ),
//                                 );
//                               },
//                               text: 'Login',
//                               options: FFButtonOptions(
//                                 width: 200,
//                                 height: 50,
//                                 color: Colors.white,
//                                 textStyle: FlutterFlowTheme.subtitle2.override(
//                                   fontFamily: 'Lexend Deca',
//                                   color: FlutterFlowTheme.primaryColor,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                                 elevation: 3,
//                                 borderSide: BorderSide(
//                                   color: Colors.transparent,
//                                   width: 1,
//                                 ),
//                                 borderRadius: 8,
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
