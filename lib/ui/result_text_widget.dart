// Copyright (c) 2024 Appliberated (https://www.appliberated.com/). All rights reserved.
// Use of this source code is governed by a user license that can be found in the LICENSE file.

import 'package:flutter/material.dart';

class ResultTextWidget extends AnimatedWidget {
  const ResultTextWidget({
    super.key,
    required this.text,
    required this.color,
    required Animation<double> animation,
  }) : super(listenable: animation);

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(fontSize: 18.0, color: color),
    );
  }
}
