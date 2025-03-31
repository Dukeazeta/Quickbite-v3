import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@quickbite.com',
      queryParameters: {
        'subject': 'QuickBite Support Request',
        'body': 'Hello QuickBite Support Team,\n\n',
      },
    );
    
    if (!await launchUrl(emailUri)) {
      throw Exception('Could not launch email client');
    }
  }

  Future<void> _launchPhone() async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: '+2348012345678',
    );
    
    if (!await launchUrl(phoneUri)) {
      throw Exception('Could not launch phone app');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Help & Support',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildContactSection(context),
            const SizedBox(height: 24),
            _buildFaqSection(context),
            const SizedBox(height: 24),
            _buildHelpCenterSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildContactSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 8),
          child: Text(
            'Contact Us',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildContactTile(
                context,
                'Customer Support',
                'Get help with your orders and deliveries',
                Icons.headset_mic_outlined,
                () => _launchPhone(),
              ),
              _buildDivider(),
              _buildContactTile(
                context,
                'Email Support',
                'support@quickbite.com',
                Icons.email_outlined,
                () => _launchEmail(),
              ),
              _buildDivider(),
              _buildContactTile(
                context,
                'Live Chat',
                'Chat with our support team',
                Icons.chat_outlined,
                () {
                  // In a real app, this would open a chat interface
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Live chat feature coming soon!'),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFaqSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 8),
          child: Text(
            'Frequently Asked Questions',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildFaqItem(
                context,
                'How do I track my order?',
                'You can track your order in real-time by going to the "My Orders" section in your profile and selecting the active order.',
              ),
              _buildDivider(),
              _buildFaqItem(
                context,
                'How can I cancel my order?',
                'You can cancel your order within 5 minutes of placing it by going to "My Orders" and selecting "Cancel Order". After 5 minutes, please contact customer support.',
              ),
              _buildDivider(),
              _buildFaqItem(
                context,
                'What payment methods are accepted?',
                'We accept credit/debit cards, mobile money, and cash on delivery. You can manage your payment methods in the "Payment Methods" section of your profile.',
              ),
              _buildDivider(),
              _buildFaqItem(
                context,
                'How do I add a new delivery address?',
                'Go to "My Addresses" in your profile and tap on "Add New Address". You can then enter your address details or use your current location.',
              ),
              _buildDivider(),
              _buildFaqItem(
                context,
                'What if I receive the wrong order?',
                'If you receive an incorrect order, please contact customer support immediately. We will arrange for the correct order to be delivered to you as soon as possible.',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildHelpCenterSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8, bottom: 8),
          child: Text(
            'Help Center',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              _buildHelpCenterTile(
                context,
                'User Guide',
                'Learn how to use the QuickBite app',
                Icons.menu_book_outlined,
                () {
                  Navigator.pushNamed(context, '/user-guide');
                },
              ),
              _buildDivider(),
              _buildHelpCenterTile(
                context,
                'Video Tutorials',
                'Watch step-by-step guides',
                Icons.video_library_outlined,
                () {
                  // In a real app, this would open a video tutorials page
                  _launchUrl('https://www.youtube.com/');
                },
              ),
              _buildDivider(),
              _buildHelpCenterTile(
                context,
                'Community Forum',
                'Connect with other QuickBite users',
                Icons.forum_outlined,
                () {
                  // In a real app, this would open a community forum
                  _launchUrl('https://www.example.com/forum');
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactTile(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.red[700],
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey[400],
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFaqItem(
    BuildContext context,
    String question,
    String answer,
  ) {
    return Theme(
      data: Theme.of(context).copyWith(
        dividerColor: Colors.transparent,
      ),
      child: ExpansionTile(
        title: Text(
          question,
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        iconColor: Colors.red[700],
        collapsedIconColor: Colors.grey[600],
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: Text(
              answer,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHelpCenterTile(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(
              icon,
              color: Colors.red[700],
              size: 24,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey[400],
              size: 16,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDivider() {
    return Divider(
      height: 1,
      thickness: 1,
      color: Colors.grey[200],
      indent: 56,
    );
  }
}