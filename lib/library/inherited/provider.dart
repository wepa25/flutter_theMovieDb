import 'package:flutter/material.dart';


class NotifierProvider<Model extends ChangeNotifier> extends StatefulWidget {
  final Model Function() create;
  final bool isManagingModel;
  final Widget child;
  const NotifierProvider({
    Key? key,
    required this.child,
    this.isManagingModel = true,
    required this.create,
  }) : super(key: key);

  static Model? watch<Model extends ChangeNotifier>(BuildContext context) {
    final result =
        context.dependOnInheritedWidgetOfExactType<_InheritedNotifierProvider<Model>>()?.model;
    return result;
  }

  static Model? read<Model extends ChangeNotifier>(BuildContext context) {
    final result =
        context.getElementForInheritedWidgetOfExactType<_InheritedNotifierProvider<Model>>()?.widget;
    return result is _InheritedNotifierProvider<Model> ? result.model : null;
  }

  @override
  _NotifierProviderState<Model> createState() => _NotifierProviderState<Model>();
}

class _NotifierProviderState <Model extends ChangeNotifier> extends State<NotifierProvider<Model>> {
  late final Model _model;
  @override
  void initState() {
    super.initState();
    _model = widget.create();
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedNotifierProvider(child: widget.child,model: _model,);
  }

  @override
  void dispose() {
    if(widget.isManagingModel){
      _model.dispose();
    }
    super.dispose();
  }
}




class _InheritedNotifierProvider<Model extends ChangeNotifier>extends InheritedNotifier {
  final Model model;
  const _InheritedNotifierProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key, child: child, notifier: model);



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