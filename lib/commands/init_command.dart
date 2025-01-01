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

  // create main.dart file with the necessary setup
  final mainFile = File('lib/main.dart');
  mainFile.createSync(recursive: true);
  mainFile.writeAsStringSync('''
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'app.dart';
import 'core/utils/bloc_observer.dart';
import 'dependency_injector.dart';

FutureOr<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Ensure that the dependencies are initialized
  await initializeDependencies();
  Bloc.observer = MyAppBlocObserver();
  runApp(const App());
}
''');

  print('main.dart file re-written successfully.');

  // Create app.dart file with MaterialApp.router

  final appFile = File('lib/app.dart');

  appFile.createSync(recursive: true);

  appFile.writeAsStringSync('''
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'core/theme/theme.dart';
import 'router.dart';


class App extends StatelessWidget  {
  const App({super.key});

  @override
  Widget build(BuildContext context){
    return Material.router(
      dartTheme: Style.dark,
      theme: Style.light,
      routerConfig:router,
      debugShowCheckedModeBanner: false,
    );
  }
}
''');
  print('app.dart file created successfully.');

  print('app_router.dart file created successfully.');
  // add dependency_injector.dart file
  _createFile(libDir.path, "dependency_injector.dart", '''
    // if you want to use this code, please first add 
    // get_it package to your project by running
    // flutter pub add get_it
    import 'package:get_it/get_it.dart';

    final sl = GetIt.instance;

    Future<void> initializeDependencies() async {
      // register your dependencies here...
    }
''');

  final featureDir = Directory('${libDir.path}/features');

  featureDir.createSync(recursive: true);
  print('Clean architecture folder structure created');
  print('  - lib/features');

  // create config folder
  final configDir = Directory('${libDir.path}/config');
  configDir.createSync(recursive: true);
  // create sub-folders for config
  Directory('${configDir.path}/route').createSync(recursive: true);
  Directory('${configDir.path}/theme').createSync(recursive: true);
  // create core folder
  final coreDir = Directory('${libDir.path}/core');
  coreDir.createSync(recursive: true);
  // create sub-folders for core
  Directory('${coreDir.path}/assets').createSync(recursive: true);
  Directory('${coreDir.path}/colors').createSync(recursive: true);
  Directory('${coreDir.path}/database').createSync(recursive: true);
  Directory('${coreDir.path}/network').createSync(recursive: true);
  Directory('${coreDir.path}/resources').createSync(recursive: true);
  Directory('${coreDir.path}/utils').createSync(recursive: true);
  Directory('${coreDir.path}/widgets').createSync(recursive: true);

  // Generate theme file
  _createFile("${configDir.path}/theme", 'theme.dart', '''

''');
// Generate router file
  _createFile("${configDir.path}/route", 'app_router.dart', '''

''');

// Generate colors
  _createFile("${coreDir.path}/colors", 'app_colors.dart', '''
import 'package:flutter/material.dart';
class AppColors {
    // add your custom colors here     
     }
''');

// Generate local db service
  _createFile("${coreDir.path}/database", 'local_db_service.dart', '''
  class LocalDBService {
 // your local database code goes here...
  
  }
''');

// Generate bloc observer file

  _createFile("${coreDir.path}/utils", 'bloc_observer.dart', '''
    
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAppBlocObserver extends BlocObserver {
  @override
  void onTransition(Bloc bloc, Transition transition) {
    log('onTransition: \$transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    log('OnEvent: \$event');
    super.onEvent(bloc, event);
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    debugPrint('onCreate: \${bloc.runtimeType}');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    debugPrint('onError: \${bloc.runtimeType}, \$error');
  }
}
''');

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

void _createFile(String dirPath, String fileName, String content) {
  final file = File('$dirPath/$fileName');
  file.writeAsString(content);
  print('File created: $dirPath/$fileName');
}

String _capitalize(String input) {
  if (input.isEmpty) return input;
  return input[0].toUpperCase() + input.substring(1);
}
