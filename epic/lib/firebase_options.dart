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
    apiKey: 'AIzaSyB8nySDeengSdwjVjtbMsKB2xwXVJ2q16s',
    appId: '1:282675936913:web:8335ec9745ab018f614930',
    messagingSenderId: '282675936913',
    projectId: 'epic-a00da',
    authDomain: 'epic-a00da.firebaseapp.com',
    storageBucket: 'epic-a00da.appspot.com',
    measurementId: 'G-083JPC9JGB',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBdR-ERBsChbOMThB33MzWyRSniRi8XKj0',
    appId: '1:282675936913:android:827d36401e8a71af614930',
    messagingSenderId: '282675936913',
    projectId: 'epic-a00da',
    storageBucket: 'epic-a00da.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyC_zpjhM2WF8DegHgelUrhol7Ri5g4VqaY',
    appId: '1:282675936913:ios:b0c80ab36b84ac6f614930',
    messagingSenderId: '282675936913',
    projectId: 'epic-a00da',
    storageBucket: 'epic-a00da.appspot.com',
    androidClientId: '282675936913-6krs5e8hve5essggacedqmib5pq9d9j0.apps.googleusercontent.com',
    iosClientId: '282675936913-uj6psg294odi02qar707jd2krekn7lgc.apps.googleusercontent.com',
    iosBundleId: 'com.epic.epic',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyC_zpjhM2WF8DegHgelUrhol7Ri5g4VqaY',
    appId: '1:282675936913:ios:3b6b27505bdcb39f614930',
    messagingSenderId: '282675936913',
    projectId: 'epic-a00da',
    storageBucket: 'epic-a00da.appspot.com',
    iosBundleId: 'com.example.epic',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB8nySDeengSdwjVjtbMsKB2xwXVJ2q16s',
    appId: '1:282675936913:web:771ba5e5665e914e614930',
    messagingSenderId: '282675936913',
    projectId: 'epic-a00da',
    authDomain: 'epic-a00da.firebaseapp.com',
    storageBucket: 'epic-a00da.appspot.com',
    measurementId: 'G-G48R5VE1ZS',
  );
}