import 'dart:async';

import 'package:flutter/services.dart';
import 'emv_card.dart';

export 'emv_card.dart';

class EmvCardReader {
  static const _mc = MethodChannel('emv_card_reader_channel');
  static const _ec = EventChannel('emv_card_reader_sink');

  Future<String> getNfcStatus() async {
    return await _mc.invokeMethod('getNfcStatus');
  }

  Future<bool> start() async {
    return await _mc.invokeMethod('start');
  }

  Future<bool> stop() async {
    return await _mc.invokeMethod('stop');
  }

  Stream<EmvCard?> stream() {
    return _ec.receiveBroadcastStream().map(_converter);
  }

  EmvCard? _converter(e) {
    return e == null ? null : EmvCard.fromMap(e);
  }
}
