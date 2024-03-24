// Copyright (c) 2024 Appliberated (https://www.appliberated.com/). All rights reserved.
// Use of this source code is governed by a user license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

import '../common/custom_icons.dart' as custom_icons;
import '../common/strings.dart' as strings;

/// A badge that displays the East-Tec logo and the "Brought to you by" texts.
///
/// The badge is clickable and opens the East-Tec website in the default browser.
class SponsorBadge extends StatelessWidget {
  /// Creates a new [SponsorBadge].
  const SponsorBadge({
    super.key,
    this.onPressed,
  });

  final void Function()? onPressed;

  // /// Opens the East-Tec website in the default browser.
  // void _onTap(BuildContext context) {
  //   // utils.launchUrlExternal(context, app_urls.eastTecBadgeUrl);
  // }

  @override
  Widget build(BuildContext context) {
    final Color backgroundColor = Theme.of(context).colorScheme.primary;
    final Color foregroundColor = Theme.of(context).colorScheme.onPrimary;

    return FloatingActionButton.extended(
      icon: Icon(
        custom_icons.eastTecLogoMark,
        color: foregroundColor,
      ),
      // label: const Text(strings.broughtToYouByWide),
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

    // // The badge can be (and should be) clickable.
    // return InkWell(
    //   onTap: () => _onTap(context),
    //   child: Ink(
    //     // Padding and background color
    //     padding: EdgeInsets.symmetric(horizontal: isWide ? 20 : 12, vertical: 12),
    //     color: backgroundColor,
    //     child: Row(
    //       mainAxisSize: MainAxisSize.min,
    //       children: <Widget>[
    //         // The East-Tec logomark
    //         Icon(
    //           custom_icons.eastTecLogoMark,
    //           color: foregroundColor,
    //           size: 32.0,
    //         ),

    //         const SizedBox(width: 8),

    //         // The "Brought to you by" texts
    //         Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: <Widget>[
    //             Text(
    //               isWide ? strings.broughtToYouByWide : strings.broughtToYouBy,
    //               style: Theme.of(context).textTheme.bodySmall!.copyWith(color: foregroundColor),
    //             ),
    //             Text(
    //               isWide ? strings.eastTecWide : strings.eastTec,
    //               style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: foregroundColor),
    //             ),
    //           ],
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }
}
