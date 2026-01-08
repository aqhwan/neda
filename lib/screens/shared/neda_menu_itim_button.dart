import 'package:flutter/material.dart';

class NedaMenuItimButton extends StatelessWidget {
  final String title;
  final String details;
  final void Function()? onPressed;

  const NedaMenuItimButton({
    super.key,
    required this.details,
    required this.title,
    this.onPressed,
  });

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
        padding: const .all(20),
        child: ListTile(title: Text(title), subtitle: Text(details)),
      ),
    );
  }
}
