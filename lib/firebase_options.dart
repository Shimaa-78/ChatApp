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
    apiKey: 'AIzaSyCbPeb2aepft_ZLzB8Hp3-dtPOUkitv_wM',
    appId: '1:42840447805:web:6b0941cfae2ee2be4cc354',
    messagingSenderId: '42840447805',
    projectId: 'group-chat-ebcb1',
    authDomain: 'group-chat-ebcb1.firebaseapp.com',
    storageBucket: 'group-chat-ebcb1.appspot.com',
    measurementId: 'G-W3CMZRHW16',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDigeGjH8AMt1IIjofpa2VjoIRk8vt0m44',
    appId: '1:42840447805:android:0e20953f44d340cb4cc354',
    messagingSenderId: '42840447805',
    projectId: 'group-chat-ebcb1',
    storageBucket: 'group-chat-ebcb1.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCBqf5pDaZNXmBeBZUmdCCPYtL6vgjdqiw',
    appId: '1:42840447805:ios:e9f64cf8430523624cc354',
    messagingSenderId: '42840447805',
    projectId: 'group-chat-ebcb1',
    storageBucket: 'group-chat-ebcb1.appspot.com',
    androidClientId: '42840447805-noqptbtn8ib4crpqcbbjnkoacrssq12r.apps.googleusercontent.com',
    iosClientId: '42840447805-1msdoq8otjhbft5c665g827lvjv3upa3.apps.googleusercontent.com',
    iosBundleId: 'com.example.untitled',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCBqf5pDaZNXmBeBZUmdCCPYtL6vgjdqiw',
    appId: '1:42840447805:ios:e9f64cf8430523624cc354',
    messagingSenderId: '42840447805',
    projectId: 'group-chat-ebcb1',
    storageBucket: 'group-chat-ebcb1.appspot.com',
    androidClientId: '42840447805-noqptbtn8ib4crpqcbbjnkoacrssq12r.apps.googleusercontent.com',
    iosClientId: '42840447805-1msdoq8otjhbft5c665g827lvjv3upa3.apps.googleusercontent.com',
    iosBundleId: 'com.example.untitled',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCbPeb2aepft_ZLzB8Hp3-dtPOUkitv_wM',
    appId: '1:42840447805:web:c3ec9b07803a45ba4cc354',
    messagingSenderId: '42840447805',
    projectId: 'group-chat-ebcb1',
    authDomain: 'group-chat-ebcb1.firebaseapp.com',
    storageBucket: 'group-chat-ebcb1.appspot.com',
    measurementId: 'G-LLQPWBHK1V',
  );
}
