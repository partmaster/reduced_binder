// widgets.dart

import 'package:flutter/material.dart';
import 'package:reduced_binder/reduced_binder.dart';

import 'consumer.dart';
import 'props.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => ReducedScope(
        child: MaterialApp(
          theme: ThemeData(primarySwatch: Colors.blue),
          home: const MyHomePagePropsConsumer(builder: MyHomePage.new),
        ),
      );
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.props});

  final MyHomePageProps props;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: Text(props.title)),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Text(
                'You have pushed the button this many times:',
              ),
              MyCounterWidgetPropsConsumer(
                builder: MyCounterWidget.new,
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: props.onPressed,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      );
}

class MyCounterWidget extends StatelessWidget {
  const MyCounterWidget({super.key, required this.props});

  final MyCounterWidgetProps props;

  @override
  Widget build(BuildContext context) {
    print('MyCounterWidget#build text=${props.counterText}');
    return Text(props.counterText);
  }
}
