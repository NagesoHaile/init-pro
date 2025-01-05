import 'dart:io';
import 'package:args/args.dart';
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
  // final parser = ArgParser()
  //   ..addCommand('init')
  //   ..addCommand('create')
  //   ..addCommand('add');

  // try {
  //   final results = parser.parse(arguments);
  //   if (results.command == null) {
  //     print('No command provided. Use --help for a list of commands');
  //     exit(0);
  //   }

  //   switch (results.command!.name) {
  //     case 'init':
  //       _handleInitCommand(results.command!);
  //       break;
  //     case 'create':
  //       _handleCreateCommand(results.command!);
  //       break;
  //     case 'add':
  //       _handleAddCommand(results.command!);
  //       break;
  //     default:
  //       print('Unknown command. Use --help for a list of commands');
  //   }
  // } catch (e) {
  //   print('Error: $e');
  //   print('Use --help for usage instructions.');
  // }
}

void _handleInitCommand(ArgResults args) {
  print('Initializing project...');
  initProject();
}

// void _printHelpDoc(ArgResults args){
//   print('''
//    Usage: dart pub run init_pro [arguments...]
//    \-\-help           Print this usage information
//   ''');
// }

void _handleCreateCommand(ArgResults args) {
  if (args.rest.isEmpty) {
    print('Error: Please provide a feature name.');
    return;
  }
  final featureName = args.rest[0];
  print('Creating feature $featureName...');
  createFeature(featureName);
}

void _handleAddCommand(ArgResults args) {
  print('Adding component...');
}
