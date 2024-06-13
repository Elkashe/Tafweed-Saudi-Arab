import 'package:flutter/material.dart';

class SettingsCard extends StatelessWidget {
  final String title;
  final String? subTitle;
  final Widget? leading;
  final Function() onTap;
  const SettingsCard({super.key, required this.title, this.subTitle, required this.onTap, this.leading});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 2,
        ),
      ),
      child: ListTile(
        onTap: onTap,
        leading: leading,
        title: Text(title),
        subtitle: subTitle != null ? Text(subTitle!) : null,
      ),
    );
  }
}