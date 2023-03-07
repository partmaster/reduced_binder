// main.dart

import 'package:flutter/material.dart';
import 'package:binder/binder.dart';
import 'package:reduced_binder/reduced_binder.dart';
import 'logic.dart';

final stateRef = StateRef(0);
final logicRef = LogicRef((scope) => ReducibleLogic(scope, stateRef));

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue),
        home: wrapWithConsumer(
          logicRef: logicRef,
          transformer: PropsTransformer.transform,
          builder: MyHomePage.new,
        ),
      );
}
