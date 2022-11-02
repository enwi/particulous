# particulous
Not another part inventory management system ... this is particulous!

## Developing

### Development Environment

An installation of Flutter is neded.
Follow [these steps](https://docs.flutter.dev/get-started/install) to install it.
Also if you are using the `Dart` extension for VSCode (below) don't forget to set the variable `dart.flutterSdkPath` of VSCode to the installation folder of `Flutter`.

The easiest way is to use Visual Studio Code plus some Extensions for it:
- [Dart](https://marketplace.visualstudio.com/items?itemName=Dart-Code.dart-code)
- [Flutter](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter)
- [Git Graph](https://marketplace.visualstudio.com/items?itemName=mhutchie.git-graph)

### Building code

To build database classes run `flutter pub run build_runner build`

To build the project for windows run `flutter build windows`