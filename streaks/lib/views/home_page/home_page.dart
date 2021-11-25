import 'package:stacked/stacked.dart';
import 'package:streaks/constants/route_names.dart';
import 'package:streaks/flutter_flow/flutter_flow_theme.dart';
import 'package:streaks/viewmodels/homepage_view_model.dart';
import 'package:streaks/views/friend_add/friend_add.dart';
import 'package:streaks/views/friend_list/friend_list.dart';
import 'package:streaks/views/my_account/my_account_widget.dart';
import 'package:streaks/views/progress/progress_widget.dart';
import 'package:streaks/views/visualize/visualize_widget.dart';
import '../create_goal/create_goal_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomePageViewModel>.reactive(
      viewModelBuilder: () => HomePageViewModel(),
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
        backgroundColor: FlutterFlowTheme.tertiaryColor,
        drawer: Drawer(
          elevation: 16,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 1),
                child: InkWell(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MyAccountWidget(),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.account_circle,
                      color: FlutterFlowTheme.secondaryColor,
                      size: 30,
                    ),
                    title: Text(
                      'My Account',
                      style: FlutterFlowTheme.title3.override(
                        fontFamily: 'Poppins',
                      ),
                    ),
                    trailing: FaIcon(
                      FontAwesomeIcons.arrowCircleRight,
                      color: Color(0xFF303030),
                      size: 25,
                    ),
                    tileColor: Color(0xFF607D8B),
                    dense: false,
                    contentPadding: EdgeInsets.fromLTRB(10, 1, 10, 1),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 1),
                child: InkWell(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CreateGoalWidget(),
                      ),
                    );
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.create,
                      color: FlutterFlowTheme.secondaryColor,
                      size: 30,
                    ),
                    title: Text(
                      'Create Goal',
                      style: FlutterFlowTheme.title3.override(
                        fontFamily: 'Poppins',
                      ),
                    ),
                    trailing: FaIcon(
                      FontAwesomeIcons.arrowCircleRight,
                      color: Color(0xFF303030),
                      size: 25,
                    ),
                    tileColor: Color(0xFF607D8B),
                    dense: false,
                    contentPadding: EdgeInsets.fromLTRB(10, 1, 10, 1),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 1),
                child: ListTile(
                  leading: Icon(
                    Icons.account_circle,
                    color: FlutterFlowTheme.secondaryColor,
                    size: 30,
                  ),
                  title: Text(
                    'All Goals',
                    style: FlutterFlowTheme.title3.override(
                      fontFamily: 'Poppins',
                    ),
                  ),
                  trailing: FaIcon(
                    FontAwesomeIcons.arrowCircleRight,
                    color: Color(0xFF303030),
                    size: 25,
                  ),
                  tileColor: Color(0xFF607D8B),
                  dense: false,
                  contentPadding: EdgeInsets.fromLTRB(10, 1, 10, 1),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 1),
                child: InkWell(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FriendListWidget(),
                      ),
                    );
                  },
                child: ListTile(
                  leading: Icon(
                    Icons.person_search,
                    color: FlutterFlowTheme.secondaryColor,
                    size: 30,
                  ),
                  title: Text(
                    'Friendlist',
                    style: FlutterFlowTheme.title3.override(
                      fontFamily: 'Poppins',
                    ),
                  ),
                  trailing: FaIcon(
                    FontAwesomeIcons.arrowCircleRight,
                    color: Color(0xFF303030),
                    size: 25,
                  ),
                  tileColor: Color(0xFF607D8B),
                  dense: false,
                  contentPadding: EdgeInsets.fromLTRB(10, 1, 10, 1),
                ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 1),
                child: InkWell(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FriendAddWidget(),
                      ),
                    );
                  },
                child: ListTile(
                  leading: Icon(
                    Icons.person_add,
                    color: FlutterFlowTheme.secondaryColor,
                    size: 30,
                  ),
                  title: Text(
                    'Add Friend',
                    style: FlutterFlowTheme.title3.override(
                      fontFamily: 'Poppins',
                    ),
                  ),
                  trailing: FaIcon(
                    FontAwesomeIcons.arrowCircleRight,
                    color: Color(0xFF303030),
                    size: 25,
                  ),
                  tileColor: Color(0xFF607D8B),
                  dense: false,
                  contentPadding: EdgeInsets.fromLTRB(10, 1, 10, 1),
                ),
              ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 1),
                child: ListTile(
                  leading: Icon(
                    Icons.settings,
                    color: FlutterFlowTheme.secondaryColor,
                    size: 30,
                  ),
                  title: Text(
                    'Settings',
                    style: FlutterFlowTheme.title3.override(
                      fontFamily: 'Poppins',
                    ),
                  ),
                  trailing: FaIcon(
                    FontAwesomeIcons.arrowCircleRight,
                    color: Color(0xFF303030),
                    size: 25,
                  ),
                  tileColor: Color(0xFF607D8B),
                  dense: false,
                  contentPadding: EdgeInsets.fromLTRB(10, 1, 10, 1),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 1),
                child: GestureDetector(
                  onTap: () async {
                    // ignore: unnecessary_statements
                    model.signOut;
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        SigninViewRoute, ModalRoute.withName(HomeViewRoute));
                  },
                  child: ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: Color(0xFF607D8B),
                      size: 30,
                    ),
                    title: Text(
                      'Log Out',
                      style: FlutterFlowTheme.title3.override(
                        fontFamily: 'Poppins',
                      ),
                    ),
                    trailing: FaIcon(
                      FontAwesomeIcons.arrowCircleRight,
                      color: Color(0xFF303030),
                      size: 25,
                    ),
                    tileColor: FlutterFlowTheme.secondaryColor,
                    dense: false,
                    contentPadding: EdgeInsets.fromLTRB(10, 1, 10, 1),
                  ),
                ),
              )
            ],
          ),
        ),
        body: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: GridView(
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1,
                  ),
                  scrollDirection: Axis.vertical,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: InkWell(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyAccountWidget(),
                            ),
                          );
                        },
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
                          alignment: Alignment(0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                Icons.account_circle,
                                color: FlutterFlowTheme.secondaryColor,
                                size: 110,
                              ),
                              Text(
                                'Account',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: InkWell(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreateGoalWidget(),
                            ),
                          );
                        },
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
                          alignment: Alignment(0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                Icons.create,
                                color: FlutterFlowTheme.secondaryColor,
                                size: 110,
                              ),
                              Text(
                                'Create Goal',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: InkWell(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProgressWidget(),
                            ),
                          );
                        },
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
                          alignment: Alignment(0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Icon(
                                Icons.trending_up_outlined,
                                color: FlutterFlowTheme.secondaryColor,
                                size: 110,
                              ),
                              Text(
                                'Progress',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child: InkWell(
                        onTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VisualizeWidget(),
                            ),
                          );
                        },
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
                          alignment: Alignment(0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              FaIcon(
                                FontAwesomeIcons.chartBar,
                                color: FlutterFlowTheme.secondaryColor,
                                size: 95,
                              ),
                              Text(
                                'Visualize',
                                style: FlutterFlowTheme.bodyText1.override(
                                  fontFamily: 'Poppins',
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
