import 'package:adminpanel/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class MyDropDownWrapper extends StatelessWidget {
  const MyDropDownWrapper(this.child, {Key? key}) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppColors.listTile,
        borderRadius: BorderRadius.circular(10),
      ),
      child: child,
    );
  }

  static const transparentDivider =
      Divider(height: 0, color: Colors.transparent);
}
