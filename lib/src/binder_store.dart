// binder_store.dart

import 'package:binder/binder.dart';
import 'package:flutter/widgets.dart';
// ignore: implementation_imports
import 'package:binder/src/build_context_extensions.dart';
import 'package:reduced/reduced.dart';

/// Derivation of the mixin [Logic] with support of the [Store] interface.
class ReducedStore<S> extends Store<S> with Logic {
  ReducedStore(this.scope, this.ref);

  final StateRef<S> ref;

  @override
  final Scope scope;

  @override
  get state => read(ref);

  @override
  process(event) => write(ref, event(state));
}

extension ExtensionLogicOnBuildContext on BuildContext {
  /// Convenience method for getting a [ReducedStore] instance.
  ReducedStore<S> store<S>(LogicRef<ReducedStore<S>> ref) =>
      readScope().use(ref);
}
