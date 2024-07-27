import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppNavigator {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  static toNamed(String routeName, {Object? arguments, Map<String, String>? parameter}) {
    return navigatorKey.currentContext?.pushNamed(
      routeName,
      extra: arguments,
      pathParameters: parameter ?? {},
    );
  }

  static toReplaceNamed(String routeName, {Object? arguments, Map<String, String>? parameter}) {
    return navigatorKey.currentContext?.pushReplacementNamed(
      routeName,
      pathParameters: parameter ?? {},
      extra: arguments,
    );
  }

  static toRemoveAllName(String routeName, {Object? arguments, Map<String, String>? parameter}) {
    return navigatorKey.currentContext?.goNamed(
      routeName,
      extra: arguments,
      pathParameters: parameter ?? {},
    );
  }

  static bool canPop() {
    return navigatorKey.currentContext?.canPop() ?? false;
  }

  static void pop([Object? result]) {
    if (navigatorKey.currentState?.canPop() ?? false) {
      navigatorKey.currentState?.pop(result);
    }
  }

  static void popUntil([String? path]) {
    Future.delayed(
      Duration.zero,
          () {
        navigatorKey.currentState?.popUntil(
              (route) {
            if (path != null) {
              return route.settings.name == path;
            }
            return route.isFirst;
          },
        );
      },
    );
  }

  static showSnackBar(String title, String message, [BuildContext? context]) {
    context = (AppNavigator.navigatorKey.currentContext ?? context);
    if (context != null) {
      var snackBar = SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Theme.of(context).primaryColor,
        padding: const EdgeInsets.symmetric(vertical: 5),
        dismissDirection: DismissDirection.down,
        duration: const Duration(seconds: 5),
        clipBehavior: Clip.none,
        content: Container(
          width: double.infinity,
          margin: const EdgeInsets.all(10),
          child: ListTile(
            title: Text(
              title,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).cardColor),
            ),
            subtitle: Text(
              message,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(color: Theme.of(context).cardColor),
            ),
          ),
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}
