![GitHub release (latest by date)](https://img.shields.io/github/v/release/partmaster/reduced_binder)
![GitHub Workflow Status](https://img.shields.io/github/actions/workflow/status/partmaster/reduced_binder/dart.yml)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/partmaster/reduced_binder)
![GitHub last commit](https://img.shields.io/github/last-commit/partmaster/reduced_binder)
![GitHub commit activity](https://img.shields.io/github/commit-activity/m/partmaster/reduced_binder)
# reduced_binder

Implementation of the 'reduced' API for the 'Binder' state management framework with following features:

1. Implementation of the ```Reducible``` interface 
2. Extension on the ```BuildContext``` for convenient access to the  ```Reducible``` instance.
3. Add a state management scope.
4. Trigger a rebuild on widgets selectively after a state change.

## Features

#### 1. Implementation of the ```Reducible``` interface 

```dart
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
```

#### 2. Extension on the ```BuildContext``` for convenient access to the  ```Reducible``` instance.

```dart
extension ExtensionLogicOnBuildContext on BuildContext {
  ReducibleLogic<S> logic<S>(LogicRef<ReducibleLogic<S>> ref) =>
      readScope().use(ref);
}
```

#### 3. Add a state management scope.

```dart
Widget wrapWithScope({required Widget child}) =>
    BinderScope(child: child);
```

#### 4. Trigger a rebuild on widgets selectively after a state change.

```dart
extension WrapWithConsumer<S> on ReducibleLogic<S> {
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
```

## Getting started

In the pubspec.yaml add dependencies on the packages 'reduced', 'reduced_binder' and 'binder'.

```
dependencies:
  reduced: ^0.1.0
  reduced_binder: ^0.1.0
  binder: ^0.4.0
```

Import package 'reduced' to implement the logic.

```dart
import 'package:reduced/reduced.dart';
```

Import package 'reduced' to use the logic.

```dart
import 'package:reduced_binder/reduced_binder.dart';
```

## Usage

Implementation of the counter demo app logic with the 'reduced' API without further dependencies on state management packages.

```dart
// logic.dart

import 'package:flutter/material.dart';
import 'package:reduced/reduced.dart';

class Incrementer extends Reducer<int> {
  @override
  int call(int state) => state + 1;
}

class Props {
  Props({required this.counterText, required this.onPressed});
  final String counterText;
  final Callable<void> onPressed;
}

class PropsTransformer {
  static Props transform(Reducible<int> reducible) => Props(
        counterText: '${reducible.state}',
        onPressed: CallableAdapter(reducible, Incrementer()),
      );
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.props});

  final Props props;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('reduced_binder example')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(props.counterText),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: props.onPressed,
          tooltip: 'Increment',
          child: const Icon(Icons.add),
        ),
      );
}
```

Finished counter demo app using logic.dart and 'reduced_binder' package:

```dart
// main.dart

import 'package:flutter/material.dart';
import 'package:binder/binder.dart';
import 'package:reduced_binder/reduced_binder.dart';
import 'logic.dart';

final stateRef = StateRef(0);
final logicRef = LogicRef((scope) => ReducibleLogic(scope, stateRef));

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Builder(
          builder: (context) =>
              context.logic(logicRef).wrapWithConsumer(
                    stateRef: stateRef,
                    transformer: PropsTransformer.transform,
                    builder: MyHomePage.new,
                  ),
        ),
      );
}
```

# Additional information

Implementations of the 'reduced' API are available for the following state management frameworks:

|framework|implementation package for 'reduced' API|
|---|---|
|[Binder](https://pub.dev/packages/binder)|[reduced_binder](https://github.com/partmaster/reduced_binder)|
|[Bloc](https://bloclibrary.dev/#/)|[reduced_bloc](https://github.com/partmaster/reduced_bloc)|
|[GetIt](https://pub.dev/packages/get_it)|[reduced_getit](https://github.com/partmaster/reduced_getit)|
|[GetX](https://pub.dev/packages/get)|[reduced_getx](https://github.com/partmaster/reduced_getx)|
|[Provider](https://pub.dev/packages/provider)|[reduced_provider](https://github.com/partmaster/reduced_provider)|
|[Redux](https://pub.dev/packages/redux)|[reduced_redux](https://github.com/partmaster/reduced_redux)|
|[Riverpod](https://riverpod.dev/)|[reduced_riverpod](https://github.com/partmaster/reduced_riverpod)|
