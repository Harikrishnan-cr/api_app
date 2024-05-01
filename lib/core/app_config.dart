// import 'package:flutter/material.dart';

// class AppConfig extends InheritedWidget {
//   final String domain;
//   final String slugUrl;
//   String get baseUrl => domain + slugUrl;

//   const AppConfig({required this.domain, required this.slugUrl, super.key, required super.child});
  
//   @override
//   bool updateShouldNotify(covariant AppConfig oldWidget) {
//     return oldWidget.key != child.key;
//   }

//   static AppConfig of(BuildContext context) {
//     return context.dependOnInheritedWidgetOfExactType<AppConfig>()!;
//   }
// }
