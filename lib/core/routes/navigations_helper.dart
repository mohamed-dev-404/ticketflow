import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// A helper methods for navigation using GoRouter.

//* Pushes a new screen onto the navigation stack
Future<T?> push<T extends Object?>(
  BuildContext context,
  String routeName, {
  Object? extra,
}) {
  return GoRouter.of(context).push<T>(
    routeName,
    extra: extra,
  );
}

//* Pushes a new screen onto the navigation stack, replacing the current one.
Future<T?> pushReplacement<T extends Object?>(
  BuildContext context,
  String routeName, {
  Object? extra,
}) {
  return GoRouter.of(context).pushReplacement<T>(routeName, extra: extra);
}

//* Pushes a new screen and removes all previous screens from the stack.
void pushToBase(BuildContext context, String routeName, {Object? extra}) {
  context.go(routeName, extra: extra);
}

//* Pops the current screen off the navigation stack, returning to the previous screen.
void pop<T extends Object?>(BuildContext context, [T? result]) {
  context.pop<T>(result);
}
