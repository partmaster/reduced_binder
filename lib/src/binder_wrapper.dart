// binder_wrapper.dart

import 'package:binder/binder.dart';
import 'package:flutter/widgets.dart';
import 'package:reduced/reduced.dart';
// ignore: implementation_imports
import 'package:binder/src/build_context_extensions.dart';

import 'binder_reducible.dart';

/// Wraps the given child with a BinderScope.
Widget wrapWithScope({required Widget child}) =>
    BinderScope(child: child);

/// Builds a widget with the given builder and wraps it with a Consumer.
Widget wrapWithConsumer<S, P>({
  required LogicRef<ReducibleLogic<S>> logicRef,
  required ReducedTransformer<S, P> transformer,
  required ReducedWidgetBuilder<P> builder,
}) =>
    Builder(
      builder: (context) => internalWrapWithConsumer(
        logic: context.readScope().use(logicRef),
        transformer: transformer,
        builder: builder,
      ),
    );

@visibleForTesting
Consumer<P> internalWrapWithConsumer<S, P>({
  required ReducibleLogic<S> logic,
  required ReducedTransformer<S, P> transformer,
  required ReducedWidgetBuilder<P> builder,
}) =>
    Consumer<P>(
      watchable: logic.ref.select((state) => transformer(logic)),
      builder: (_, __, ___) => builder(props: transformer(logic)),
    );
