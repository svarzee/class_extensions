import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:class_extensions/src/class_extension_generator.dart';
import 'package:dart_style/dart_style.dart';

class ClassExtensionsBuilder extends Builder {
  final List<ClassExtensionGenerator> generators;
  final String Function(String) formatOutput;

  @override
  final Map<String, List<String>> buildExtensions;

  ClassExtensionsBuilder(this.generators, String partId,
      {String Function(String) formatOutput,
      List<String> additionalOutputExtensions = const []})
      : buildExtensions = {
          '.dart': ['.$partId.g.part']..addAll(additionalOutputExtensions)
        },
        formatOutput =
            formatOutput == null ? DartFormatter().format : formatOutput {
    if (!RegExp(r'^[A-Za-z_\d-]+\$').hasMatch(partId)) {
      throw ArgumentError.value(
          partId,
          'partId',
          '`partId` can only contain letters, numbers, `_` and `.`. '
              'It cannot start or end with `.`.');
    }
    if (partId == null) {
      throw ArgumentError.notNull('partId');
    }
  }

  @override
  Future build(BuildStep buildStep) async {
    final resolver = buildStep.resolver;
    if (!await resolver.isLibrary(buildStep.inputId)) return;
    final lib = await buildStep.inputLibrary;
    await _generate(lib, buildStep);
  }

  Future _generate(LibraryElement library, BuildStep buildStep) async {}
}
