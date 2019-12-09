import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:class_extensions_annotations/annotations.dart';
import 'package:source_gen/source_gen.dart';

class ExtensionStartGenerator extends GeneratorForAnnotation<Extension> {
  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    ClassElement clazz = element;
    return 'mixin _\$${clazz.name} {';
  }
}
