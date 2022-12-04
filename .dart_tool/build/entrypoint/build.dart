// ignore_for_file: directives_ordering
// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:build_runner_core/build_runner_core.dart' as _i1;
import 'package:dart_json_mapper/builder_factory.dart' as _i2;
import 'package:build_config/build_config.dart' as _i3;
import 'package:build/build.dart' as _i4;
import 'package:source_gen/builder.dart' as _i5;
import 'package:auto_route_generator/builder.dart' as _i6;
import 'package:reflectable/reflectable_builder.dart' as _i7;
import 'dart:isolate' as _i8;
import 'package:build_runner/build_runner.dart' as _i9;
import 'dart:io' as _i10;

final _builders = <_i1.BuilderApplication>[
  _i1.apply(
    r'dart_json_mapper:dart_json_mapper',
    [_i2.dartJsonMapperBuilder],
    _i1.toRoot(),
    hideOutput: false,
    defaultGenerateFor: const _i3.InputSet(
      include: [
        r'benchmark/**.dart',
        r'bin/**.dart',
        r'test/_*.dart',
        r'example/**.dart',
        r'lib/main.dart',
        r'tool/**.dart',
        r'web/**.dart',
      ],
      exclude: [r'lib/**.dart'],
    ),
    defaultOptions: const _i4.BuilderOptions(<String, dynamic>{
      r'iterables': r'List, Set',
      r'extension': r'.mapper.g.dart',
      r'formatted': false,
    }),
  ),
  _i1.apply(
    r'source_gen:combining_builder',
    [_i5.combiningBuilder],
    _i1.toNoneByDefault(),
    hideOutput: false,
    appliesBuilders: const [r'source_gen:part_cleanup'],
  ),
  _i1.apply(
    r'auto_route_generator:autoRouteGenerator',
    [_i6.autoRouteGenerator],
    _i1.toDependentsOf(r'auto_route_generator'),
    hideOutput: false,
  ),
  _i1.apply(
    r'reflectable:reflectable',
    [_i7.reflectableBuilder],
    _i1.toRoot(),
    hideOutput: false,
    defaultGenerateFor: const _i3.InputSet(include: [
      r'benchmark/**.dart',
      r'bin/**.dart',
      r'example/**.dart',
      r'lib/main.dart',
      r'test/**.dart',
      r'tool/**.dart',
      r'web/**.dart',
    ]),
  ),
  _i1.applyPostProcess(
    r'source_gen:part_cleanup',
    _i5.partCleanup,
  ),
];
void main(
  List<String> args, [
  _i8.SendPort? sendPort,
]) async {
  var result = await _i9.run(
    args,
    _builders,
  );
  sendPort?.send(result);
  _i10.exitCode = result;
}
