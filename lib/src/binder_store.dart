// binder_store.dart

import 'package:binder/binder.dart';
import 'package:flutter/widgets.dart';
// ignore: implementation_imports
import 'package:binder/src/build_context_extensions.dart';
import 'package:reduced/reduced.dart';

/// Derivation of the mixin [Logic] with support of the [ReducedStore] interface.
class Store<S> extends ReducedStore<S> with Logic {
  Store(this.scope, this.ref);

  final StateRef<S> ref;

  @override
  final Scope scope;

  @override
  get state => read(ref);

  @override
  dispatch(event) => write(ref, event(state));
}

extension ExtensionLogicOnBuildContext on BuildContext {
  /// Convenience method for getting a [Store] instance.
  Store<S> store<S>(LogicRef<Store<S>> ref) => readScope().use(ref);
}
