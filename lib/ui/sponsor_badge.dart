// Copyright (c) 2024 Appliberated (https://www.appliberated.com/). All rights reserved.
// Use of this source code is governed by a user license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../common/custom_icons.dart' as custom_icons;
import '../common/strings.dart' as strings;
import '../common/theme.dart';
import '../utils/color_utils.dart' as color_utils;

/// A clickable badge that displays the East-Tec logo and the "Brought to you by" texts.
class SponsorBadge extends StatelessWidget {
  /// Creates a new [SponsorBadge].
  const SponsorBadge({
    super.key,
    this.onPressed,
  });

  /// The callback that is called when the badge is clicked.
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    const Color backgroundColor = sponsorBackgroundColor;
    final Color foregroundColor = color_utils.getContrastColor(backgroundColor);

    return FloatingActionButton.extended(
      backgroundColor: backgroundColor,
      icon: Icon(
        custom_icons.eastTecLogoMark,
        color: foregroundColor,
      ),
      label: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            strings.sponsorSubtitle,
            style: Theme.of(context).textTheme.bodySmall!.copyWith(color: foregroundColor),
          ),
          Text(
            strings.sponsorTitle,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: foregroundColor),
          ),
        ],
      ),
      onPressed: onPressed,
    );
  }
}
