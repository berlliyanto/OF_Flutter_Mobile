import 'package:flutter/material.dart';
import 'package:of_flutter_mobile/app/components/widgets/text/paragraph.dart';

Widget drawerItem(
    {Color color = Colors.transparent,
    required String title,
    required IconData icon,
    required VoidCallback onTap}) {
  return ListTile(
    leading: Icon(
      icon,
      color: const Color(0xFFF0583D),
      size: 20,
    ),
    style: ListTileStyle.drawer,
    title: Paragraph(
      text: title,
      color: const Color(0xFF181823),
      fontWeight: FontWeight.bold,
      fontSize: 16,
    ),
    tileColor: color,
    onTap: onTap,
  );
}
