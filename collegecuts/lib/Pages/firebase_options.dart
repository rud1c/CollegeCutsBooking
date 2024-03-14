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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for android - '
              'try to add using FlutLab Firebase Configuration',
        );
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for iOS - '
              'try to add using FlutLab Firebase Configuration',
        );
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
              'it not supported by FlutLab yet, but you can add it manually',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
              'it not supported by FlutLab yet, but you can add it manually',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
              'it not supported by FlutLab yet, but you can add it manually',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
      apiKey: "AIzaSyCgGyVIlFkTJMQVii5dDpZEPJXze6jI_Zk",
      authDomain: "collegecuts-5e97e.firebaseapp.com",
      projectId: "collegecuts-5e97e",
      storageBucket: "collegecuts-5e97e.appspot.com",
      messagingSenderId: "703552224264",
      appId: "1:703552224264:web:7e164b4e99f54463e525bd",
      measurementId: "G-9D55H4SQSS"
  );

  static const FirebaseOptions ios = FirebaseOptions(apiKey: 'AIzaSyDcXgpVmQHiEqA1pBvO2-lFpceCo61eJEg',
      appId: '1:703552224264:ios:42b6e01e19f26c67e525bd',
      messagingSenderId: '703552224264',
      projectId: 'collegecuts-5e97e',
      iosBundleId: 'com.example.collegecutsa2',
      storageBucket: 'collegecuts-5e97e.appspot.com'
  );
}