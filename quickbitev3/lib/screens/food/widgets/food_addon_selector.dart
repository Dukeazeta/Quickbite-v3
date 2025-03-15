import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FoodAddonSelector extends StatelessWidget {
  final List<String> selectedAddons;
  final Function(String) onToggleAddon;

  const FoodAddonSelector({
    Key? key,
    required this.selectedAddons,
    required this.onToggleAddon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Add-ons',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        _buildAddonOption('Extra Cheese', '+₦500'),
        const SizedBox(height: 8),
        _buildAddonOption('Extra Sauce', '+₦500'),
        const SizedBox(height: 8),
        _buildAddonOption('Extra Toppings', '+₦500'),
      ],
    );
  }

  Widget _buildAddonOption(String addon, String priceText) {
    final bool isSelected = selectedAddons.contains(addon);
    
    return GestureDetector(
      onTap: () => onToggleAddon(addon),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? Colors.red[50] : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.red[700]! : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              addon,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? Colors.red[700] : Colors.black,
              ),
            ),
            Row(
              children: [
                Text(
                  priceText,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
                const SizedBox(width: 8),
                Icon(
                  isSelected ? Icons.check_circle : Icons.circle_outlined,
                  color: isSelected ? Colors.red[700] : Colors.grey[400],
                  size: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}