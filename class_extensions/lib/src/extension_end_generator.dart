import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:class_extensions/src/class_extension_generator.dart';
import 'package:class_extensions_annotations/annotations.dart';
import 'package:source_gen/source_gen.dart';

class ExtensionEndGenerator extends ClassExtensionGenerator<Extension> {
  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    return '}';
  }
}
