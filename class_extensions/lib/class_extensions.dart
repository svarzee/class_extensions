import 'package:build/build.dart';

import 'src/class_extension_generator.dart';
import 'src/class_extensions_builder.dart';
import 'src/dummy_builder.dart';
import 'src/extension_end_generator.dart';
import 'src/extension_start_generator.dart';
import 'src/ordered_generator.dart';

export 'src/class_extension_generator.dart';
export 'src/class_extensions_builder.dart';

final List<OrderedGenerator> _orderedGenerators = [];

DummyBuilder registerClassExtensionGenerator(
    int order, ClassExtensionGenerator generator) {
  if (!_orderedGenerators.any((generator) => generator.order == order)) {
    _orderedGenerators.add(OrderedGenerator(order, generator));
    _orderedGenerators.sort((left, right) => left.order.compareTo(right.order));
  }
  return DummyBuilder();
}

Builder classExtensionsBuilder(BuilderOptions options) =>
    ClassExtensionsBuilder(_orderedGenerators, 'class_extensions');

Builder extensionEndDummyBuilder(BuilderOptions options) =>
    registerClassExtensionGenerator(100, ExtensionEndGenerator());

Builder extensionStartDummyBuilder(BuilderOptions options) =>
    registerClassExtensionGenerator(0, ExtensionStartGenerator());
