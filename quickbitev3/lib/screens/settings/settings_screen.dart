import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/auth_service.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _locationEnabled = true;
  bool _darkModeEnabled = false;
  String _selectedLanguage = 'English';
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      
      setState(() {
        _notificationsEnabled = prefs.getBool('notifications_enabled') ?? true;
        _locationEnabled = prefs.getBool('location_enabled') ?? true;
        _darkModeEnabled = prefs.getBool('dark_mode_enabled') ?? false;
        _selectedLanguage = prefs.getString('selected_language') ?? 'English';
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to load settings: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _saveSettings() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      
      await prefs.setBool('notifications_enabled', _notificationsEnabled);
      await prefs.setBool('location_enabled', _locationEnabled);
      await prefs.setBool('dark_mode_enabled', _darkModeEnabled);
      await prefs.setString('selected_language', _selectedLanguage);
      
      setState(() {
        _isLoading = false;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Settings saved successfully'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save settings: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('App Preferences'),
                  _buildSettingsCard([
                    _buildSwitchTile(
                      'Notifications',
                      'Receive order updates and promotions',
                      _notificationsEnabled,
                      (value) {
                        setState(() {
                          _notificationsEnabled = value;
                        });
                        _saveSettings();
                      },
                      Icons.notifications_outlined,
                    ),
                    _buildDivider(),
                    _buildSwitchTile(
                      'Location Services',
                      'Allow app to access your location',
                      _locationEnabled,
                      (value) {
                        setState(() {
                          _locationEnabled = value;
                        });
                        _saveSettings();
                      },
                      Icons.location_on_outlined,
                    ),
                    _buildDivider(),
                    _buildSwitchTile(
                      'Dark Mode',
                      'Switch between light and dark themes',
                      _darkModeEnabled,
                      (value) {
                        setState(() {
                          _darkModeEnabled = value;
                        });
                        _saveSettings();
                      },
                      Icons.dark_mode_outlined,
                    ),
                  ]),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Language'),
                  _buildSettingsCard([
                    _buildLanguageSelector(),
                  ]),
                  const SizedBox(height: 24),
                  _buildSectionTitle('Account'),
                  _buildSettingsCard([
                    _buildMenuTile(
                      'Change Password',
                      'Update your account password',
                      () {
                        Navigator.pushNamed(context, '/change-password');
                      },
                      Icons.lock_outline,
                    ),
                    _buildDivider(),
                    _buildMenuTile(
                      'Privacy Settings',
                      'Manage your data and privacy',
                      () {
                        Navigator.pushNamed(context, '/privacy-settings');
                      },
                      Icons.privacy_tip_outlined,
                    ),
                    _buildDivider(),
                    _buildMenuTile(
                      'Delete Account',
                      'Permanently delete your account',
                      () {
                        _showDeleteAccountDialog();
                      },
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                  ]),
                  const SizedBox(height: 24),
                  _buildSectionTitle('About'),
                  _buildSettingsCard([
                    _buildMenuTile(
                      'App Version',
                      '1.0.0',
                      () {},
                      Icons.info_outline,
                      showArrow: false,
                    ),
                    _buildDivider(),
                    _buildMenuTile(
                      'Terms of Service',
                      'Read our terms and conditions',
                      () {
                        Navigator.pushNamed(context, '/terms');
                      },
                      Icons.description_outlined,
                    ),
                    _buildDivider(),
                    _buildMenuTile(
                      'Privacy Policy',
                      'Read our privacy policy',
                      () {
                        Navigator.pushNamed(context, '/privacy-policy');
                      },
                      Icons.policy_outlined,
                    ),
                  ]),
                  const SizedBox(height: 24),
                ],
              ),
            ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 8),
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSettingsCard(List<Widget> children) {
    return Container(
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
        children: children,
      ),
    );
  }

  Widget _buildSwitchTile(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
    IconData icon,
  ) {
    return Padding(
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
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.red[700],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuTile(
    String title,
    String subtitle,
    VoidCallback onTap,
    IconData icon, {
    Color? color,
    bool showArrow = true,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Icon(
              icon,
              color: color ?? Colors.red[700],
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
                      color: color,
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
            if (showArrow)
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

  Widget _buildLanguageSelector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Icon(
            Icons.language,
            color: Colors.red[700],
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Language',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                  ),
                ),
                Text(
                  'Select your preferred language',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          DropdownButton<String>(
            value: _selectedLanguage,
            icon: const Icon(Icons.arrow_drop_down),
            elevation: 16,
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 14,
            ),
            underline: Container(
              height: 0,
            ),
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  _selectedLanguage = newValue;
                });
                _saveSettings();
              }
            },
            items: <String>['English', 'Spanish', 'French', 'Arabic']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
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

  void _showDeleteAccountDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Delete Account',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Are you sure you want to delete your account? This action cannot be undone.',
          style: GoogleFonts.poppins(),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'Cancel',
              style: GoogleFonts.poppins(
                color: Colors.grey[700],
              ),
            ),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              
              // Show loading indicator
              setState(() {
                _isLoading = true;
              });
              
              try {
                // In a real app, you would call an API to delete the account
                await Future.delayed(const Duration(seconds: 2));
                
                // Log out the user
                final authService = Provider.of<AuthService>(context, listen: false);
                await authService.logout();
                
                if (mounted) {
                  // Navigate to login screen
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login',
                    (route) => false,
                  );
                }
              } catch (e) {
                setState(() {
                  _isLoading = false;
                });
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Failed to delete account: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            child: Text(
              'Delete',
              style: GoogleFonts.poppins(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}