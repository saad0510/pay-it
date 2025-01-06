import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app_constants.dart';
import 'core/utils/image_precacher.dart';
import 'firebase_options.dart';
import 'screen_provider.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: AppConstants.appTitle,
        theme: AppTheme().theme,
        home: Consumer(
          builder: (_, ref, __) {
            final screen = ref.watch(currentScreenProvider).valueOrNull;
            return screen ?? const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => mounted ? ImagePrecacher(context).call() : null,
    );
  }
}
