import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterDialog extends StatefulWidget {
  final Map<String, dynamic> initialFilters;
  final Function(Map<String, dynamic>) onApplyFilters;

  const FilterDialog({
    super.key,
    this.initialFilters = const {},
    required this.onApplyFilters,
  });

  @override
  State<FilterDialog> createState() => _FilterDialogState();
}

class _FilterDialogState extends State<FilterDialog> {
  late Map<String, dynamic> _filters;
  late RangeValues _priceRange;
  late double _minRating;
  late List<String> _selectedCategories;
  late String _sortBy;

  @override
  void initState() {
    super.initState();
    _filters = Map<String, dynamic>.from(widget.initialFilters);
    _priceRange = _filters['priceRange'] ?? const RangeValues(0, 5000);
    _minRating = _filters['minRating'] ?? 0.0;
    _selectedCategories = List<String>.from(_filters['categories'] ?? []);
    _sortBy = _filters['sortBy'] ?? 'popularity';
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filter',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              const Divider(),
              
              // Price Range
              _buildSectionTitle('Price Range'),
              RangeSlider(
                values: _priceRange,
                min: 0,
                max: 5000,
                divisions: 50,
                labels: RangeLabels(
                  '₦${_priceRange.start.round()}',
                  '₦${_priceRange.end.round()}',
                ),
                activeColor: Colors.red[700],
                inactiveColor: Colors.grey[300],
                onChanged: (values) {
                  setState(() {
                    _priceRange = values;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₦${_priceRange.start.round()}',
                      style: GoogleFonts.poppins(
                        color: Colors.grey[600],
                      ),
                    ),
                    Text(
                      '₦${_priceRange.end.round()}',
                      style: GoogleFonts.poppins(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              
              // Rating
              _buildSectionTitle('Minimum Rating'),
              Slider(
                value: _minRating,
                min: 0,
                max: 5,
                divisions: 10,
                label: _minRating.toString(),
                activeColor: Colors.red[700],
                inactiveColor: Colors.grey[300],
                onChanged: (value) {
                  setState(() {
                    _minRating = value;
                  });
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '0',
                      style: GoogleFonts.poppins(
                        color: Colors.grey[600],
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          _minRating.toStringAsFixed(1),
                          style: GoogleFonts.poppins(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 4),
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                      ],
                    ),
                    Text(
                      '5',
                      style: GoogleFonts.poppins(
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              
              // Categories
              _buildSectionTitle('Categories'),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _buildCategoryChip('Nigerian'),
                  _buildCategoryChip('Fast Food'),
                  _buildCategoryChip('Chinese'),
                  _buildCategoryChip('Desserts'),
                  _buildCategoryChip('Vegetarian'),
                  _buildCategoryChip('Seafood'),
                ],
              ),
              const SizedBox(height: 16),
              
              // Sort By
              _buildSectionTitle('Sort By'),
              _buildSortOption('popularity', 'Popularity'),
              _buildSortOption('rating', 'Rating (High to Low)'),
              _buildSortOption('priceAsc', 'Price (Low to High)'),
              _buildSortOption('priceDesc', 'Price (High to Low)'),
              const SizedBox(height: 24),
              
              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _priceRange = const RangeValues(0, 5000);
                        _minRating = 0.0;
                        _selectedCategories = [];
                        _sortBy = 'popularity';
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: Colors.red[700]!),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    ),
                    child: Text(
                      'Reset',
                      style: GoogleFonts.poppins(
                        color: Colors.red[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _filters = {
                        'priceRange': _priceRange,
                        'minRating': _minRating,
                        'categories': _selectedCategories,
                        'sortBy': _sortBy,
                      };
                      widget.onApplyFilters(_filters);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                    child: Text(
                      'Apply Filters',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String category) {
    final isSelected = _selectedCategories.contains(category);
    return FilterChip(
      label: Text(
        category,
        style: GoogleFonts.poppins(
          color: isSelected ? Colors.white : Colors.black87,
          fontSize: 12,
        ),
      ),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          if (selected) {
            _selectedCategories.add(category);
          } else {
            _selectedCategories.remove(category);
          }
        });
      },
      backgroundColor: Colors.grey[200],
      selectedColor: Colors.red[700],
      checkmarkColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  Widget _buildSortOption(String value, String label) {
    return RadioListTile<String>(
      title: Text(
        label,
        style: GoogleFonts.poppins(
          fontSize: 14,
        ),
      ),
      value: value,
      groupValue: _sortBy,
      onChanged: (newValue) {
        setState(() {
          _sortBy = newValue!;
        });
      },
      activeColor: Colors.red[700],
      contentPadding: EdgeInsets.zero,
      dense: true,
    );
  }
}