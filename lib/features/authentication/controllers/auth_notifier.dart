import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthNotifier extends AsyncNotifier<bool> {
  bool isError = false;

  @override
  bool build() => false;

  void authenticate() async {
    state = const AsyncLoading();
    try {
      await Future.delayed(const Duration(seconds: 2));
      isError = !isError;
      if (isError) throw ArgumentError('user is not verified');
      state = const AsyncData(true);
    } catch (e, s) {
      state = AsyncError(e, s);
    }
  }
}

final authNotifier = AsyncNotifierProvider<AuthNotifier, bool>(AuthNotifier.new);
