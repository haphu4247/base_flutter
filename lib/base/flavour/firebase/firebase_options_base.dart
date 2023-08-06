import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

abstract class BaseFirebaseOptions {
  FirebaseOptions get currentPlatform;
  FirebaseOptions get android;
  FirebaseOptions get ios;
  String get appId;

  String? get clientId {
    if (defaultTargetPlatform == TargetPlatform.android) {
      return android.androidClientId;
    } else if (defaultTargetPlatform == TargetPlatform.iOS) {
      return ios.iosClientId;
    } else {
      return null;
    }
  }
}
