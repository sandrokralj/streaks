import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:streaks/flutter_flow/flutter_flow_theme.dart';
import 'package:streaks/viewmodels/account_view_model.dart';

class MyAccountWidget extends StatefulWidget {
  MyAccountWidget({Key key}) : super(key: key);

  @override
  _MyAccountWidgetState createState() => _MyAccountWidgetState();
}

class _MyAccountWidgetState extends State<MyAccountWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AccountViewModel>.reactive(
      viewModelBuilder: () => AccountViewModel(),
      onModelReady: (model) {
        // ignore: unnecessary_statements
        model.getCurrentUser;
      },
      builder: (context, model, child) => Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Color(0xFF607D8B),
          automaticallyImplyLeading: true,
          actions: [Container()],
          title: Text(
            'My Account',
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
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            /// Profile picture
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: CircleAvatar(
                  radius: 75,
                  backgroundColor: Color(0xFFEE8B60),
                  child: CircleAvatar(
                    radius: 70,
                    child: Icon(
                      Icons.account_circle,
                      size: 105,
                      color: Color(0xFFEE8B60),
                    ),
                    backgroundColor: Color(0xFF607D8B),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Username: ${model.currentUser.fullName.toString()}',
              style: FlutterFlowTheme.bodyText1.override(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Email: ${model.currentUser.email.toString()}',
              style: FlutterFlowTheme.bodyText1.override(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
