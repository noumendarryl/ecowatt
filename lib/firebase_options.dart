// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDVKtm3UxCiPblX3uOi7e5UXNdOkzcLnFM',
    appId: '1:860556511471:android:cf2796ed451e5d7290f31a',
    messagingSenderId: '860556511471',
    projectId: 'ecowatt-7f29b',
    storageBucket: 'ecowatt-7f29b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDFXRduldt0Vzuyt8H84hd61u-Y434MupM',
    appId: '1:860556511471:ios:e015be3af21150a990f31a',
    messagingSenderId: '860556511471',
    projectId: 'ecowatt-7f29b',
    storageBucket: 'ecowatt-7f29b.appspot.com',
    iosBundleId: 'com.ecowatt.app',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyBAmzLIYrPHNZB0Oah3PmloZAlQFb-AaD8',
    appId: '1:860556511471:web:f9d8357f3208d78e90f31a',
    messagingSenderId: '860556511471',
    projectId: 'ecowatt-7f29b',
    authDomain: 'ecowatt-7f29b.firebaseapp.com',
    storageBucket: 'ecowatt-7f29b.appspot.com',
  );

}