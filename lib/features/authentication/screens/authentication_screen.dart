import 'package:flutter/material.dart';

import '../../../theme/sizes.dart';
import '../widgets/auth_fingerprint_scan.dart';
import '../widgets/authentication_subtitle.dart';
import '../widgets/authentication_title.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authenticate'),
      ),
      body: const Center(
        child: Stack(
          children: [
            AuthFingerprintScan(),
            Positioned.fill(
              top: null,
              bottom: 120,
              child: Center(
                child: AuthenticationTitle(),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 150,
        alignment: Alignment.bottomCenter,
        padding: Sizes.s32.pad,
        child: const AuthenticationSubtitle(),
      ),
    );
  }
}
