import 'package:build/build.dart';
import 'package:class_extensions/src/class_extension_generator.dart';
import 'package:class_extensions/src/class_extensions_builder.dart';
import 'package:class_extensions/src/dummy_builder.dart';
import 'package:class_extensions/src/extension_end_generator.dart';
import 'package:class_extensions/src/extension_start_generator.dart';

export 'src/class_extension_generator.dart';
export 'src/class_extensions_builder.dart';

final List<ClassExtensionGenerator> classExtensionGenerators = [];

DummyBuilder registerClassExtensionGenerator(
    ClassExtensionGenerator generator) {
  classExtensionGenerators.add(generator);
  return DummyBuilder();
}

Builder classExtensionsBuilder(BuilderOptions options) =>
    ClassExtensionsBuilder(classExtensionGenerators, 'class_extensions');

Builder extensionEndDummyBuilder(BuilderOptions options) =>
    registerClassExtensionGenerator(ExtensionEndGenerator());

Builder extensionStartDummyBuilder(BuilderOptions options) =>
    registerClassExtensionGenerator(ExtensionStartGenerator());
