import 'package:args/command_runner.dart';
import 'package:init_pro/commands/init_command.dart';
import 'package:init_pro/commands/create_feature_command.dart';

void main(List<String> arguments) {
  final runner = CommandRunner<void>(
    'init_pro',
    '''

A command-line tool for Flutter projects to generate boilerplate code and clean architecture setup.

Usage:
  init_pro <command> [options]

Commands:
  init             Initialize the Flutter project with default configurations
  create-feature   Generate boilerplate for a feature with clean architecture

Examples:
  dart pub run init_pro init
  dart pub run init_pro create-feature auth
    ''',
  )
    ..addCommand(InitCommand())
    ..addCommand(CreateFeatureCommand());

  // Run the command runner and handle exceptions
  runner.run(arguments).catchError((error) {
    if (error is UsageException) {
      print(error);
    } else {
      print('An unexpected error occurred: $error');
    }
  });
}
