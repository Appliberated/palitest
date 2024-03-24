// Copyright (c) 2024 Appliberated (https://www.appliberated.com/). All rights reserved.
// Use of this source code is governed by a user license that can be found in the LICENSE file.

/// URLs used in the app.
library;

const String _appId = 'palitest';
const String _utmSource = 'palitest';
const String _utmMedium = 'app';

/// The url of the East-Tec website, with UTM parameters, used in the East-Tec badge.
const String sponsorBadgeUrl =
    'https://www.east-tec.com/?utm_source=$_utmSource&utm_medium=$_utmMedium&utm_campaign=${_appId}_badge';
