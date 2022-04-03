import 'package:flutter/material.dart';

import 'bloc_demo/counter.dart';

/// {@template counter_app}
/// A [MaterialApp] which sets the `home` to [CounterPage].
/// {@endtemplate}
class CounterApp extends MaterialApp {
  @override

  /// {@macro counter_app}
  CounterApp({Key? key})
      : super(
            key: key,
            home: const CounterPage(),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(primarySwatch: Colors.purple));
}
