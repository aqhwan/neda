import 'package:flutter/material.dart';

class NedaMenuItimButton extends StatelessWidget {
  final void Function()? onPressed;
  const NedaMenuItimButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MenuItemButton(
      onPressed: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width - 43,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: .circular(20),
        ),
        padding: const .all(40),
        child: Text(
          'Cancel',
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
