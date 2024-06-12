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
        return macos;
      case TargetPlatform.windows:
        return windows;
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
    apiKey: 'AIzaSyBXj2RLnXhyPK8eodY8XCbufHhyiu297sI',
    appId: '1:998115389624:web:27f98d6c62bb235400844d',
    messagingSenderId: '998115389624',
    projectId: 'virtualsathi-463f0',
    authDomain: 'virtualsathi-463f0.firebaseapp.com',
    storageBucket: 'virtualsathi-463f0.appspot.com',
    measurementId: 'G-S5ZK91JXK7',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBQvXa1Xt2SOSUsbNM_8mAriAj6PCfOCK4',
    appId: '1:998115389624:android:b84dbef3dbca02c500844d',
    messagingSenderId: '998115389624',
    projectId: 'virtualsathi-463f0',
    storageBucket: 'virtualsathi-463f0.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA1rc8NqOFmaGh6971KsxrJwb7cprs30eg',
    appId: '1:998115389624:ios:6997a5396aec1bb100844d',
    messagingSenderId: '998115389624',
    projectId: 'virtualsathi-463f0',
    storageBucket: 'virtualsathi-463f0.appspot.com',
    iosBundleId: 'com.example.virtualSathi',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA1rc8NqOFmaGh6971KsxrJwb7cprs30eg',
    appId: '1:998115389624:ios:6997a5396aec1bb100844d',
    messagingSenderId: '998115389624',
    projectId: 'virtualsathi-463f0',
    storageBucket: 'virtualsathi-463f0.appspot.com',
    iosBundleId: 'com.example.virtualSathi',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBXj2RLnXhyPK8eodY8XCbufHhyiu297sI',
    appId: '1:998115389624:web:261a73dd4d2d9d0d00844d',
    messagingSenderId: '998115389624',
    projectId: 'virtualsathi-463f0',
    authDomain: 'virtualsathi-463f0.firebaseapp.com',
    storageBucket: 'virtualsathi-463f0.appspot.com',
    measurementId: 'G-7ZCCLVB2VG',
  );
}
