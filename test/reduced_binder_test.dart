import 'package:binder/src/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:reduced/reduced.dart';

import 'package:reduced_binder/reduced_binder.dart';

class Incrementer extends Reducer<int> {
  @override
  int call(int state) {
    return state + 1;
  }
}

void main() {
  test('ReducibleLogic state 0', () {
    final scope = BinderScopeState();
    final stateRef = StateRef(0);
    final objectUnderTest = Store(scope, stateRef);
    expect(objectUnderTest.state, 0);
  });

  test('ReducibleLogic state 1', () {
    final scope = BinderScopeState();
    final stateRef = StateRef(1);
    final objectUnderTest = Store(scope, stateRef);
    expect(objectUnderTest.state, 1);
  });
}
