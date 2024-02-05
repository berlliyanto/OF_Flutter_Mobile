import 'package:flutter/material.dart';
import 'package:of_flutter_mobile/app/components/widgets/drawer/drawer_header.dart';
import 'package:of_flutter_mobile/app/components/widgets/drawer/drawer_item.dart';
import 'package:of_flutter_mobile/app/source/menu/drawer_list.dart';
import 'package:of_flutter_mobile/app/theme/color.dart';

Drawer drawer({
  required ColorPicker colors,
  required String currentActiveMenu,
  required Function(dynamic route) onTap,
}) {
  return Drawer(
    child: Column(
      children: [
        drawerHeader(colors: colors),
        Flexible(
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: listDrawer.length,
            itemBuilder: (context, index) {
              final data = listDrawer[index];
              if (index == 2) {
                return Column(
                  children: [
                    const Divider(),
                    drawerItem(
                      color: currentActiveMenu == data.title
                          ? colors.cyanDark.withOpacity(0.1)
                          : Colors.transparent,
                      title: data.title,
                      icon: data.icon,
                      onTap: () => onTap(data.routes),
                    ),
                  ],
                );
              }

              return drawerItem(
                color: currentActiveMenu == data.title
                    ? colors.cyanDark.withOpacity(0.1)
                    : Colors.transparent,
                title: data.title,
                icon: data.icon,
                onTap: () => onTap(data.routes),
              );
            },
          ),
        ),
      ],
    ),
  );
}
