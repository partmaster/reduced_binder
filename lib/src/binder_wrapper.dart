// binder_wrapper.dart

import 'package:binder/binder.dart';
import 'package:flutter/widgets.dart';
import 'package:reduced/reduced.dart';

import 'binder_reducible.dart';

/// Wraps the given child with a BinderScope.
Widget wrapWithScope({required Widget child}) => BinderScope(child: child);

extension WrapWithConsumer<S> on ReducibleLogic<S> {
  /// Builds a widget with the given builder and wraps it with a Consumer.
  Widget wrapWithConsumer<P>({
    required StateRef<S> stateRef,
    required ReducedTransformer<S, P> transformer,
    required ReducedWidgetBuilder<P> builder,
  }) =>
      Consumer<P>(
        watchable: stateRef.select((state) => transformer(this)),
        builder: (_, __, ___) => builder(props: transformer(this)),
      );
}
