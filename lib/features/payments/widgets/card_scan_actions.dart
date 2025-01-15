import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/errors/error_screen.dart';
import '../../../core/extensions/theme_ext.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/sizes.dart';
import '../controller/card_scan_notifier.dart';
import '../entities/card_data.dart';
import 'phone_reader_animation.dart';

class CardScanActions extends ConsumerWidget {
  const CardScanActions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final card = ref.watch(cardScanNotifier);

    Widget? widget;

    if (card.hasValue) {
      if (card.requireValue != null) {
        if (card.requireValue!.isEmpty)
          widget = const _CardEmptyActions();
        else
          widget = _CardSuccessActions(
            card: card.requireValue!,
          );
      } else
        widget = const _CardScanWaitingActions();
    }
    if (card.hasError)
      widget = _CardErrorActions(
        error: card.error,
        stackTrace: card.stackTrace,
      );

    widget ??= const _CardScanWaitingActions();

    final key = card.when(
      skipLoadingOnReload: true,
      data: (x) => ValueKey(x),
      error: (_, __) => const Key('error'),
      loading: () => const Key('loading'),
    );

    return Animate(
      key: key,
      delay: const Duration(milliseconds: 1200),
      effects: const [FadeEffect()],
      child: widget,
    );
  }
}

class _CardScanWaitingActions extends StatelessWidget {
  const _CardScanWaitingActions();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'HOLD CARD NEAR PHONE',
          textAlign: TextAlign.center,
          style: TextStyle(
            letterSpacing: 2,
            wordSpacing: 5,
            height: 3,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Waiting for scan',
          textAlign: TextAlign.center,
        ),
        PhoneReaderAnimation(),
      ],
    );
  }
}

class _CardEmptyActions extends StatelessWidget {
  const _CardEmptyActions();

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'ACTIVE NFC DEVICE',
          textAlign: TextAlign.center,
          style: TextStyle(
            letterSpacing: 2,
            wordSpacing: 5,
            height: 3,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Trying to connect with an active NFC device',
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 200,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ],
    );
  }
}

class _CardErrorActions extends StatelessWidget {
  const _CardErrorActions({
    required this.error,
    required this.stackTrace,
  });

  final Object? error;
  final StackTrace? stackTrace;

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: context.typography.bodyMedium.colored(context.colors.error)!,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'ERROR',
            textAlign: TextAlign.center,
            style: TextStyle(
              letterSpacing: 2,
              wordSpacing: 5,
              height: 3,
              fontWeight: FontWeight.bold,
            ),
          ),
          InkWell(
            onTap: () {
              final screen = ErrorScreen(
                title: 'Card Scan Error',
                error: error,
                stackTrace: stackTrace,
              );
              screen.showSheet(context);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: Text(
                    error is String ? error.toString() : 'Click to see full error',
                    textAlign: TextAlign.center,
                  ),
                ),
                Sizes.s6.spaceX,
                Icon(
                  Icons.arrow_upward,
                  size: Sizes.s16.value,
                  color: context.colors.error,
                ),
              ],
            ),
          ),
          Container(
            height: 200,
            alignment: Alignment.center,
            child: Icon(
              Icons.error_rounded,
              size: 100,
              color: context.colors.error,
            ),
          )
        ],
      ),
    );
  }
}

class _CardSuccessActions extends StatelessWidget {
  const _CardSuccessActions({
    required this.card,
  });

  final CardData card;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Text(
          'SUCCESS',
          textAlign: TextAlign.center,
          style: TextStyle(
            letterSpacing: 2,
            wordSpacing: 5,
            height: 3,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          'Card was successfully scanned',
          textAlign: TextAlign.center,
        ),
        Container(
          height: 200,
          alignment: Alignment.center,
          child: const Icon(
            Icons.check_circle_rounded,
            size: 100,
            color: AppColors.success,
          ),
        )
      ],
    );
  }
}
