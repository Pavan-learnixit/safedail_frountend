import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget buildSearchBar({
  double? height=50,
  required TextEditingController controller,
  required void Function()? suffixOnPressed,
  required void Function()? prefixOnPressed,
  required void Function(String)? onSubmitted
}) {
  return Material(
    elevation: 10,
    child: Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          IconButton( color: Colors.grey, onPressed: prefixOnPressed, icon: Icon(Icons.person),),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Search...',
                border: InputBorder.none,
                isDense: true,
              ),
              onSubmitted: onSubmitted,
            ),
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: suffixOnPressed,
          ),
        ],
      ),
    ),
  );
}