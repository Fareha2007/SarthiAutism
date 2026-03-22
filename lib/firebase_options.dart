
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;


class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCHNex1S6jot6Hvc-xKHtFEONLRy6OGLP8',
    appId: '1:536684055879:web:954b67d1d65d9dceda5062',
    messagingSenderId: '536684055879',
    projectId: 'sarthiautism-83f28',
    authDomain: 'sarthiautism-83f28.firebaseapp.com',
    databaseURL: 'https://sarthiautism-83f28-default-rtdb.firebaseio.com',
    storageBucket: 'sarthiautism-83f28.firebasestorage.app',
    measurementId: 'G-B37L8B7P4M',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCvKOKK6fUvbUjlbpEEEY7J_GwfY2EuG50',
    appId: '1:536684055879:android:5854d1c373bfa343da5062',
    messagingSenderId: '536684055879',
    projectId: 'sarthiautism-83f28',
    databaseURL: 'https://sarthiautism-83f28-default-rtdb.firebaseio.com',
    storageBucket: 'sarthiautism-83f28.firebasestorage.app',
  );
}
