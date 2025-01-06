import 'dart:io';
import 'package:yaml/yaml.dart';
import 'package:yaml_edit/yaml_edit.dart';

/// Adds required dependencies to the `pubspec.yaml` file of a Flutter project.
///
/// This function checks if the `pubspec.yaml` file exists in the specified project directory,
/// parses the YAML content, and adds the required dependencies to the `dependencies` section if they
/// are not already present. If the `dependencies` section does not exist, it is created.
Future<void> addDependencies(String projectPath) async {
  // Define the path to the pubspec.yaml file
  final pubspecPath = '$projectPath/pubspec.yaml';
  final pubspecFile = File(pubspecPath);

  // Check if the pubspec.yaml file exists in the provided project directory
  if (!pubspecFile.existsSync()) {
    print('pubspec.yaml not found in the project directory.');
    return;
  }

  try {
    // Read the content of the pubspec.yaml file
    final content = pubspecFile.readAsStringSync();
    final editor = YamlEditor(content);

    // Define the required dependencies to be added
    final requiredDependencies = {
      'flutter_bloc': '^8.1.0',
      'get_it': '^7.2.0',
    };

    // Parse the existing YAML content
    final yamlMap = loadYaml(content) as Map;

    // Add each required dependency if it is not already in the dependencies section
    if (yamlMap['dependencies'] is Map) {
      requiredDependencies.forEach((key, version) {
        if (!(yamlMap['dependencies'] as Map).containsKey(key)) {
          // Update the editor with the new dependency
          editor.update(['dependencies', key], version);
        }
      });
    } else {
      // If no 'dependencies' section exists, create one and add the dependencies
      editor.update(['dependencies'], requiredDependencies);
    }

    // Write the updated content back to the pubspec.yaml file
    pubspecFile.writeAsString(editor.toString());
    print('Dependencies added successfully!');
  } catch (e) {
    print('Error while updating pubspec.yaml: $e');
  }
}
