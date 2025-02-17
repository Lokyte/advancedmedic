import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

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
        return linux;
      default:
        throw UnsupportedError(
            'DefaultFirebaseOptions are not supported for this platform.');
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
      apiKey: "AIzaSyB9vqELB5ZtmzSvq8hKfV3kvV2UzCf1A1A",
      authDomain: "healthportal-1e608.firebaseapp.com",
      projectId: "healthportal-1e608",
      storageBucket: "healthportal-1e608.firebasestorage.app",
      messagingSenderId: "1086610778343",
      appId: "1:1086610778343:web:1a455498418779da2bda42",
      measurementId: "G-C40R476HC0");

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: "AIzaSyB9vqELB5ZtmzSvq8hKfV3kvV2UzCf1A1A",
    authDomain: 'your-android-auth-domain',
    projectId: 'your-android-project-id',
    storageBucket: 'your-android-storage-bucket',
    messagingSenderId: 'your-android-messaging-sender-id',
    appId: 'your-android-app-id',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: "AIzaSyB9vqELB5ZtmzSvq8hKfV3kvV2UzCf1A1A",
    authDomain: 'your-ios-auth-domain',
    projectId: 'your-ios-project-id',
    storageBucket: 'your-ios-storage-bucket',
    messagingSenderId: 'your-ios-messaging-sender-id',
    appId: 'your-ios-app-id',
    iosBundleId: 'your-ios-bundle-id',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: "AIzaSyB9vqELB5ZtmzSvq8hKfV3kvV2UzCf1A1A",
    authDomain: 'your-macos-auth-domain',
    projectId: 'your-macos-project-id',
    storageBucket: 'your-macos-storage-bucket',
    messagingSenderId: 'your-macos-messaging-sender-id',
    appId: 'your-macos-app-id',
    iosBundleId: 'your-macos-bundle-id',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: "AIzaSyB9vqELB5ZtmzSvq8hKfV3kvV2UzCf1A1A",
    authDomain: 'your-windows-auth-domain',
    projectId: 'your-windows-project-id',
    storageBucket: 'your-windows-storage-bucket',
    messagingSenderId: 'your-windows-messaging-sender-id',
    appId: 'your-windows-app-id',
  );

  static const FirebaseOptions linux = FirebaseOptions(
    apiKey: "AIzaSyB9vqELB5ZtmzSvq8hKfV3kvV2UzCf1A1A",
    authDomain: 'your-linux-auth-domain',
    projectId: 'your-linux-project-id',
    storageBucket: 'your-linux-storage-bucket',
    messagingSenderId: 'your-linux-messaging-sender-id',
    appId: 'your-linux-app-id',
  );
}
