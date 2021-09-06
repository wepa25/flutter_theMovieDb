import 'package:flutter/material.dart';

class NotifierProvider<Model extends ChangeNotifier>extends InheritedNotifier {
  final Model model;
  const NotifierProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key, child: child, notifier: model);


  static Model? watch<Model extends ChangeNotifier>(BuildContext context) {
    final result =
    context.dependOnInheritedWidgetOfExactType<NotifierProvider<Model>>()?.model;
    return result;
  }

  static Model? read<Model extends ChangeNotifier>(BuildContext context) {
    final result =
        context.getElementForInheritedWidgetOfExactType<NotifierProvider<Model>>()?.widget;
    return result is NotifierProvider<Model> ? result.model : null;
  }
}


class Provider<Model> extends InheritedWidget {
  final Model model;
  const Provider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key, child: child);

  static Model? watch<Model>(BuildContext context) {
    final Model? result =
        context.dependOnInheritedWidgetOfExactType<Provider<Model>>()?.model;
    return result;
  }

  static Model? read<Model>(BuildContext context) {
    final result =
        context.getElementForInheritedWidgetOfExactType<Provider<Model>>()?.widget;
    return result is Provider<Model> ? result.model : null;
  }

  @override
  bool updateShouldNotify(Provider old) {
    return model != old.model;
  }
}