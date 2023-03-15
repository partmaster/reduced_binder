// consumer.dart

import 'package:flutter/widgets.dart';
import 'package:reduced/reduced.dart';
import 'package:reduced_binder/reduced_binder.dart';

import 'props.dart';
import 'provider.dart';
import 'mappers.dart';

class MyHomePagePropsConsumer extends StatelessWidget {
  const MyHomePagePropsConsumer({
    super.key,
    required this.builder,
  });

  final WidgetFromPropsBuilder<MyHomePageProps> builder;

  @override
  Widget build(BuildContext context) => ReducedConsumer(
        logicRef: logicRef,
        mapper: MyHomePagePropsMapper.new,
        builder: builder,
      );
}

class MyCounterWidgetPropsConsumer extends StatelessWidget {
  const MyCounterWidgetPropsConsumer({
    super.key,
    required this.builder,
  });

  final WidgetFromPropsBuilder<MyCounterWidgetProps> builder;

  @override
  Widget build(context) => ReducedConsumer(
        logicRef: logicRef,
        mapper: MyCounterWidgetPropsMapper.new,
        builder: builder,
      );
}
