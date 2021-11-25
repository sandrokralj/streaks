import 'package:flutter/material.dart';
import 'package:streaks/flutter_flow/flutter_flow_theme.dart';
import 'package:streaks/viewmodels/progress_view_model.dart';
import 'package:stacked/stacked.dart';
import 'package:streaks/widgets/goal_item.dart';

class ProgressWidget extends StatefulWidget {
  ProgressWidget({Key key}) : super(key: key);

  @override
  _ProgressWidgetState createState() => _ProgressWidgetState();
}

class _ProgressWidgetState extends State<ProgressWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProgressViewModel>.reactive(
      viewModelBuilder: () => ProgressViewModel(),
      onModelReady: (model) => model.listenToGoals(),
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
            'Progress',
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
                child: model.goals != null
                    ? GridView.builder(
                        itemCount: model.goals.length,
                        itemBuilder: (context, index) => GestureDetector(
                          onTap: () => model.editPost(index),
                          child: GoalItem(
                            goal: model.goals[index],
                            startDate: model.goals[index].dateStarted,
                            endDate: model.goals[index].dateEnding,
                            onDeleteItem: () => model.deleteGoal(index),
                          ),
                        ),
                        padding: EdgeInsets.zero,
                        scrollDirection: Axis.vertical,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
      ),
    );
  }
}
