
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sarthi_flutter_project/firebase_options.dart';
import 'package:sarthi_flutter_project/utils/colors.dart';
import 'screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('✅ Firebase OK');
  } catch (e) {
    print('❌ Firebase FAILED: $e');
  }
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  runApp(const SarthiApp());
}

class SarthiApp extends StatelessWidget {
  const SarthiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sarthi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Nunito',
        scaffoldBackgroundColor: SC.bgLight,
        colorScheme: ColorScheme.fromSeed(seedColor: SC.purple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
