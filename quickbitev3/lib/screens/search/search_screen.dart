import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  bool _isSearching = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _performSearch(String query) {
    // Mock search results - replace with actual API call
    setState(() {
      _isSearching = true;
    });

    // Simulate network delay
    Future.delayed(const Duration(milliseconds: 800), () {
      if (query.isNotEmpty) {
        setState(() {
          _searchResults = [
            {
              'name': 'Jollof Rice',
              'restaurant': 'Nigerian Delights',
              'price': '₦1,500',
              'image': 'assets/images/jollof_rice.jpg',
              'rating': 4.8,
            },
            {
              'name': 'Suya Platter',
              'restaurant': 'Suya Express',
              'price': '₦2,000',
              'image': 'assets/images/suya.jpg',
              'rating': 4.5,
            },
            {
              'name': 'Fried Rice',
              'restaurant': 'Golden Spoon',
              'price': '₦1,800',
              'image': 'assets/images/fried_rice.jpg',
              'rating': 4.3,
            },
          ];
          _isSearching = false;
        });
      } else {
        setState(() {
          _searchResults = [];
          _isSearching = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Search',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(15),
              ),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Search for food, restaurants...',
                  hintStyle: GoogleFonts.poppins(color: Colors.grey[500]),
                  prefixIcon: Icon(Icons.search, color: Colors.red[700]),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                ),
                onChanged: _performSearch,
              ),
            ),
          ),
          if (_isSearching)
            const Center(
              child: CircularProgressIndicator(),
            )
          else if (_searchResults.isEmpty && _searchController.text.isNotEmpty)
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 80,
                      color: Colors.grey[400],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'No results found',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: _searchResults.length,
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  final item = _searchResults[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(12),
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          width: 60,
                          height: 60,
                          color: Colors.grey[300],
                          child: Center(
                            child: Icon(
                              Icons.fastfood,
                              color: Colors.red[700],
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        item['name'],
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item['restaurant'],
                            style: GoogleFonts.poppins(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                item['rating'].toString(),
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      trailing: Text(
                        item['price'],
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.bold,
                          color: Colors.red[700],
                        ),
                      ),
                      onTap: () {
                        // Navigate to food details
                      },
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}