import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stacked/stacked.dart';
import 'package:streaks/constants/utils.dart';
import 'package:streaks/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:streaks/models/goal.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:streaks/viewmodels/create_goal_view_model.dart';
import 'dart:collection';

class CreateGoalWidget extends StatefulWidget {
  final Goal edittingGoal;
  CreateGoalWidget({Key key, this.edittingGoal}) : super(key: key);

  @override
  CreateGoalState createState() => CreateGoalState(edittingGoal);
}

class CreateGoalState extends State<CreateGoalWidget> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController numberOfDaysController = TextEditingController();
  final Goal edittingGoal;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  ValueNotifier<List<Event>> _selectedEvents;
  ValueNotifier<List<Goal>> _selectedGoals;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing database.rules.json date
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay;
  DateTime _rangeStart;
  DateTime _rangeEnd;
  DateTime startDate = DateTime.now();
  DateTime endDate;

  CreateGoalState(this.edittingGoal);

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }

  List<Event> _getEventsForRange(DateTime start, DateTime end) {
    // Implementation example
    final days = daysInRange(start, end);

    return [
      for (final d in days) ..._getEventsForDay(d),
    ];
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getEventsForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime start, DateTime end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getEventsForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getEventsForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getEventsForDay(end);
    }
  }

  // Future<void> _selectDate(BuildContext context) async {
  //   final DateTime picked = await showDatePicker(
  //       context: context,
  //       initialDate: startDate,
  //       firstDate: startDate,
  //       lastDate: DateTime(2101));
  //   if (picked != null && picked != startDate)
  //     setState(() {
  //       startDate = picked;
  //
  //       endDate = startDate
  //           .add(Duration(days: int.parse(numberOfDaysController.text)));
  //     });
  // }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CreateGoalViewModel>.reactive(
      viewModelBuilder: () => CreateGoalViewModel(),
      onModelReady: (model) {
        // update the text in the controller
        titleController.text = edittingGoal?.title ?? '';
        numberOfDaysController.text =
            (edittingGoal?.numberOfDays).toString() ?? '';
        // set the editing post
        model.setEdittingGoal(edittingGoal);
      },
      builder: (context, model, child) => Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          backgroundColor: Color(0xFF607D8B),
          automaticallyImplyLeading: true,
          title: Text(
            'Create Goal',
            textAlign: TextAlign.start,
            style: FlutterFlowTheme.bodyText1.override(
              fontFamily: 'Montserrat',
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [],
          centerTitle: true,
          elevation: 4,
        ),

        ///FLOATING BUTTON
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (!model.busy) {
              model.addGoal(
                title: titleController.text,
                numberOfDays: numberOfDaysController.text != ''
                    ? int.parse(numberOfDaysController.text)
                    : (_rangeEnd.difference(_rangeStart).inDays),
                dateStarted: _selectedDay != null ? _selectedDay : _rangeStart,
                dateEnded: numberOfDaysController.text != ''
                    ? endDate = _selectedDay.add(
                        Duration(days: int.parse(numberOfDaysController.text)))
                    : _rangeEnd,
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
        body: ListView(shrinkWrap: true, children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ///GOAL TITLE
              Flexible(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                  child: Text(
                    'Title of your goal',
                    textAlign: TextAlign.start,
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 15),
                  child: TextFormField(
                    controller: titleController,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'Please enter title of your goal',
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
              ),
              SizedBox(
                height: 20,
              ),

              ///GOAL DAYS
              Flexible(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
                  child: Text(
                    'Number of days of your goal',
                    textAlign: TextAlign.start,
                    style: FlutterFlowTheme.bodyText1.override(
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
              Flexible(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 15),
                  child: TextFormField(
                    controller: numberOfDaysController,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'Please enter the number of days',
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
              ),
              //
              // /// DATE PICKER
              // Column(
              //   mainAxisSize: MainAxisSize.min,
              //   children: <Widget>[
              //     Text("${startDate.toLocal()}".split(' ')[0]),
              //     SizedBox(
              //       height: 20.0,
              //     ),
              //     ElevatedButton(
              //       onPressed: () => _selectDate(context),
              //       child: Text('Select date'),
              //     ),
              //   ],
              // ),

              SizedBox(
                height: 20,
              ),

              /// CALENDAR
              Flexible(
                child: TableCalendar<Event>(
                  firstDay: kFirstDay,
                  lastDay: kLastDay,
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  rangeStartDay: _rangeStart,
                  rangeEndDay: _rangeEnd,
                  calendarFormat: _calendarFormat,
                  rangeSelectionMode: _rangeSelectionMode,
                  eventLoader: _getEventsForDay,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  calendarStyle: CalendarStyle(
                    // Use `CalendarStyle` to customize the UI
                    outsideDaysVisible: false,
                  ),
                  onDaySelected: _onDaySelected,
                  onRangeSelected: _onRangeSelected,
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                ),
              ),
              SizedBox(height: 8.0),
              Flexible(
                child: ValueListenableBuilder<List<Event>>(
                  valueListenable: _selectedEvents,
                  builder: (context, value, _) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: value.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 12.0,
                            vertical: 4.0,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: ListTile(
                            onTap: () => print('${value[index]}'),
                            title: Text('${value[index]}'),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
