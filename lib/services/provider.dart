import 'package:flutter/material.dart';

import 'package:simple_calculator/services/keyboard_bloc.dart';

class Provider extends InheritedWidget {
  final keyboardBloc = KeyboardBloc();

  Provider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static KeyboardBloc of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<Provider>().keyboardBloc;
  }
}
