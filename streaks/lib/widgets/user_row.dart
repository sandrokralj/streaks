import 'package:flutter/material.dart';
import 'package:streaks/flutter_flow/flutter_flow_theme.dart';
import 'package:streaks/models/strkuser.dart';
//import 'package:streaks/models/user.dart';

class UserRow extends StatelessWidget {
  final List<String> friends;
  final int index;
  const UserRow({Key key, this.friends, this.index}) : super(key: key);

  Widget getTextWidgets(List<String> strings, int index) {
    return new Row(
      children: [
        Center(
          child: Text(strings[index].toString(),
              style: FlutterFlowTheme.bodyText1.override(
                fontFamily: 'Poppins',
                fontSize: 18,
                fontWeight: FontWeight.bold,
              )),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: Color(0xFFEEEEEE),
          borderRadius: BorderRadius.circular(15),
          shape: BoxShape.rectangle,
          border: Border.all(
            color: FlutterFlowTheme.secondaryColor,
            width: 5,
          ),
        ),
        margin: const EdgeInsets.only(top: 20),
        alignment: Alignment.center,
        child: Row(
          children: <Widget>[
            Expanded(
                child: Padding(
              padding: const EdgeInsets.only(left: 15.0),
              child: getTextWidgets(friends, index),
            )),
          ],
        ),
      ),
    );
  }
}
