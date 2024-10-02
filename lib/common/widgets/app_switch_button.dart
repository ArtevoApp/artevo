import 'package:flutter/material.dart';

import '../../core/config/color_schemes.dart';

class AppSwitch extends StatelessWidget {
  const AppSwitch({
    super.key,
    this.initialValue,
    this.onChanged,
  });

  /// Initial value of the switch.
  final bool? initialValue;

  /// Called when the user toggles the switch.
  final ValueChanged<bool>? onChanged;
  @override
  Widget build(BuildContext context) {
    final controller = ValueNotifier(initialValue ?? false);
    return ValueListenableBuilder(
      valueListenable: controller,
      builder: (context, val, child) {
        return Switch.adaptive(
          value: val,
          thumbColor: WidgetStateProperty.resolveWith(
            (states) {
              if (states.contains(WidgetState.selected)) {
                return Theme.of(context).colorScheme.primary;
              } else {
                return lightColorScheme.surface;
              }
            },
          ),
          trackColor: WidgetStateProperty.resolveWith(
            (states) {
              if (states.contains(WidgetState.selected)) {
                return Theme.of(context).colorScheme.tertiary;
              }
              return null;
            },
          ),
          trackOutlineWidth: const WidgetStatePropertyAll(1),
          trackOutlineColor: WidgetStateProperty.all(
            Theme.of(context).colorScheme.onSurface.withOpacity(.1),
          ),
          onChanged: (val) {
            controller.value = val;
            if (onChanged != null) {
              onChanged!(val);
            }
          },
        );
      },
    );
  }
}
