import 'package:binder/src/core.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:reduced_binder/reduced_binder.dart';

void main() {
  test('Store state 0', () {
    final scope = BinderScopeState();
    final stateRef = StateRef(0);
    final objectUnderTest = ReducedStore(scope, stateRef);
    expect(objectUnderTest.state, 0);
  });

  test('Store state 1', () {
    final scope = BinderScopeState();
    final stateRef = StateRef(1);
    final objectUnderTest = ReducedStore(scope, stateRef);
    expect(objectUnderTest.state, 1);
  });
}
