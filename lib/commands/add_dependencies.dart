import 'dart:io';
import 'package:yaml/yaml.dart';
import 'package:yaml_edit/yaml_edit.dart';

Future<void> addDependencies(String projectPath) async {
  final pubspecPath = '$projectPath/pubspec.yaml';
  final pubspecFile = File(pubspecPath);
  if (!pubspecFile.existsSync()) {
    print('pubspec.yaml not found in the project directory.');
    return;
  }

  try {
    final content = pubspecFile.readAsStringSync();
    final editor = YamlEditor(content);

    final requiredDependencies = {
      'flutter_bloc': '^8.1.0',
      'get_it': '^7.2.0',
    };

    // parse the existing dependencies
    final yamlMap = loadYaml(content) as Map;

    // Add dependencies if not already present
    if (yamlMap['dependencies'] is Map) {
      requiredDependencies.forEach((key, version) {
        if (!(yamlMap['dependencies'] as Map).containsKey(key)) {
          editor.update(['dependencies', key], version);
        }
      });
    } else {
      // Create a dependencies section if not present
      editor.update(['dependencies'], requiredDependencies);
    }

    pubspecFile.writeAsString(editor.toString());
    print('Dependencies added successfully!');
  } catch (e) {
    print('Error while updating pubspec.yaml: $e');
  }
}
