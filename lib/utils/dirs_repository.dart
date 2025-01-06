import 'dart:io';

class DirsRepository {
  static Directory coreDir() {
    final currentDir = Directory.current;
    final pubspecFile = File('${currentDir.path}/pubspec.yaml');
    // check if pubspec.yaml exists
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
    final coreDir = Directory('${libDir.path}/core');
    return coreDir;
  }
}
