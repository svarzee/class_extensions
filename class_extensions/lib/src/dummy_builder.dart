import 'dart:async';

import 'package:build/build.dart';

class DummyBuilder extends Builder {
  @override
  FutureOr<void> build(BuildStep buildStep) => null;

  @override
  Map<String, List<String>> get buildExtensions => {};
}
