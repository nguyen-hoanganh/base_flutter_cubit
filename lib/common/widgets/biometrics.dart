import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/types/auth_messages_ios.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class BiometricsAuth {
  static final LocalAuthentication _auth = LocalAuthentication();

  static Future<bool> _canAuthenticate() async =>
      await _auth.canCheckBiometrics;

  static Future<List<BiometricType>> getAvailableBiometrics() async {
    final auth = LocalAuthentication();
    final availableBiometrics = await auth.getAvailableBiometrics();
    bool isSupportFingerprint = false;
    bool isSupportFace = false;

    if (Platform.isAndroid) {
      isSupportFingerprint = availableBiometrics.contains(BiometricType.strong);
      isSupportFace = isSupportFingerprint;
    } else {
      isSupportFingerprint =
          availableBiometrics.contains(BiometricType.fingerprint);
      isSupportFace = availableBiometrics.contains(BiometricType.face);
    }

    List<BiometricType> result = [];

    if (isSupportFingerprint) result.add(BiometricType.fingerprint);
    if (isSupportFace) result.add(BiometricType.face);

    return result;
  }

  static Future<void> cancelAuthentication() async =>
      await _auth.stopAuthentication();

  static Future<BiometricStatus> authenticate() async {
    try {
      if (!await _canAuthenticate()) {
        return BiometricStatus.notAvailable;
      }

      bool isAuthenticated = await _auth.authenticate(
        authMessages: const <AuthMessages>[
          AndroidAuthMessages(),
          IOSAuthMessages(),
        ],
        localizedReason: 'To continue, you must complete the biometrics',
        options: const AuthenticationOptions(
          useErrorDialogs: false,
          stickyAuth: true,
          biometricOnly: true,
        ),
      );

      if (isAuthenticated) {
        return BiometricStatus.success;
      } else {
        return BiometricStatus.fail;
      }
    } on PlatformException catch (e) {
      if (e.code == auth_error.notEnrolled) {
        return BiometricStatus.notEnrolled;
      } else if (e.code == auth_error.notAvailable) {
        return BiometricStatus.notAvailable;
      } else {
        return BiometricStatus.fail;
      }
    }
  }
}

enum BiometricStatus {
  notAvailable,
  notEnrolled,
  lockedOut,
  permanentlyLockedOut,
  success,
  fail
}
