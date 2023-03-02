// binder_reducible.dart

import 'package:binder/binder.dart';
import 'package:flutter/widgets.dart';
// ignore: implementation_imports
import 'package:binder/src/build_context_extensions.dart';
import 'package:reduced/reduced.dart';

/// Derivation of the mixin [Logic] with support of the [Reducible] interface.
class ReducibleLogic<S> extends Reducible<S> with Logic {
  ReducibleLogic(this.scope, this.ref);

  final StateRef<S> ref;

  @override
  final Scope scope;

  @override
  get state => read(ref);

  @override
  reduce(reducer) => write(ref, reducer(state));
}

extension ExtensionLogicOnBuildContext on BuildContext {
  /// Convenience method for getting a [ReducibleLogic] instance.
  ReducibleLogic<S> logic<S>(LogicRef<ReducibleLogic<S>> ref) =>
      readScope().use(ref);
}
