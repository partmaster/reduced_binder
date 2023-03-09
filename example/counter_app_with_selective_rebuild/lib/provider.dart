// provider.dart

import 'package:binder/binder.dart';
import 'package:reduced_binder/reduced_binder.dart';

import 'state.dart';

final stateRef = StateRef(
  MyAppState(title: 'reduced_binder example'),
);

final logicRef = LogicRef((scope) => Store(scope, stateRef));
