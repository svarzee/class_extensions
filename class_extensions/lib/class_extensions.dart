import 'package:build/build.dart';
import 'package:class_extensions/src/class_extension_generator.dart';
import 'package:class_extensions/src/class_extensions_builder.dart';
import 'package:class_extensions/src/dummy_builder.dart';
import 'package:class_extensions/src/extension_end_generator.dart';
import 'package:class_extensions/src/extension_start_generator.dart';

export 'src/class_extension_generator.dart';
export 'src/class_extensions_builder.dart';

final List<OrderedGenerator> _orderedGenerators = [];

class OrderedGenerator {
  int order;
  ClassExtensionGenerator classExtensionGenerator;

  OrderedGenerator(this.order, this.classExtensionGenerator);
}

DummyBuilder registerClassExtensionGenerator(
    int order, ClassExtensionGenerator generator) {
  _orderedGenerators.add(OrderedGenerator(order, generator));
  _orderedGenerators.sort((left, right) => left.order.compareTo(order));
  return DummyBuilder();
}

Builder classExtensionsBuilder(
        BuilderOptions options) =>
    ClassExtensionsBuilder(
        _orderedGenerators
            .map((generator) => generator.classExtensionGenerator),
        'class_extensions');

Builder extensionEndDummyBuilder(BuilderOptions options) =>
    registerClassExtensionGenerator(0, ExtensionEndGenerator());

Builder extensionStartDummyBuilder(BuilderOptions options) =>
    registerClassExtensionGenerator(100, ExtensionStartGenerator());
