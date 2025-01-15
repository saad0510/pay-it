import 'dart:async';

import 'package:emv_card_reader/emv_card_reader.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../entities/card_data.dart';

class CardScanNotifier extends AutoDisposeAsyncNotifier<CardData?> {
  final _reader = EmvCardReader();
  StreamSubscription? _subscription;

  @override
  CardData? build() {
    startScanning();
    ref.onDispose(stopScanning);
    return null;
  }

  void startScanning() async {
    try {
      await _reader.start();
      await checkAvailability();
      _subscription = _reader.stream().listen(
        onEmvCard,
        onError: (error, stackTrace) {
          state = AsyncError(error, stackTrace);
        },
      );
    } on String catch (e, s) {
      state = AsyncError(e, s);
    } on PlatformException catch (e, s) {
      state = AsyncError(e.message ?? e.code, s);
    } catch (e, s) {
      state = AsyncError(e, s);
    }
  }

  void onEmvCard(EmvCard? data) {
    if (data == null) return;
    var card = CardData(
      holderName: data.holder ?? '',
      cardNumber: data.number ?? '**** **** **** ****',
      applicationName: data.type ?? '',
      expirtyDate: data.expire ?? '',
      isEmpty: data.isEmpty ?? false,
    );
    if (card.isEmpty) {
      card = state.valueOrNull?.copyWith(isEmpty: true) ?? card;
    }
    state = AsyncData(card);
  }

  Future<void> checkAvailability() async {
    final status = await _reader.getNfcStatus();
    switch (status) {
      case 'not_supported':
        throw 'NFC is not supported on this device';
      case 'disabled':
        throw 'NFC is currently disabled from device settings';
    }
  }

  void stopScanning() async {
    _subscription?.cancel();
    _subscription = null;
    await _reader.stop();
  }
}

final cardScanNotifier = AutoDisposeAsyncNotifierProvider<CardScanNotifier, CardData?>(CardScanNotifier.new);
