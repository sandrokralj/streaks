import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:streaks/flutter_flow/flutter_flow_theme.dart';
import 'package:streaks/viewmodels/friend_list_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:streaks/widgets/user_row.dart';

class FriendListWidget extends StatefulWidget {
  FriendListWidget({Key key}) : super(key: key);

  @override
  _FriendListWidgetState createState() => _FriendListWidgetState();
}

class _FriendListWidgetState extends State<FriendListWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FriendListViewModel>.reactive(
        viewModelBuilder: () => FriendListViewModel(),
        onModelReady: (model) => model.listenToFriends(),
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
                  'Friend List',
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
                mainAxisSize: MainAxisSize.max,
                children: [
                  Expanded(
                      child: model.friends != null
                          ? GridView.builder(
                              itemCount: model.friends.length,
                              itemBuilder: (context, index) => GestureDetector(
                                child: UserRow(
                                  friends: model.friends,
                                  index: index,
                                ),
                              ),
                              padding: EdgeInsets.zero,
                              scrollDirection: Axis.vertical,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 1,
                              ),
                            )
                          : Center(
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(
                                    Theme.of(context).primaryColor),
                              ),
                            )),
                ],
              ),
            ));
  }
}
