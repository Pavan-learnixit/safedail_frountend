import 'package:flutter/material.dart';

Widget buildSearchBar({
  double height = 50,
  required TextEditingController controller,
  required void Function()? suffixOnPressed,
  required void Function()? prefixOnPressed,
  required void Function(String)? onSubmitted,
  required BuildContext context,
}) {
  final theme = Theme.of(context);

  return Material(
    elevation: 10,
    color: theme.colorScheme.surface, // background adapts
    borderRadius: BorderRadius.circular(8),
    child: Container(
      height: height,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          // IconButton(
          //   color: theme.colorScheme.onSurfaceVariant,
          //   onPressed: prefixOnPressed,
          //   icon: const Icon(Icons.person),
          // ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              style: theme.textTheme.bodyMedium, // text adapts
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.hintColor,
                ),
                border: InputBorder.none,
                isDense: true,
              ),
              onSubmitted: onSubmitted,
            ),
          ),
          IconButton(
            color: theme.colorScheme.onSurfaceVariant,
            icon: const Icon(Icons.search),
            onPressed: suffixOnPressed,
          ),
        ],
      ),
    ),
  );
}
