import 'package:amadeus_app/my_app.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(
    DevicePreview(enabled: kDebugMode, builder: (context) => const MyApp()),
  );
}
