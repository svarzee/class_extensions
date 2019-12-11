import 'package:build/build.dart';
import 'package:class_extensions/src/class_extension_generator.dart';
import 'package:class_extensions/src/class_extensions_builder.dart';

final List<ClassExtensionGenerator> classExtensionGenerators = [];

Builder classExtensionsBuilder(BuilderOptions options) =>
    ClassExtensionsBuilder(classExtensionGenerators, 'class_extensions');
