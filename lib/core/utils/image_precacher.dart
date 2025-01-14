import 'package:flutter/material.dart';

import '../../app/app_constants.dart';
import '../../features/home/entities/transaction_data.dart';
import '../../features/home/entities/user_data.dart';

class ImagePrecacher {
  final BuildContext context;

  const ImagePrecacher(this.context);

  static final imageUrls = <String>[
    AppConstants.userProfilePic,
    ...UserData.randomUsers.map((u) => u.imageUrl),
    ...TransactionData.randomTransactions.map((u) => u.imageUrl),
  ];

  Future<void> call() async {
    final futures = imageUrls.map((url) => precacheImage(NetworkImage(url), context));
    await Future.wait(futures);
  }
}
