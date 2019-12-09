import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/extension_end_generator.dart';
import 'src/extension_start_generator.dart';

Builder extensionStartBuilder(BuilderOptions options) =>
    SharedPartBuilder([ExtensionStartGenerator()], '0_extension_start',
        formatOutput: (code) => code);

Builder extensionEndBuilder(BuilderOptions options) =>
    SharedPartBuilder([ExtensionEndGenerator()], '9_extension_end',
        formatOutput: (code) => code);
