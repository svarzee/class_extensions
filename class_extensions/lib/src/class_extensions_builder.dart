import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:class_extensions/src/class_extension_generator.dart';
import 'package:dart_style/dart_style.dart';
import 'package:pedantic/pedantic.dart';
import 'package:source_gen/source_gen.dart';

class ClassExtensionsBuilder extends Builder {
  final List<ClassExtensionGenerator> _generators;
  final String Function(String) _formatOutput;
  final String _generatedExtension;
  @override
  final Map<String, List<String>> buildExtensions;

  ClassExtensionsBuilder(this._generators, String partId,
      {String Function(String) formatOutput})
      : _generatedExtension = '.$partId.g.part',
        buildExtensions = {
          '.dart': ['.$partId.g.part']
        },
        _formatOutput =
            formatOutput == null ? DartFormatter().format : formatOutput {
    if (partId == null) {
      throw ArgumentError.notNull('partId');
    }
    if (!RegExp(r'^[A-Za-z_\d-]+$').hasMatch(partId)) {
      throw ArgumentError.value(
          partId,
          'partId',
          '`partId` can only contain letters, numbers, `_` and `.`. '
              'It cannot start or end with `.`.');
    }
  }

  @override
  Future build(BuildStep buildStep) async {
    final resolver = buildStep.resolver;
    if (!await resolver.isLibrary(buildStep.inputId)) return;
    final lib = await buildStep.inputLibrary;
    await _generate(lib, buildStep);
  }

  Future _generate(LibraryElement library, BuildStep buildStep) async {
    final libraryReader = LibraryReader(library);
    final buildGraph = _createBuildGraph(libraryReader);
    final generatedOutput = buildGraph.entries
        .map((entry) => entry.value
            .map((generator) => generator.generateForAnnotatedElement(
                entry.key.element, entry.key.annotation, buildStep))
            .join('\n'))
        .join('\n\n');

    final outputId = buildStep.inputId.changeExtension(_generatedExtension);

    String formattedOutput;
    try {
      formattedOutput = _formatOutput(generatedOutput);
    } catch (e, stack) {
      log.severe(
          'Error formatting generated source code for ${library.identifier}'
          'which was output to ${outputId.path}.\n'
          'This may indicate an issue in the generated code or in the '
          'formatter.\n'
          'Please check the generated code and file an issue on source_gen if '
          'appropriate.',
          e,
          stack);
    }

    unawaited(buildStep.writeAsString(outputId, formattedOutput));
  }

  Map<AnnotatedElement, List<ClassExtensionGenerator>> _createBuildGraph(
      LibraryReader libraryReader) {
    return _generators
        .expand((generator) => libraryReader
            .annotatedWith(generator.typeChecker)
            .map((annotatedElement) => MapEntry(annotatedElement, generator)))
        .fold(
            Map<AnnotatedElement, List<ClassExtensionGenerator>>(),
            (Map<AnnotatedElement, List<ClassExtensionGenerator>> previousValue,
                    MapEntry<AnnotatedElement, ClassExtensionGenerator>
                        element) =>
                previousValue
                  ..update(element.key,
                      (generators) => generators..add(element.value),
                      ifAbsent: () => [element.value]));
  }
}
