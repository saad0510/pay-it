import 'package:flutter/material.dart';

enum AppNetworkIcons {
  notification('https://icons.iconarchive.com/icons/ionic/ionicons/64/notifications-icon.png'),
  add('https://icons.iconarchive.com/icons/ionic/ionicons/64/add-icon.png'),
  credit_card('https://icons.iconarchive.com/icons/fa-team/fontawesome/64/FontAwesome-Credit-Card-icon.png'),
  ;

  final String url;

  const AppNetworkIcons(this.url);

  Widget toImage({Color? color}) {
    return Image.network(
      url,
      height: 30,
      width: 30,
      cacheWidth: 64,
      fit: BoxFit.contain,
      color: color,
    );
  }
}

// ignore_for_file: constant_identifier_names