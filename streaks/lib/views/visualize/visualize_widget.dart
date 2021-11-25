import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:stacked/stacked.dart';
import 'package:streaks/flutter_flow/flutter_flow_theme.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:streaks/viewmodels/progress_view_model.dart';

import 'indicator.dart';

class VisualizeWidget extends StatefulWidget {
  VisualizeWidget({Key key}) : super(key: key);

  @override
  _VisualizeWidgetState createState() => _VisualizeWidgetState();
}

class _VisualizeWidgetState extends State<VisualizeWidget> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  int touchedIndex = -1;

  final List<Color> availableColors = [
    Colors.purpleAccent,
    Colors.yellow,
    Colors.lightBlue,
    Colors.orange,
    Colors.pink,
    Colors.redAccent,
    Colors.green,
  ];

  final Color barBackgroundColor = const Color(0xFF607D8B);
  final Duration animDuration = const Duration(milliseconds: 250);
  bool isPlaying = false;

  Future<dynamic> refreshState() async {
    setState(() {});
    await Future<dynamic>.delayed(
        animDuration + const Duration(milliseconds: 50));
    if (isPlaying) {
      await refreshState();
    }
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color barColor = Colors.greenAccent,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          y: isTouched ? y + 1 : y,
          colors: isTouched ? [Colors.yellow] : [barColor],
          width: width,
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            y: 20,
            colors: [barBackgroundColor],
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups(ProgressViewModel model) =>
      List.generate(model.goals.length, (i) {
        for (int x = 0; x < model.goals.length; x++) {
          return makeGroupData(
              i, model.goals[i].numberOfDays / model.goals.length,
              isTouched: i == touchedIndex);
        }
        // switch (i) {
        //   case 0:
        //     return makeGroupData(
        //         0, model.goals[i].numberOfDays / model.goals.length,
        //         isTouched: i == touchedIndex);
        //   case 1:
        //     return makeGroupData(
        //         1, model.goals[i].numberOfDays / model.goals.length,
        //         isTouched: i == touchedIndex);
        //   case 2:
        //     return makeGroupData(
        //         2, model.goals[i].numberOfDays / model.goals.length,
        //         isTouched: i == touchedIndex);
        //   case 3:
        //     return makeGroupData(
        //         3, model.goals[i].numberOfDays / model.goals.length,
        //         isTouched: i == touchedIndex);
        //   case 4:
        //     return makeGroupData(
        //         4, model.goals[i].numberOfDays / model.goals.length,
        //         isTouched: i == touchedIndex);
        //   case 5:
        //     return makeGroupData(
        //         5, model.goals[i].numberOfDays / model.goals.length,
        //         isTouched: i == touchedIndex);
        //   case 6:
        //     return makeGroupData(
        //         6, model.goals[i].numberOfDays / model.goals.length,
        //         isTouched: i == touchedIndex);
        //   default:
        //     return throw Error();
        // }
      });

  BarChartData mainBarData(ProgressViewModel model) {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
            tooltipBgColor: Colors.blueGrey,
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              String weekDay;
              switch (group.x.toInt()) {
                case 0:
                  weekDay = 'Monday';
                  break;
                case 1:
                  weekDay = 'Tuesday';
                  break;
                case 2:
                  weekDay = 'Wednesday';
                  break;
                case 3:
                  weekDay = 'Thursday';
                  break;
                case 4:
                  weekDay = 'Friday';
                  break;
                case 5:
                  weekDay = 'Saturday';
                  break;
                case 6:
                  weekDay = 'Sunday';
                  break;
                default:
                  throw Error();
              }
              return BarTooltipItem(
                weekDay + '\n',
                TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                children: <TextSpan>[
                  TextSpan(
                    text: (rod.y - 1).toStringAsFixed(1),
                    style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }),
        touchCallback: (barTouchResponse) {
          setState(() {
            if (barTouchResponse.spot != null &&
                barTouchResponse.touchInput is! PointerUpEvent &&
                barTouchResponse.touchInput is! PointerExitEvent) {
              touchedIndex = barTouchResponse.spot.touchedBarGroupIndex;
            } else {
              touchedIndex = -1;
            }
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
              color: Colors.black, fontWeight: FontWeight.bold, fontSize: 14),
          margin: 16,
          getTitles: (double value) {
            switch (value.toInt()) {
              case 0:
                return 'M';
              case 1:
                return 'T';
              case 2:
                return 'W';
              case 3:
                return 'T';
              case 4:
                return 'F';
              case 5:
                return 'S';
              case 6:
                return 'S';
              default:
                return '';
            }
          },
        ),
        leftTitles: SideTitles(
          showTitles: false,
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(model),
    );
  }

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
                  'Visualize',
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
              body: SafeArea(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
                      child: Text(
                        'Total Day Distribution',
                        textAlign: TextAlign.start,
                        style: FlutterFlowTheme.bodyText1.override(
                          fontFamily: 'Montserrat',
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: PieChart(
                                PieChartData(
                                    pieTouchData: PieTouchData(
                                        touchCallback: (pieTouchResponse) {
                                      setState(() {
                                        final desiredTouch =
                                            pieTouchResponse.touchInput
                                                    is! PointerExitEvent &&
                                                pieTouchResponse.touchInput
                                                    is! PointerUpEvent;
                                        if (desiredTouch &&
                                            pieTouchResponse.touchedSection !=
                                                null) {
                                          touchedIndex = pieTouchResponse
                                              .touchedSection
                                              .touchedSectionIndex;
                                        } else {
                                          touchedIndex = -1;
                                        }
                                      });
                                    }),
                                    borderData: FlBorderData(
                                      show: false,
                                    ),
                                    sectionsSpace: 0,
                                    centerSpaceRadius: 40,
                                    sections: showingSections(model)),
                              ),
                            ),
                          ),

                          /// STILL PIE CHART
                          Expanded(
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.vertical,
                                itemCount: model.goals.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Column(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      buildIndicator(
                                          model, index, availableColors[index]),
                                    ],
                                  );
                                }),
                          ),
                        ],
                      ),
                    ),

                    /// BAR CHART
                    Expanded(
                      child: Stack(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: <Widget>[
                                Text(
                                  'Weekly overview',
                                  style: TextStyle(
                                      color: const Color(0xFF607D8B),
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                const SizedBox(
                                  height: 38,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: BarChart(
                                      mainBarData(model),
                                      swapAnimationDuration: animDuration,
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ));
  }

  Indicator buildIndicator(ProgressViewModel model, int i, Color color) {
    return Indicator(
      color: color,
      text: model.goals[i].title != null ? model.goals[i].title : 'N/A',
      isSquare: true,
    );
  }

  List<PieChartSectionData> showingSections(ProgressViewModel model) {
    double calculatePercentages(int i) {
      double sum = 0;
      for (int x = 0; x < model.goals.length; x++) {
        sum += model.goals[x].numberOfDays;
      }
      print(sum);
      return ((model.goals[i].numberOfDays) * 100) / sum;
    }

    return List.generate(model.goals.length, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;

      for (int x = 0; x < model.goals.length; x++) {
        return PieChartSectionData(
          color: availableColors[i],
          value: model.goals[i].numberOfDays.toDouble() != null
              ? (calculatePercentages(i))
              : 0,
          title: (calculatePercentages(i)).toStringAsFixed(1) + '%',
          radius: radius,
          titleStyle: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: const Color(0xffffffff)),
        );
      }

      // switch (i) {
      //   case 0:
      //     return PieChartSectionData(
      //       color: availableColors[i],
      //       value: model.goals[i].numberOfDays.toDouble() != null
      //           ? (calculatePercentages(i))
      //           : 0,
      //       title: (calculatePercentages(i)).toStringAsFixed(1) + '%',
      //       radius: radius,
      //       titleStyle: TextStyle(
      //           fontSize: fontSize,
      //           fontWeight: FontWeight.bold,
      //           color: const Color(0xffffffff)),
      //     );
      //   case 1:
      //     return PieChartSectionData(
      //       color: availableColors[i],
      //       value: model.goals[i].numberOfDays.toDouble() != null
      //           ? (calculatePercentages(i))
      //           : 0,
      //       title: (calculatePercentages(i)).toStringAsFixed(1) + '%',
      //       radius: radius,
      //       titleStyle: TextStyle(
      //           fontSize: fontSize,
      //           fontWeight: FontWeight.bold,
      //           color: const Color(0xffffffff)),
      //     );
      //   case 2:
      //     return PieChartSectionData(
      //       color: availableColors[i],
      //       value: model.goals[2].numberOfDays.toDouble() != null
      //           ? calculatePercentages(i)
      //           : 0,
      //       title: (calculatePercentages(i)).toStringAsFixed(1) + '%',
      //       radius: radius,
      //       titleStyle: TextStyle(
      //           fontSize: fontSize,
      //           fontWeight: FontWeight.bold,
      //           color: const Color(0xffffffff)),
      //     );
      //   case 3:
      //     return PieChartSectionData(
      //       color: availableColors[i],
      //       value: model.goals[3].numberOfDays.toDouble() != null
      //           ? calculatePercentages(i)
      //           : 0,
      //       title: (calculatePercentages(i)).toStringAsFixed(1) + '%',
      //       radius: radius,
      //       titleStyle: TextStyle(
      //           fontSize: fontSize,
      //           fontWeight: FontWeight.bold,
      //           color: const Color(0xffffffff)),
      //     );
      //   case 4:
      //     return PieChartSectionData(
      //       color: availableColors[i],
      //       value: model.goals[4].numberOfDays.toDouble() != null
      //           ? calculatePercentages(i)
      //           : 0,
      //       title: (calculatePercentages(i)).toStringAsFixed(1) + '%',
      //       radius: radius,
      //       titleStyle: TextStyle(
      //           fontSize: fontSize,
      //           fontWeight: FontWeight.bold,
      //           color: const Color(0xffffffff)),
      //     );
      //   case 5:
      //     return PieChartSectionData(
      //       color: availableColors[i],
      //       value: model.goals[5].numberOfDays.toDouble() != null
      //           ? calculatePercentages(i)
      //           : 0,
      //       title: (calculatePercentages(i)).toStringAsFixed(1) + '%',
      //       radius: radius,
      //       titleStyle: TextStyle(
      //           fontSize: fontSize,
      //           fontWeight: FontWeight.bold,
      //           color: const Color(0xffffffff)),
      //     );
      //   case 6:
      //     return PieChartSectionData(
      //       color: availableColors[i],
      //       value: model.goals[6].numberOfDays.toDouble() != null
      //           ? calculatePercentages(i)
      //           : 0,
      //       title: (calculatePercentages(i)).toStringAsFixed(1) + '%',
      //       radius: radius,
      //       titleStyle: TextStyle(
      //           fontSize: fontSize,
      //           fontWeight: FontWeight.bold,
      //           color: const Color(0xffffffff)),
      //     );
      //   default:
      //     throw Error();
      // }
    });
  }
}
