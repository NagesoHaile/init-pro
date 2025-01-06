# init_pro

`init_pro` is a command-line tool designed to simplify and speed up repetitive tasks in Flutter projects. With support for clean architecture and component generation, `init_pro` aims to enhance your development workflow.

---

## Features

- Set up clean architecture folder structure (Data, Domain, and Presentation layers).
- Generate Flutter components such as buttons, text fields, dialogs, and more.
- Add commonly used utilities like validators, formatters, and others.
- Manage dependencies and ensure smooth project setup.
- **+25 prebuilt Flutter components** for faster development.

---

## Installation

To use `init_pro`, add it to your Flutter project's dev dependencies:

```bash
flutter pub add dev:init_pro
```
### Global activation
 Run this command to activate the CLI tool:

 ```bash
dart pub run global activate init_pro
 ```

## Or manually add it to your `pubspec.yaml:`

```bash 
dev_dependencies:
  init_pro: ^0.1.0
```
 ## Then run this command
 ```bash 
flutter pub get
```


## Usage

Run init_pro commands in your Flutter project directory:

## Commands
 #### Initialize Clean Architecture
Sets up a clean architecture folder structure with data, domain, and presentation layers.

 ```bash
dart pub run init_pro init
```

#### Generate Feature
Generates a new feature with the three-layer architecture and required files.

```bash
dart pub run init_pro create-feature <feature-name>
```

#### Add Component
Generates a common Flutter component such as buttons, dialogs etc.

```bash
dart pub run init_pro add-component <component-name>
```

#### Show Help
Displays help and usage information.

```bash
dart pub run init_pro --help
```


## Example Workflow

### 1. Initialize Project
Start by setting up the clean architecture for your Flutter project
  ```bash
dart pub run init_pro init
  ```
### 2. Add a New Feature
Generate a new feature folder with three-layer architecture:

```bash
dart pub run init_pro create-feature authentication
```
### 3. Generate a Reusable Component
Add a prebuilt and customizable Flutter component like a button or text field:

```bash
dart pub run init_pro add-component elevated-button
 ```

   

## Contributing
We welcome contributions to `init_pro`! Please fork the repository and create a pull request for any new features or fixes.
 
1. Fork the project.
2. Create your feature branch (git checkout -b feature/new-feature).
3. Commit your changes (git commit -m 'Add new feature').
4. Push to the branch (git push origin feature/new-feature).
5. Open a pull request.


## License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.


## Links
 - [Homepage](https://github.com/NagesoHaile/init-pro)
 - [Repository](https://github.com/NagesoHaile/init-pro)
 - [Issue Tracker](https://github.com/NagesoHaile/init-pro/issues)







