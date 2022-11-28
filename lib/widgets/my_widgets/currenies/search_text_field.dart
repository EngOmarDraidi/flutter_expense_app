import 'package:flutter/material.dart';

class SearchTextField extends StatelessWidget {
  final void Function(String)? onChanged;
  const SearchTextField({this.onChanged, super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.grey,
        ),
        contentPadding: const EdgeInsets.only(bottom: 5),
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      onChanged: onChanged,
    );
  }
}
