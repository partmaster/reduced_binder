// binder_widgets.dart

import 'package:binder/binder.dart';
import 'package:flutter/widgets.dart';
import 'package:reduced/reduced.dart';
// ignore: implementation_imports
import 'package:binder/src/build_context_extensions.dart';

import 'binder_store.dart';

typedef ReducedScope = BinderScope;

class ReducedConsumer<S, P> extends StatelessWidget {
  const ReducedConsumer({
    super.key,
    required this.logicRef,
    required this.transformer,
    required this.builder,
  });

  final LogicRef<Store<S>> logicRef;
  final ReducedTransformer<S, P> transformer;
  final ReducedWidgetBuilder<P> builder;

  @override
  Widget build(BuildContext context) =>
      _build(context.readScope().use(logicRef));

  Consumer<P> _build(Store<S> store) => Consumer<P>(
        watchable: store.ref.select(
          (state) =>
              transformer(ReducedStoreProxy(() => state, store.reduce, store)),
        ),
        builder: (_, props, ___) => builder(props: props),
      );
}
