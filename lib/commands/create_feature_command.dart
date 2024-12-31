import 'dart:io';
import 'package:yaml/yaml.dart';

void createFeature(String featureName) {
  if (featureName.isEmpty) {
    print('Error: Feature name is required');
    exit(1);
  }

  final pubspecFile = File('pubspec.yaml');
  String packageName = '';
  if (pubspecFile.existsSync()) {
    final pubspecContent = pubspecFile.readAsStringSync();
    final yamlMap = loadYaml(pubspecContent);
    packageName = yamlMap['name'];
  } else {
    print('Error: pubspec.yaml not found.');
    return;
  }

  final currentDir = Directory.current;
  final libDir = Directory('${currentDir.path}/lib');
  if (!libDir.existsSync()) {
    print(
        'Error: lib/ directory not found. Please run this command inside a Flutter project.');
    exit(1);
  }

  final featureDir = Directory('${libDir.path}/features/$featureName');
  if (featureDir.existsSync()) {
    print('Error: Feature "$featureName" already exists.');
    return;
  }

  // create Feature Directory Structure.
  final dataDir = Directory('${featureDir.path}/data');
  final domainDir = Directory('${featureDir.path}/domain');
  final presentationDir = Directory('${featureDir.path}/presentation');

  dataDir.createSync(recursive: true);
  domainDir.createSync(recursive: true);
  presentationDir.createSync(recursive: true);

  // Create sub-folders for data, domain, and presentation
  Directory('${dataDir.path}/data_sources').createSync(recursive: true);
  Directory('${dataDir.path}/models').createSync(recursive: true);
  Directory('${dataDir.path}/repositories').createSync(recursive: true);

  Directory('${domainDir.path}/use_cases').createSync(recursive: true);
  Directory('${domainDir.path}/repositories').createSync(recursive: true);
  Directory('${domainDir.path}/entities').createSync(recursive: true);

  Directory('${presentationDir.path}/blocs').createSync(recursive: true);
  Directory('${presentationDir.path}/presentation').createSync(recursive: true);
  Directory('${presentationDir.path}/widgets').createSync(recursive: true);

  print('Feature "$featureName" folder structure created:');
  print('  - ${dataDir.path}');
  print('  - ${domainDir.path}');
  print('  - ${presentationDir.path}');

  // Generate starter files
  _createFile(dataDir.path, 'data_sources/${featureName}_api_service.dart', '''
class  ${_capitalize(featureName)}ApiService {
        // Define data fetching methods for $featureName
  }
''');

  _createFile(
      dataDir.path, 'repositories/${featureName}_repository_impl.dart', '''
  import 'package:$packageName/features/$featureName/domain/repositories/${featureName}_repository.dart';
class  ${_capitalize(featureName)}RepositoryImpl implements ${_capitalize(featureName)}Repository  {
      // Implement repository methods to access data sources for $featureName
  }
''');

  _createFile(domainDir.path, 'use_cases/${featureName}_use_case.dart', '''
class ${_capitalize(featureName)}UseCase {
        // Define use case logic for $featureName
  }
''');

  _createFile(domainDir.path, 'repositories/${featureName}_repository.dart', '''
 abstract class  ${_capitalize(featureName)}Repository {
   // Define the contract for $featureName repository methods
  }
''');

  _createFile(
      presentationDir.path, 'presentation/${featureName}_screen.dart', '''
   // write your flutter code here.
''');
}

void _createFile(String dirPath, String fileName, String content) {
  final file = File('$dirPath/$fileName');
  file.writeAsString(content);
  print('File created: $dirPath/$fileName');
}

String _capitalize(String input) {
  if (input.isEmpty) return input;
  return input[0].toUpperCase() + input.substring(1);
}
