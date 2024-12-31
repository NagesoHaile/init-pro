import 'package:init_pro/init_pro.dart' as init_pro;
import 'dart:io';
import 'package:args/args.dart';

import '../lib/commands/init_command.dart';

void main(List<String> arguments) {
  final parser = ArgParser()
    ..addCommand('init')
    ..addCommand('create')
    ..addCommand('add');

  try {
    final results = parser.parse(arguments);
    if (results.command == null) {
      print('No command provided. Use --help for a list of commands');
      exit(0);
    }

    switch (results.command!.name) {
      case 'init':
        _handleInitCommand(results.command!);
        break;
      case 'create':
        _handleCreateCommand(results.command!);
        break;
      case 'add':
        _handleAddCommand(results.command!);
        break;
      default:
        print('Unknown command. Use --help for a list of commands');
    }
  } catch (e) {
    print('Error: $e');
    print('Use --help for usage instructions.');
  }
  print('Hello world: ${init_pro.calculate()}!');
}

void _handleInitCommand(ArgResults args) {
  print('Initializing project...');
  initProject();
}

void _handleCreateCommand(ArgResults args) {
  print('Creating feature...');
}

void _handleAddCommand(ArgResults args) {
  print('Adding component...');
}
