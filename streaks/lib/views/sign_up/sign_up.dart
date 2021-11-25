import 'package:stacked/stacked.dart';
import 'package:streaks/flutter_flow/flutter_flow_theme.dart';
import 'package:streaks/flutter_flow/flutter_flow_widgets.dart';
import 'package:streaks/services/dialog_service.dart';
import 'package:streaks/viewmodels/signup_view_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:email_auth/email_auth.dart';

import '../../locator.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailTextController;
  TextEditingController passwordTextController;
  TextEditingController fullNameController;
  TextEditingController otpVerificationController;
  final DialogService _dialogService = locator<DialogService>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  var status = false;

  @override
  void initState() {
    super.initState();
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
    fullNameController = TextEditingController();
    otpVerificationController = TextEditingController();
  }

  void sendOTP() async {
    EmailAuth.sessionName = "Test session";
    var response =
        await EmailAuth.sendOtp(receiverMail: emailTextController.text);
    if (response) {
      await _dialogService.showDialog(
        title: 'Verification code is sent.',
        description:
            'Please enter the code you received in the text field below.',
      );
    } else {
      await _dialogService.showDialog(
        title: 'Verification Failure',
        description: 'General verification failure. Please try again later',
      );
    }
  }

  void verifyOTP() async {
    var response = EmailAuth.validate(
        receiverMail: emailTextController.text,
        userOTP: otpVerificationController.text);
    if (response) {
      await _dialogService.showDialog(
        title: 'Verification was successful.',
        description: 'You are now able to sign up.',
      );
    } else {
      await _dialogService.showDialog(
        title: 'Verification Failure',
        description: 'General verification failure. Please try again later',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SignUpViewModel>.reactive(
      viewModelBuilder: () => SignUpViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xFF607D8B),
          title: Text(
            'Streaks',
            textAlign: TextAlign.start,
            style: FlutterFlowTheme.bodyText1.override(
              fontFamily: 'Montserrat',
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          elevation: 4,
        ),
        key: scaffoldKey,
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFF607D8B),
            ),
            alignment: Alignment(0, 0),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment(0, 0),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 80),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        /// FULL NAME
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                          child: Container(
                            width: 285,
                            height: 40,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment(0, 0),
                                  child: TextFormField(
                                    controller: fullNameController,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: 'Full Name',
                                      hintStyle: GoogleFonts.getFont(
                                        'Lato',
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              FlutterFlowTheme.secondaryColor,
                                          width: 2,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              FlutterFlowTheme.secondaryColor,
                                          width: 2,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                    ),
                                    style: GoogleFonts.getFont(
                                      'Lato',
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        /// EMAIL
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                          child: Container(
                            width: 285,
                            height: 40,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment(0, 0),
                                  child: TextFormField(
                                    controller: emailTextController,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: 'E-mail',
                                      hintStyle: GoogleFonts.getFont(
                                        'Lato',
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              FlutterFlowTheme.secondaryColor,
                                          width: 2,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              FlutterFlowTheme.secondaryColor,
                                          width: 2,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                    ),
                                    style: GoogleFonts.getFont(
                                      'Lato',
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment(0.95, 0.5),
                                  child: FFButtonWidget(
                                    onPressed: () => sendOTP(),
                                    options: FFButtonOptions(
                                      width: 90,
                                      height: 40,
                                      color: Color(0x00FFFFFF),
                                      textStyle: GoogleFonts.getFont(
                                        'Lato',
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.secondaryColor,
                                        width: 2,
                                      ),
                                      borderRadius: 0,
                                    ),
                                    text: 'Send OTP',
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                        /// PASSWORD
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                          child: Container(
                            width: 285,
                            height: 40,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment(0, 0),
                                  child: TextFormField(
                                    controller: passwordTextController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      hintText: 'Password',
                                      hintStyle: GoogleFonts.getFont(
                                        'Lato',
                                        color: FlutterFlowTheme.tertiaryColor,
                                        fontSize: 18,
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              FlutterFlowTheme.secondaryColor,
                                          width: 2,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              FlutterFlowTheme.secondaryColor,
                                          width: 2,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                    ),
                                    style: GoogleFonts.getFont(
                                      'Lato',
                                      color: FlutterFlowTheme.tertiaryColor,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment(0.95, 0.5),
                                  child: Icon(
                                    Icons.lock_open,
                                    color: FlutterFlowTheme.secondaryColor,
                                    size: 24,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),

                        /// VERIFICATION
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 30),
                          child: Container(
                            width: 285,
                            height: 40,
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment(0, 0),
                                  child: TextFormField(
                                    controller: otpVerificationController,
                                    obscureText: false,
                                    decoration: InputDecoration(
                                      hintText: 'OTP Code',
                                      hintStyle: GoogleFonts.getFont(
                                        'Lato',
                                        color: Colors.white,
                                        fontSize: 18,
                                      ),
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              FlutterFlowTheme.secondaryColor,
                                          width: 2,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              FlutterFlowTheme.secondaryColor,
                                          width: 2,
                                        ),
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(4.0),
                                          topRight: Radius.circular(4.0),
                                        ),
                                      ),
                                    ),
                                    style: GoogleFonts.getFont(
                                      'Lato',
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            /// BUTTON VERIFY
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FFButtonWidget(
                                    onPressed: () {
                                      setState(() {
                                        status = !status;
                                      });
                                      verifyOTP();
                                    },
                                    text: 'Verify',
                                    options: FFButtonOptions(
                                      width: 125,
                                      height: 40,
                                      color: Color(0x00FFFFFF),
                                      textStyle: GoogleFonts.getFont(
                                        'Lato',
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.secondaryColor,
                                        width: 2,
                                      ),
                                      borderRadius: 0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),

                            /// BUTTON SIGNUP
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  FFButtonWidget(
                                    onPressed: status
                                        ? () async {
                                            model.signUp(
                                              email: emailTextController.text,
                                              password:
                                                  passwordTextController.text,
                                              fullName: fullNameController.text,
                                            );
                                          }
                                        : null,
                                    text: 'Sign up',
                                    options: FFButtonOptions(
                                      width: 125,
                                      height: 40,
                                      color: Color(0x00FFFFFF),
                                      textStyle: GoogleFonts.getFont(
                                        'Lato',
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                      borderSide: BorderSide(
                                        color: FlutterFlowTheme.secondaryColor,
                                        width: 2,
                                      ),
                                      borderRadius: 0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
