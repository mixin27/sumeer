import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:sumeer/app_bootstrap_init.dart';

import 'app_bootstrap.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase initialization
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // create an app bootstrap instance
  final appBootstrap = AppBootstrap();

  await appBootstrap.setupRefereshRate();

  // * uncomment this to connect to the Firebase emulators
  // await appBootstrap.setupEmulators();

  // flutter_logs
  await appBootstrap.setupFlutterLogs();

  // hive
  await appBootstrap.setupHiveFlutter();

  // create a container configured with all the required instances
  final container = await appBootstrap.createMainProviderContainer();

  // use the container above to create the root widget
  final root = appBootstrap.createRootWidget(container: container);

  // start the app
  runApp(root);
}
