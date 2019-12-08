import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:class_extensions/annotations.dart';
import 'package:source_gen/source_gen.dart';

class ExtensionEndGenerator extends GeneratorForAnnotation<Extension> {
  @override
  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    print("ExtensionEndGenerator");
    return '}';
  }
}
