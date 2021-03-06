import 'package:class_extensions_annotations/annotations.dart';
import 'package:meta/meta.dart';

part 'model.g.dart';

@Extension()
@immutable
class SomeValueClass with _$SomeValueClass {
  final String strVal;
  final int intVal;

  SomeValueClass(this.strVal, this.intVal);
}

@Extension()
@immutable
class OtherValueClass with _$OtherValueClass {
  final String strVal;
  final int intVal;

  OtherValueClass(this.strVal, this.intVal);
}
