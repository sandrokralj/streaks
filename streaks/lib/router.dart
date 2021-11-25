import 'package:flutter/material.dart';
import 'package:streaks/constants/route_names.dart';
import 'package:streaks/views/create_goal/create_goal_widget.dart';
import 'package:streaks/views/friend_add/friend_add.dart';
import 'package:streaks/views/friend_list/friend_list.dart';
import 'package:streaks/views/home_page/home_page.dart';
import 'package:streaks/views/sign_in/sign_in.dart';
import 'package:streaks/views/sign_up/sign_up.dart';

import 'models/goal.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case CreateGoalViewRoute:
      var goalToEdit = settings.arguments as Goal;
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: CreateGoalWidget(
          edittingGoal: goalToEdit,
        ),
      );
    case SigninViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: SignIn(),
      );
    case SignUpViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: SignUp(),
      );
        case FriendListViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: FriendListWidget(),
      );
      case FriendAddViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: FriendAddWidget(),
      );
    case HomeViewRoute:
      return _getPageRoute(
        routeName: settings.name,
        viewToShow: HomePage(),
      );
    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                body: Center(
                    child: Text('No route defined for ${settings.name}')),
              ));
  }
}

PageRoute _getPageRoute({String routeName, Widget viewToShow}) {
  return MaterialPageRoute(
      settings: RouteSettings(
        name: routeName,
      ),
      builder: (_) => viewToShow);
}
