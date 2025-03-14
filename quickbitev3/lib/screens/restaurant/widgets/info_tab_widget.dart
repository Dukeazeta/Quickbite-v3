import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoTabWidget extends StatelessWidget {
  const InfoTabWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildInfoSection('About', [
          _buildInfoItem(Icons.info_outline, 'Authentic Nigerian cuisine with traditional recipes. Our restaurant offers a vibrant atmosphere perfect for family gatherings, celebrations, or casual meals.', 'About Us'),
          _buildInfoItem(Icons.restaurant_menu, 'Jollof rice, pounded yam with egusi soup, suya, and traditional Nigerian desserts.', 'Menu Highlights'),
        ]),
        const SizedBox(height: 16),
        _buildInfoSection('Hours', [
          _buildHoursItem('Monday - Thursday', '11:00 AM - 10:00 PM'),
          _buildHoursItem('Friday - Saturday', '11:00 AM - 11:00 PM'),
          _buildHoursItem('Sunday', '12:00 PM - 9:00 PM'),
        ]),
        const SizedBox(height: 16),
        _buildInfoSection('Location', [
          _buildMapPreview(),
          _buildAddressItem('123 Victoria Island, Lagos, Nigeria'),
          _buildDirectionsButton(),
        ]),
        const SizedBox(height: 16),
        _buildInfoSection('Contact', [
          _buildContactItem(Icons.phone, '+234 812 345 6789'),
          _buildContactItem(Icons.email, 'info@nigeriandelights.com'),
          _buildContactItem(Icons.language, 'www.nigeriandelights.com'),
        ]),
      ],
    );
  }

  Widget _buildInfoSection(String title, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String content, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Colors.red[700],
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  content,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHoursItem(String day, String hours) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            day,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey[800],
            ),
          ),
          Text(
            hours,
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMapPreview() {
    return Container(
      height: 180,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.grey[300],
        image: const DecorationImage(
          image: NetworkImage('https://maps.googleapis.com/maps/api/staticmap?center=6.4281,3.4219&zoom=15&size=600x300&maptype=roadmap&markers=color:red%7C6.4281,3.4219&key=YOUR_API_KEY'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Icon(
          Icons.map,
          color: Colors.grey[400],
          size: 48,
        ),
      ),
    );
  }

  Widget _buildAddressItem(String address) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Icon(
            Icons.location_on,
            color: Colors.red[700],
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              address,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[800],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDirectionsButton() {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(Icons.directions, color: Colors.red[700]),
      label: Text(
        'Get Directions',
        style: GoogleFonts.poppins(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: Colors.red[700],
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.red[700],
        elevation: 0,
        side: BorderSide(color: Colors.red[700]!),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
        minimumSize: const Size(double.infinity, 48),
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.red[700],
            size: 20,
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey[800],
            ),
          ),
        ],
      ),
    );
  }
}