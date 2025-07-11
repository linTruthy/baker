// pubspec.yaml dependencies
/*
dependencies:
  flutter:
    sdk: flutter
  firebase_core: ^2.24.2
  firebase_auth: ^4.15.3
  cloud_firestore: ^4.13.6
  firebase_storage: ^11.5.6
  riverpod: ^2.4.9
  flutter_riverpod: ^2.4.9
  go_router: ^12.1.3
  flutter_form_builder: ^9.1.1
  form_builder_validators: ^9.1.0
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  syncfusion_flutter_pdf: ^23.2.7
  signature: ^5.4.0
  image_picker: ^1.0.4
  flutter_animate: ^4.3.0
  intl: ^0.18.1
  uuid: ^4.2.1
*/

// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'core/app.dart';
import 'core/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize Hive for offline caching
  await Hive.initFlutter();

  runApp(const ProviderScope(child: ChelloBakeryApp()));
}
