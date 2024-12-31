import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth/local_auth.dart';

class AuthNotifier extends AsyncNotifier<bool> {
  Timer? _timer;

  @override
  bool build() {
    listenSelf(onChange);
    ref.onDispose(() => _timer?.cancel());
    return false;
  }

  void authenticate() async {
    state = const AsyncLoading();
    await Future.delayed(const Duration(milliseconds: 500));

    try {
      final success = await LocalAuthentication().authenticate(
        localizedReason: 'Authenticate to continue using PayIt',
      );
      state = AsyncData(success);
    } on String catch (e, s) {
      state = AsyncError(e, s);
    } on PlatformException catch (e, s) {
      state = AsyncError(_expandErrorMessage(e), s);
    } catch (e, s) {
      state = AsyncError(e, s);
    }
  }

  String _expandErrorMessage(PlatformException e) {
    if (e.message != null) return e.message!;

    return switch (e.code) {
      auth_error.passcodeNotSet => 'No passcode or PIN has been configured',
      auth_error.notEnrolled => 'No biometrics are enrolled',
      auth_error.notAvailable => 'No hardware support for biometrics.',
      auth_error.otherOperatingSystem => 'The device operating system is not supported.',
      auth_error.lockedOut => 'The API is temporarily locked out due to too many attempts.',
      auth_error.permanentlyLockedOut => 'The API is permanently locked out due to too many attempts.',
      auth_error.biometricOnlyNotSupported => 'The biometricOnly parameter can\'t be true on Windows',
      _ => e.toString(),
    };
  }

  void onChange(AsyncValue<bool>? previous, AsyncValue<bool> next) {
    final prevAuth = previous?.value ?? false;
    final nextAuth = next.value ?? false;
    if (prevAuth == nextAuth) return;
    if (nextAuth) startExpiring();
  }

  void startExpiring() {
    _timer?.cancel();
    _timer = Timer(
      const Duration(seconds: 3),
      () {
        state = AsyncError('Expired', StackTrace.current);
      },
    );
  }
}

final authNotifier = AsyncNotifierProvider<AuthNotifier, bool>(AuthNotifier.new);
