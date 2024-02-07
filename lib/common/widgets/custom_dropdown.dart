import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  const CustomDropdown(
      {super.key,
      required this.menuItems,
      required this.onChanged,
      this.icon,
      this.value});

  final List<String> menuItems;
  final void Function(Object?)? onChanged;
  final String? value;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      items: menuItems.map((String items) {
        return DropdownMenuItem(
          value: items,
          child: Center(child: Text(items)),
        );
      }).toList(),
      focusColor: Colors.transparent,
      onChanged: onChanged,
      value: value ?? menuItems.first,
      isDense: false,
      underline: const Divider(color: Colors.transparent),
      icon: icon,
      isExpanded: true,
      borderRadius: BorderRadius.circular(18),
    );
  }
}
