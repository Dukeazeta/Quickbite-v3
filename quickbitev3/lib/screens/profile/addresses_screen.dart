import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddressesScreen extends StatelessWidget {
  const AddressesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Addresses',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to add address screen
        },
        backgroundColor: Colors.red,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: 3, // Demo data
        itemBuilder: (context, index) {
          return _buildAddressCard(context, index);
        },
      ),
    );
  }

  Widget _buildAddressCard(BuildContext context, int index) {
    // Demo data
    final addressTypes = ['Home', 'Work', 'Other'];
    final addressType = addressTypes[index % addressTypes.length];
    final isDefault = index == 0;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      addressType == 'Home'
                          ? Icons.home
                          : (addressType == 'Work'
                              ? Icons.work
                              : Icons.location_on),
                      color: Colors.red,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      addressType,
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                if (isDefault)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'Default',
                      style: GoogleFonts.poppins(
                        color: Colors.red,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '123 Main Street, Apt ${index + 1}',
              style: GoogleFonts.poppins(
                fontSize: 14,
              ),
            ),
            Text(
              'Cityville, State 12345',
              style: GoogleFonts.poppins(
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    // Edit address
                  },
                  child: Text(
                    'Edit',
                    style: GoogleFonts.poppins(
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                TextButton(
                  onPressed: () {
                    // Delete address
                  },
                  child: Text(
                    'Delete',
                    style: GoogleFonts.poppins(
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}