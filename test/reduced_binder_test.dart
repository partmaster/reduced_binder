import 'package:binder/binder.dart';
import 'package:binder/src/core.dart';
import 'package:flutter/widgets.dart';
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
    final objectUnderTest = ReducibleLogic(scope, stateRef);
    expect(objectUnderTest.state, 0);
  });

  test('ReducibleLogic state 1', () {
    final scope = BinderScopeState();
    final stateRef = StateRef(1);
    final objectUnderTest = ReducibleLogic(scope, stateRef);
    expect(objectUnderTest.state, 1);
  });

  test('wrapWithScope', () {
    const child = SizedBox();
    final objectUnderTest = wrapWithScope(child: child);
    expect(objectUnderTest, isA<BinderScope>());
    final scope = objectUnderTest as BinderScope;
    expect(scope.child, child);
  });

  test('wrapWithConsumer', () {
    final stateRef = StateRef(0);
    final scope = BinderScopeState();
    final objectUnderTest = ReducibleLogic(scope, stateRef);
    const child = SizedBox();
    final consumer = objectUnderTest.wrapWithConsumer(
      stateRef: stateRef,
      builder: ({Key? key, required int props}) => child,
      transformer: (reducible) => 1,
    );
    expect(consumer, isA<Consumer>());
  });
}
