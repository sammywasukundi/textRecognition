
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

Widget cardMiddle(BuildContext context) {
  return Card(
    color: greyColor,
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      height: MediaQuery.of(context).size.height - 260,
    ),
  );
}

