import 'dart:io';
import 'package:args/command_runner.dart';

import '../commands/add_dependencies.dart';
import '../utils/file_creator.dart';

class InitCommand extends Command {
  @override
  String get description =>
      'Initialize the Flutter project with default configurations';

  @override
  String get name => 'init';

  @override
  String get usage => '''
    Initialize the project with:
  - Clean architecture setup
  - Core and helper configurations
  - Predefined dependencies setup (flutter_bloc, get_it, etc.)
  ''';

  @override
  Future<void> run() async {
    print('Initializing project...');
    initProject();
  }
}

void initProject() async {
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
  await addDependencies(currentDir.path);
  final result = await Process.run('flutter', ['pub', 'get'],
      workingDirectory: currentDir.path);
  if (result.exitCode == 0) {
    print('Dependencies installed successfully!');
  } else {
    print('Error while running flutter pub get: ${result.stderr}');
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
import 'package:brave/config/theme/theme.dart';
import 'config/route/app_router.dart';


class App extends StatelessWidget  {
  const App({super.key});

  @override
  Widget build(BuildContext context){
    return MaterialApp.router(
      darkTheme: darkTheme,
      theme: lightTheme,
      routerConfig:router,
      debugShowCheckedModeBanner: false,
    );
  }
}
''');
  print('app.dart file created successfully.');

  print('app_router.dart file created successfully.');
  // add dependency_injector.dart file
  createFile(libDir.path, "dependency_injector.dart", '''
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
  createFile("${configDir.path}/theme", 'theme.dart', '''
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/colors/app_colors.dart';


final AppBarTheme appBarTheme = AppBarTheme(
  systemOverlayStyle: SystemUiOverlayStyle.light,
  backgroundColor: AppColors.primaryColor,
  surfaceTintColor: AppColors.primaryColor,
  elevation: 0,
  centerTitle: false,
  iconTheme: const IconThemeData(color: AppColors.primaryLight),
  titleTextStyle: GoogleFonts.roboto(
    fontSize: 20,
    fontWeight: FontWeight.w600,
  ),
);

TextButtonThemeData textButtonTheme = TextButtonThemeData(
    style: ButtonStyle(
  elevation: WidgetStateProperty.all<double>(0),
  foregroundColor: WidgetStateProperty.resolveWith<Color>(
    (Set<WidgetState> state) => state.contains(WidgetState.disabled)
        ? AppColors.blackColor
        : AppColors.blackColor,
  ),
  backgroundColor: WidgetStateProperty.resolveWith<Color>(
    (Set<WidgetState> state) =>
        state.contains(WidgetState.disabled) ? Colors.white54 : Colors.white,
  ),
  textStyle: WidgetStateProperty.all<TextStyle>(
    GoogleFonts.inter(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.6,
    ),
  ),
  shape: WidgetStateProperty.all<RoundedRectangleBorder>(
    RoundedRectangleBorder(
      side: const BorderSide(
        color: Colors.grey,
        width: 0.3,
      ),
      borderRadius: BorderRadius.circular(4.0),
    ),
  ),
));


ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: lightColorScheme,
  appBarTheme: appBarTheme,
  textButtonTheme: textButtonTheme,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: WidgetStateProperty.all<double>(0),
      minimumSize:
          WidgetStateProperty.all<Size>(const Size(double.infinity, 48)),
      backgroundColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> state) => state.contains(WidgetState.disabled)
            ? AppColors.lightGrey
            : AppColors.primaryColor,
      ),
      foregroundColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> state) => state.contains(WidgetState.disabled)
            ? AppColors.darkGrey
            : Colors.white,
      ),
      textStyle: WidgetStateProperty.all<TextStyle>(
        GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.6,
        ),
      ),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    ),
  ),
  textTheme: textTheme.apply(bodyColor: AppColors.primaryColor),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: GoogleFonts.roboto(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      color: AppColors.blackColor,
    ),
    floatingLabelStyle: GoogleFonts.roboto(
      fontWeight: FontWeight.w400,
      color: AppColors.blackColor,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: Colors.grey.shade500, width: 0.1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: Colors.grey.shade500, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
    ),
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: Colors.white,
    backgroundColor: AppColors.primaryColor,
    extendedTextStyle: GoogleFonts.inter(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.6,
    ),
  ),
);


ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: darkColorScheme,
  // scaffoldBackgroundColor: AppColors.blackColor,
  appBarTheme: appBarTheme,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: WidgetStateProperty.all<double>(0),
      backgroundColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> state) => state.contains(WidgetState.disabled)
            ? Colors.grey
            : AppColors.primaryColor,
      ),
      foregroundColor: WidgetStateProperty.resolveWith<Color>(
        (Set<WidgetState> state) => state.contains(WidgetState.disabled)
            ? Colors.white60
            : Colors.white,
      ),
      textStyle: WidgetStateProperty.all<TextStyle>(
        GoogleFonts.inter(
          fontSize: 15,
          fontWeight: FontWeight.w500,
        ),
      ),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
    ),
  ),
  textTheme: textTheme.apply(bodyColor: Colors.white),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: GoogleFonts.roboto(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      color: Colors.white60,
    ),
    floatingLabelStyle: GoogleFonts.roboto(
      fontWeight: FontWeight.w400,
      color: Colors.white60,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: Colors.grey.shade500, width: 0.1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: BorderSide(color: Colors.grey.shade500, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(5),
      borderSide: const BorderSide(color: Colors.white60, width: 2),
    ),
  ),
  scaffoldBackgroundColor: AppColors.primaryColor,
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    foregroundColor: Colors.white,
    backgroundColor: AppColors.primaryColor,
    extendedTextStyle: GoogleFonts.inter(
      fontSize: 15,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.6,
    ),
  ),
);

// Color Schemes

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF6750A4),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFFEADDFF),
  onPrimaryContainer: Color(0xFF21005D),
  secondary: Color(0xFF625B71),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFE8DEF8),
  onSecondaryContainer: Color(0xFF1D192B),
  tertiary: Color(0xFF7D5260),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFFFD8E4),
  onTertiaryContainer: Color(0xFF31111D),
  error: Color(0xFFB3261E),
  onError: Color(0xFFFFFFFF),
  errorContainer: Color(0xFFF9DEDC),
  onErrorContainer: Color(0xFF410E0B),
  outline: Color(0xFF79747E),
  surface: Color(0xFFFFFBFE),
  onSurface: Color(0xFF1C1B1F),
  surfaceContainerHighest: Color(0xFFE7E0EC),
  onSurfaceVariant: Color(0xFF49454F),
  inverseSurface: Color(0xFF313033),
  onInverseSurface: Color(0xFFF4EFF4),
  inversePrimary: Color(0xFFD0BCFF),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF6750A4),
  outlineVariant: Color(0xFFCAC4D0),
  scrim: Color(0xFF000000),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color(0xFFD0BCFF),
  onPrimary: Color(0xFF381E72),
  primaryContainer: Color(0xFF4F378B),
  onPrimaryContainer: Color(0xFFEADDFF),
  secondary: Color(0xFFCCC2DC),
  onSecondary: Color(0xFF332D41),
  secondaryContainer: Color(0xFF4A4458),
  onSecondaryContainer: Color(0xFFE8DEF8),
  tertiary: Color(0xFFEFB8C8),
  onTertiary: Color(0xFF492532),
  tertiaryContainer: Color(0xFF633B48),
  onTertiaryContainer: Color(0xFFFFD8E4),
  error: Color(0xFFF2B8B5),
  onError: Color(0xFF601410),
  errorContainer: Color(0xFF8C1D18),
  onErrorContainer: Color(0xFFF9DEDC),
  outline: Color(0xFF938F99),
  surface: Color(0xFF1C1B1F),
  onSurface: Color(0xFFE6E1E5),
  surfaceContainerHighest: Color(0xFF49454F),
  onSurfaceVariant: Color(0xFFCAC4D0),
  inverseSurface: Color(0xFFE6E1E5),
  onInverseSurface: Color(0xFF313033),
  inversePrimary: Color(0xFF6750A4),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFFD0BCFF),
  outlineVariant: Color(0xFF49454F),
  scrim: Color(0xFF000000),
);

final textTheme = TextTheme(
  titleLarge: GoogleFonts.roboto(
    fontWeight: FontWeight.w700,
    fontSize: 20,
  ),
  titleMedium: GoogleFonts.roboto(
    fontWeight: FontWeight.w600,
    fontSize: 18,
  ),
  titleSmall: GoogleFonts.roboto(
    fontWeight: FontWeight.w500,
    fontSize: 16,
  ),
  bodyMedium: GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 12,
  ),
  bodySmall: GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 10,
  ),
  labelMedium: GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: 0.8,
  ),
  headlineMedium: GoogleFonts.roboto(
    fontWeight: FontWeight.w600,
    fontSize: 16,
  ),
  headlineSmall: GoogleFonts.roboto(
    fontWeight: FontWeight.w500,
    fontSize: 14,
  ),
  labelLarge: GoogleFonts.roboto(
    fontWeight: FontWeight.w700,
    fontSize: 13,
  ),
);


''');
// Generate router file
  createFile("${configDir.path}/route", 'app_router.dart', '''
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
GlobalKey<NavigatorState> _shellNavigatorKey = GlobalKey<NavigatorState>();

GoRouter router = GoRouter(
debugLogDiagnostics: true,
navigatorKey: _rootNavigatorKey,
initialLocation: '/',
  routes: [
  
  ],
);
''');

// Generate colors
  createFile("${coreDir.path}/colors", 'app_colors.dart', '''
import 'package:flutter/material.dart';
class AppColors {
// replace these colors with your own colors 
// you can customize the [names] as you want 
static const Color primaryColor = Color(0xFF16423C);
static const Color secondaryColor = Color(0xFF6A9C89); 
static const Color tertiaryColor = Color(0xFFC4DAD2);
static const Color cardBackgroundColor = Color(0xFF031634);
static const Color primaryLight = Color(0xFFFBF8EF);
static const Color blackColor = Color(0xFF000f26);
static const Color appRedColor = Color(0xFFA04747);
static const Color whiteAppColor = Color(0xFFFFFFFF);
static const Color dark = Color(0xFF262626);
static const darkGrey = Color(0xFF686868);
static const lightGrey = Color(0xFFE0E0E0);
static const Color disabled = Color(0xFFC7C8CC);
static const Color splashBackgroundColor = Color(0XFFf1efe7);
}
''');

// Generate local db service
  createFile("${coreDir.path}/database", 'local_db_service.dart', '''
  class LocalDBService {
 // your local database code goes here...
  
  }
''');

// Generate bloc observer file

  createFile("${coreDir.path}/utils", 'bloc_observer.dart', '''
    
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
  static String? validateEmail(String email) {
    if (email.isEmpty) return 'Email is required.';
    final regex = RegExp(r'^\S+@\S+\.\S+\$');
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
