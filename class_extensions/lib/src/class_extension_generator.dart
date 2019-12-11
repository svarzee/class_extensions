import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

abstract class ClassExtensionGenerator<T> {
  TypeChecker get typeChecker => TypeChecker.fromRuntime(T);

  String generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep);
}
