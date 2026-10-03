import 'package:amadeus_app/core/services/service_locator.dart';
import 'package:amadeus_app/my_app.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:rive/rive.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await initServiceLocator();

  await RiveNative.init();
  runApp(
    DevicePreview(enabled: kDebugMode, builder: (context) => const MyApp()),
  );
}
