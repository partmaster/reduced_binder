// consumer.dart

import 'package:binder/binder.dart';
import 'package:counter_app_with_selective_rebuild/state.dart';
import 'package:flutter/widgets.dart';
import 'package:reduced/reduced.dart';
import 'package:reduced_binder/reduced_binder.dart';

import 'props.dart';
import 'provider.dart';
import 'transformer.dart';

class MyHomePagePropsConsumer extends StatelessWidget {
  const MyHomePagePropsConsumer({
    super.key,
    required this.builder,
  });

  final ReducedWidgetBuilder<MyHomePageProps> builder;

  @override
  Widget build(BuildContext context) => ReducedConsumer(
        logicRef: logicRef,
        transformer: transformMyHomePageProps,
        builder: builder,
      );
}

class MyCounterWidgetPropsConsumer extends StatelessWidget {
  const MyCounterWidgetPropsConsumer({
    super.key,
    required this.builder,
  });

  final ReducedWidgetBuilder<MyCounterWidgetProps> builder;

  @override
  Widget build(context) => ReducedConsumer(
        logicRef: logicRef,
        transformer: transformMyCounterWidgetProps,
        builder: builder,
      );
}
