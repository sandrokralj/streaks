import 'package:stacked/stacked.dart';
import 'package:streaks/constants/route_names.dart';
import 'package:streaks/flutter_flow/flutter_flow_theme.dart';
import 'package:streaks/flutter_flow/flutter_flow_widgets.dart';
import 'package:streaks/services/navigation_service.dart';
import 'package:streaks/viewmodels/login_view_model.dart';
import '../../locator.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignIn extends StatefulWidget {
  SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailTextController;
  TextEditingController passwordTextController;
  final NavigationService _navigationService = locator<NavigationService>();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LoginViewModel>.reactive(
      viewModelBuilder: () => LoginViewModel(),
      builder: (context, model, child) => Scaffold(
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
                                  child: Icon(
                                    Icons.person,
                                    color: FlutterFlowTheme.secondaryColor,
                                    size: 24,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
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
                        Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              FFButtonWidget(
                                onPressed: () async {
                                  model.login(
                                    email: emailTextController.text,
                                    password: passwordTextController.text,
                                  );
                                },
                                text: 'Sign In',
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
                              SizedBox(
                                width: 15,
                              ),
                              FFButtonWidget(
                                onPressed: () async {
                                  _navigationService
                                      .navigateTo(SignUpViewRoute);
                                },
                                text: 'Sign Up',
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
                        GestureDetector(
                          onTap: () async {
                            model.resetPw(email: emailTextController.text);
                          },
                          child: Text(
                            'Forgot Password?',
                            style: GoogleFonts.getFont(
                              'Lato',
                              color: FlutterFlowTheme.tertiaryColor,
                              fontSize: 16,
                            ),
                          ),
                        )
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
