import 'package:flutter/material.dart';
import 'package:tida_customer/config/theme/app_theme.dart';

class CustomListTile extends StatelessWidget {
  final String? iconData;
  final String tiletext;
  const CustomListTile({super.key, this.iconData, required this.tiletext});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: LARGE_PADDING ,bottom: SMALL_PADDING),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: NORMAL_PADDING),
            child: Image.asset(
              iconData ?? "",
              width: 18,
              height: 18,
            ),
          ),
          setMediumLabel(tiletext),
        ],
      ),
    );
  }
}
