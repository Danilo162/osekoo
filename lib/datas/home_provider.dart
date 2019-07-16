import 'package:flutter/material.dart';

class HomePageProvide extends InheritedWidget {
  final Widget child;
  HomePageProvide({this.child}) : super(child: child);
  static HomePageProvide of(BuildContext context) =>
      context.inheritFromWidgetOfExactType(HomePageProvide);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    // TODO: implement updateShouldNotify
    return null;
  }

//  @override
//  bool updateShouldNotify(HomePageProvide oldWidget) =>
//      productBloc != oldWidget.productBloc;
}
