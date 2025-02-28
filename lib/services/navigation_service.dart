import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NavigationService {
  late GlobalKey<NavigatorState> navigatorKey;

  NavigationService() {
    navigatorKey = GlobalKey<NavigatorState>();
  }

  navigate(Widget screen) {
    return navigatorKey.currentState!
        .push(MaterialPageRoute(builder: (context) => screen));
  }

  navigateReplacing(Widget screen) {
    return navigatorKey.currentState!
        .pushReplacement(MaterialPageRoute(builder: (context) => screen));
  }

  navigatePop() {
    return navigatorKey.currentState!.pop();
  }

  Future<void> showDialog(Widget widget, {BuildContext? context}) async {
    await showAdaptiveDialog(
        context: context ?? navigatorKey.currentContext!,
        builder: (context) => widget);
  }

  void showSnackBar({String? text, Widget? widget}) {
    BuildContext context = navigatorKey.currentContext!;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    Widget widgetShowed = widget ??
        (Text(
          text ?? "Error",
          style: TextStyle(color: Colors.white),
        ));
    SnackBar snackBar = SnackBar(content: widgetShowed);
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
