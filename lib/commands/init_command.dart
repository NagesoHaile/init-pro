import 'dart:io';

void initProject() {
  final currentDir = Directory.current;

  // check if pubspec.yaml exists
  final pubspecFile = File('${currentDir.path}/pubspec.yaml');
  if (!pubspecFile.existsSync()) {
    print(
        'Error: pubspec.yaml file not found. Please run this command inside a Flutter project.');
    exit(1);
  }

  // check if lib directory exits
  final libDir = Directory('${currentDir.path}/lib');
  if (!libDir.existsSync()) {
    print(
        'Error: lib/ directory not found. Please run this command inside a Flutter project.');
    exit(1);
  }

  // create a clean architecture folders
  final dataDir = Directory('${libDir.path}/data');
  final domainDir = Directory('${libDir.path}/domain');
  final presentationDir = Directory('${libDir.path}/presentation');

  dataDir.createSync(recursive: true);
  domainDir.createSync(recursive: true);
  presentationDir.createSync(recursive: true);

  print('Clean architecture folder structure created');
  print('  - lib/data');
  print('  - lib/domain');
  print('  - lib/presentation');

  // Create Default Helper Files
  final helperDir = Directory('${libDir.path}/helpers');
  helperDir.createSync(recursive: true);

  final apiHelper = File('${helperDir.path}/api_helper.dart');
  apiHelper.writeAsString('''
     class ApiHelper {
      // Your API helper methods here
     }
''');

  print('Helper file created: lib/helpers/api_helper.dart');

  final validators = File('${helperDir.path}/validators.dart');
  validators.writeAsString('''
    class Validators {
      static String? validateEmail(String email){
        if(email.isEmpty) return 'Email is required.';
         final regex = RegExp(r'^\\S+@\\S+\\.\\S+\$');
         return regex.hasMatch(email) ? null : 'Invalid email format';
      }
    }
''');

  print('Helper file created: lib/helpers/validators.dart');

  final configFile = File('${currentDir.path}/initpro_config.yaml');
  configFile.writeAsString('''
 # Configuration fro InitPro CLI Tool
 state_management: bloc
 use_themes:true
''');

  print('Configuration file created: initpro_config.yaml');
}
