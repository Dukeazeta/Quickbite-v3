import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback? onFilterTap;

  const CustomSearchBar({
    Key? key,
    required this.controller,
    this.onFilterTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
      child: Container(
        height: 55,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(16),
        ),
        child: TextField(
          controller: controller,
          style: GoogleFonts.poppins(color: Colors.black87),
          decoration: InputDecoration(
            hintText: 'Search for food, restaurants...',
            hintStyle: GoogleFonts.poppins(
              color: Colors.grey[500],
              fontSize: 14,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey[500],
              size: 22,
            ),
            suffixIcon: GestureDetector(
              onTap: onFilterTap,
              child: Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red[700],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.tune,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          ),
        ),
      ),
    );
  }
}