import 'package:flutter/material.dart';

import '../../../core/extensions/nav_ext.dart';
import '../../../core/extensions/theme_ext.dart';
import '../../../theme/sizes.dart';
import '../../payments/screens/card_scan_screen.dart';
import '../widgets/home_app_bar.dart';
import '../widgets/payees_list.dart';
import '../widgets/transaction_bottom_sheet.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: context.colors.primary,
        foregroundColor: context.colors.onPrimary,
        onPressed: () => context.push(const CardScanScreen()),
        child: const Icon(
          Icons.credit_card,
          size: 30,
        ),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const HomeAppBar(),
            const SizedBox(height: 10),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: context.colors.primary,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: Sizes.s24.pad,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Send Money',
                            style: context.typography.titleLarge.colored(context.colors.onPrimary),
                          ),
                          const SizedBox(height: 30),
                          const PayeesList(),
                        ],
                      ),
                    ),
                    const Expanded(
                      child: TransactionBottomSheet(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
