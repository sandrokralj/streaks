import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:stacked/stacked.dart';
import 'package:streaks/flutter_flow/flutter_flow_theme.dart';
import 'package:streaks/models/goal.dart';
import 'package:streaks/viewmodels/progress_view_model.dart';

class GoalItem extends StatelessWidget {
  final Goal goal;
  final Function onDeleteItem;
  final DateTime startDate;
  final DateTime endDate;
  final int daysCompleted;
  final int daysMissed;
  const GoalItem({
    Key key,
    this.goal,
    this.onDeleteItem,
    this.startDate,
    this.endDate,
    this.daysMissed,
    this.daysCompleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProgressViewModel>.reactive(
      viewModelBuilder: () => ProgressViewModel(),
      onModelReady: (model) => model.listenToGoals(),
      builder: (context, model, child) => Padding(
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: <Widget>[
                  Expanded(
                      child: Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      goal.title,
                      style: FlutterFlowTheme.bodyText1.override(
                        fontFamily: 'Poppins',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      if (onDeleteItem != null) {
                        onDeleteItem();
                      }
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: LinearPercentIndicator(
                      animation: true,
                      animationDuration: 1500,
                      lineHeight: 15,
                      center: Text(
                        '${model.daysSinceStarting()} of ${goal.numberOfDays}',
                      ),
                      percent: (model.daysSinceStarting() / goal.numberOfDays),
                      progressColor: Colors.greenAccent,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
