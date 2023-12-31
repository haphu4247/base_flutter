// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

import 'firebase_options_base.dart';

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
final BaseFirebaseOptions _instance = DefaultFirebaseOptionsDev();

class DefaultFirebaseOptionsDev extends BaseFirebaseOptions {
  static BaseFirebaseOptions get instance => _instance;

  @override
  FirebaseOptions get currentPlatform {
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyA-GFxzPj_fJ4bjGRM9DyECdoHk97Jm50c',
    appId: '1:519225302530:web:d0ac719eab2f7a1f27911b',
    messagingSenderId: '519225302530',
    projectId: 'lottecinema-25463',
    authDomain: 'lottecinema-25463.firebaseapp.com',
    databaseURL: 'https://lottecinema-25463.firebaseio.com',
    storageBucket: 'lottecinema-25463.appspot.com',
    measurementId: 'G-G0YBJRV8XZ',
  );

  @override
  FirebaseOptions android = const FirebaseOptions(
    apiKey: 'AIzaSyBK5z1TJ_fa-AqyqzHU6xL4_RABDT954wA',
    appId: '1:519225302530:android:4af68326622285f627911b',
    messagingSenderId: '519225302530',
    projectId: 'lottecinema-25463',
    storageBucket: 'lottecinema-25463.appspot.com',
    androidClientId:
        '519225302530-c8ltj8esg47j6c3bjkca69rgjvjgkor6.apps.googleusercontent.com',
  );

  @override
  FirebaseOptions ios = const FirebaseOptions(
    apiKey: 'AIzaSyBVJxgnXXqJ_tRvbPTA_AHUHBB93xGwr7E',
    appId: '1:519225302530:ios:f2f2a3afcb6d91f527911b',
    messagingSenderId: '519225302530',
    projectId: 'lottecinema-25463',
    databaseURL: 'https://lottecinema-25463.firebaseio.com',
    storageBucket: 'lottecinema-25463.appspot.com',
    androidClientId:
        '519225302530-8q84tt3uoatailci54gsok0gue8canfv.apps.googleusercontent.com',
    iosClientId:
        '519225302530-e0ob6hg6il4ccqvlqineepfqvk7c2mri.apps.googleusercontent.com',
    iosBundleId: 'vn.com.lottecinema.dev',
  );

  @override
  String get appId => 'vn.com.lottecinema.dev';
}
