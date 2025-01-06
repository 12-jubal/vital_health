# vital_health

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

### Prerequisites

- Flutter SDK: Ensure you have Flutter installed. You can download it from [Flutter's official website](https://flutter.dev/docs/get-started/install).
- Dart SDK: The Dart SDK is bundled with Flutter; no separate installation is required.
- IDE: You can use any IDE, but Android Studio and Visual Studio Code are recommended for Flutter development.

### Flutter Version

This project uses Flutter 3.27.1. Ensure you have the correct version installed by running:

```sh
flutter --version
```

If you need to switch versions, you can use [Flutter Version Manager (FVM)](https://fvm.app/).

### Setting Up the Project

1. **Clone the repository:**

    ```sh
    git clone https://github.com/12-jubal/vital_health.git
    or
    git clone git@github.com:12-jubal/vital_health.git
    cd vital_health
    ```

2. **Install dependencies:**

    ```sh
    flutter pub get
    ```

3. **Run the application:**

    ```sh
    flutter run
    ```

### API JSON Files

This project uses API JSON files located in the `assets` folder. Ensure that the `pubspec.yaml` file includes the following configuration to load these assets:

```yaml
flutter:
  assets:
     - assets/api/
```

