import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:streaks/flutter_flow/flutter_flow_theme.dart';
import 'package:streaks/viewmodels/friend_add_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:streaks/widgets/user_row.dart';

class FriendAddWidget extends StatefulWidget {
  FriendAddWidget({Key key}) : super(key: key);

  @override
  _FriendAddWidgetState createState() => _FriendAddWidgetState();
}

class _FriendAddWidgetState extends State<FriendAddWidget> {
   final TextEditingController titleController = TextEditingController();
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FriendAddViewModel>.reactive(
      viewModelBuilder: () => FriendAddViewModel(),
      // onModelReady: (model) => model.listenToFriends(),<--
      builder: (context, model, child) => Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Color(0xFF607D8B),
          automaticallyImplyLeading: true,
          actions: [
            Padding(
              padding: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.account_circle,
                size: 30,
              ),
            )
          ],
          title: Text(
            'Add Friend',
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
         floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (!model.busy) {
              model.addFriend(
                friendUID: titleController.text,
              );
            }
          },
          backgroundColor: Color(0xFF607D8B),
          elevation: 10,
          child: !model.busy
              ? Icon(Icons.add)
              : CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation(Colors.white),
                ),
        ),
       
        body:
         SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
        Padding(
                padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                child: Text(
                  'Enter User ID',
                  textAlign: TextAlign.start,
                  style: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
         Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 15),
                child: TextFormField(
                  controller: titleController,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: 'Please enter the id of the user you want to add',
                    hintStyle: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF607D8B),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xFF607D8B),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                    ),
                    filled: true,
                  ),
                  style: FlutterFlowTheme.bodyText1.override(
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ]),
            ),
      )
    );
  }
}
