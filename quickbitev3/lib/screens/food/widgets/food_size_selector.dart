import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodSizeSelector extends StatelessWidget {
  final String? selectedSize;
  final Function(String) onSizeSelected;

  const FoodSizeSelector({
    Key? key,
    required this.selectedSize,
    required this.onSizeSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Size',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildSizeOption('Small', 'Regular size', context),
            const SizedBox(width: 12),
            _buildSizeOption('Medium', '+₦500', context),
            const SizedBox(width: 12),
            _buildSizeOption('Large', '+₦1000', context),
          ],
        ),
      ],
    );
  }

  Widget _buildSizeOption(String size, String priceText, BuildContext context) {
    final bool isSelected = selectedSize == size;
    
    return Expanded(
      child: GestureDetector(
        onTap: () => onSizeSelected(size),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.red[50] : Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? Colors.red[700]! : Colors.grey[300]!,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Column(
            children: [
              Text(
                size,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? Colors.red[700] : Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                priceText,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}