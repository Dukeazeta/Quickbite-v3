import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quickbitev3/screens/food/food_details_screen.dart';
import 'package:quickbitev3/screens/restaurant/restaurant_details_screen.dart';
import '../../widgets/custom_bottom_navbar.dart';
import '../../widgets/food_item_card.dart';
// Update the import to use the renamed widget
import '../../widgets/search_bar.dart';
import '../../widgets/promotional_banner.dart';
import '../../widgets/restaurant_card.dart';
import '../../widgets/filter_dialog.dart';

class FoodItemsScreen extends StatefulWidget {
  const FoodItemsScreen({super.key});

  @override
  State<FoodItemsScreen> createState() => _FoodItemsScreenState();
}

class _FoodItemsScreenState extends State<FoodItemsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  int _currentIndex = 0;
  Map<String, dynamic> _activeFilters = {};

  // Add these properties to your _FoodItemsScreenState class
  List<Map<String, dynamic>> _allFoodItems = [];
  List<Map<String, dynamic>> _filteredFoodItems = [];
  bool _isLoading = true;

  // Add this as a class variable
  // Make sure you have a list of restaurants defined as a class variable
  final List<Map<String, dynamic>> _restaurants = [];
  
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    // Load initial food items
    _loadFoodItems();
  }

  // Load sample food items (in a real app, this would come from an API)
  void _loadFoodItems() {
    setState(() {
      _isLoading = true;
    });

    // Simulate API call with a delay
    Future.delayed(const Duration(milliseconds: 800), () {
      // Sample food items data
      // In your _loadFoodItems() method
      _allFoodItems = [
        {
          'id': '1',
          'name': 'Jollof Rice',
          'restaurant': "Mama's Kitchen",
          'price': 1500,
          'rating': 4.8,
          'category': 'Nigerian',
          'imageUrl':
              'https://images.pexels.com/photos/7613568/pexels-photo-7613568.jpeg',
        },
        {
          'id': '2',
          'name': 'Chicken Suya',
          'restaurant': 'Suya Spot',
          'price': 2000,
          'rating': 4.6,
          'category': 'Nigerian',
          'imageUrl':
              'https://images.pexels.com/photos/2338407/pexels-photo-2338407.jpeg',
        },
        {
          'id': '3',
          'name': 'Egusi Soup',
          'restaurant': "Mama's Kitchen",
          'price': 1800,
          'rating': 4.7,
          'category': 'Nigerian',
          'imageUrl':
              'https://images.pexels.com/photos/5949893/pexels-photo-5949893.jpeg',
        },
        {
          'id': '4',
          'name': 'Fried Rice',
          'restaurant': 'Golden Dragon',
          'price': 1600,
          'rating': 4.5,
          'category': 'Chinese',
          'imageUrl':
              'https://images.pexels.com/photos/723198/pexels-photo-723198.jpeg',
        },
        {
          'id': '5',
          'name': 'Burger',
          'restaurant': 'Chicken Republic',
          'price': 1200,
          'rating': 4.3,
          'category': 'Fast Food',
          'imageUrl':
              'https://images.pexels.com/photos/1639557/pexels-photo-1639557.jpeg',
        },
        {
          'id': '6',
          'name': 'Pizza',
          'restaurant': 'Domino\'s',
          'price': 3500,
          'rating': 4.4,
          'category': 'Fast Food',
          'imageUrl':
              'https://images.pexels.com/photos/825661/pexels-photo-825661.jpeg',
        },
        {
          'id': '7',
          'name': 'Ice Cream',
          'restaurant': 'Cold Stone',
          'price': 1000,
          'rating': 4.9,
          'category': 'Desserts',
          'imageUrl':
              'https://images.pexels.com/photos/1352281/pexels-photo-1352281.jpeg',
        },
        {
          'id': '8',
          'name': 'Chow Mein',
          'restaurant': 'Golden Dragon',
          'price': 2200,
          'rating': 4.6,
          'category': 'Chinese',
          'imageUrl':
              'https://images.pexels.com/photos/2347311/pexels-photo-2347311.jpeg',
        },
      ];

      // Initially, filtered items are the same as all items
      _filteredFoodItems = List.from(_allFoodItems);

      setState(() {
        _isLoading = false;
      });
    });
  }

  void _applyFilters() {
    if (_activeFilters.isEmpty) {
      // If no filters are active, show all items
      setState(() {
        _filteredFoodItems = List.from(_allFoodItems);
      });
      return;
    }

    // Start with all food items
    List<Map<String, dynamic>> result = List.from(_allFoodItems);

    // Apply price range filter
    final priceRange = _activeFilters['priceRange'] as RangeValues?;
    if (priceRange != null) {
      result = result.where((item) {
        final price = item['price'] as num;
        return price >= priceRange.start && price <= priceRange.end;
      }).toList();
    }

    // Apply minimum rating filter
    final minRating = _activeFilters['minRating'] as double?;
    if (minRating != null) {
      result = result.where((item) {
        final rating = item['rating'] as double;
        return rating >= minRating;
      }).toList();
    }

    // Apply category filter
    final categories = _activeFilters['categories'] as List<String>?;
    if (categories != null && categories.isNotEmpty) {
      result = result.where((item) {
        final category = item['category'] as String;
        return categories.contains(category);
      }).toList();
    }

    // Apply sorting
    final sortBy = _activeFilters['sortBy'] as String?;
    if (sortBy != null) {
      switch (sortBy) {
        case 'popularity':
          // For demo purposes, we'll use rating as a proxy for popularity
          result.sort((a, b) =>
              (b['rating'] as double).compareTo(a['rating'] as double));
          break;
        case 'rating':
          result.sort((a, b) =>
              (b['rating'] as double).compareTo(a['rating'] as double));
          break;
        case 'priceAsc':
          result
              .sort((a, b) => (a['price'] as num).compareTo(b['price'] as num));
          break;
        case 'priceDesc':
          result
              .sort((a, b) => (b['price'] as num).compareTo(a['price'] as num));
          break;
      }
    }

    // Update the filtered items
    setState(() {
      _filteredFoodItems = result;
    });

    // Show a message about the filter results
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Found ${_filteredFoodItems.length} items matching your filters',
          style: GoogleFonts.poppins(),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // App Bar with Profile and Notification
            SliverToBoxAdapter(
              child: _buildAppBar(),
            ),

            // Search Bar
            SliverToBoxAdapter(
              child: CustomSearchBar(
                // Changed from SearchBar to CustomSearchBar
                controller: _searchController,
                onFilterTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => FilterDialog(
                      initialFilters: _activeFilters,
                      onApplyFilters: (filters) {
                        setState(() {
                          _activeFilters = filters;
                        });
                        // Apply the filters to your data
                        _applyFilters();
                      },
                    ),
                  );
                },
              ),
            ),

            // Promotional Banner
            SliverToBoxAdapter(
              child: PromotionalBanner(
                imageUrl:
                    'https://images.pexels.com/photos/1640772/pexels-photo-1640772.jpeg',
                promoText: 'PROMO',
                discountText: '50% OFF',
                subtitleText: 'On your first order',
              ),
            ),

            // Category Tabs
            SliverToBoxAdapter(
              child: _buildCategoryTabs(),
            ),

            // Popular Restaurants
            SliverToBoxAdapter(
              child: _buildPopularRestaurants(),
            ),

            // Popular Food Items
            SliverToBoxAdapter(
              child: _buildPopularFoodItems(),
            ),
          ],
        ),
      ),
      extendBody: true, // This allows content to go behind the bottom nav bar
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
          // More explicit navigation handling
          switch (index) {
            case 0: // Home
              // Already on home screen, no need to navigate
              break;
            case 1: // Search
              Navigator.pushNamed(context, '/search');
              break;
            case 2: // Cart
              Navigator.pushNamed(context, '/cart');
              break;
            case 3: // Profile
              Navigator.pushNamed(context, '/profile');
              break;
          }
        },
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Delivering to',
                style: GoogleFonts.poppins(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
              ),
              Row(
                children: [
                  Text(
                    'Current Location',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.red[700],
                    size: 20,
                  ),
                ],
              ),
            ],
          ),
          // Removed profile icon, kept only notification icon
          GestureDetector(
            onTap: () {
              _showNotificationsDialog(context);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.notifications_none_outlined,
                color: Colors.grey[700],
                size: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Add this method to handle notification icon tap
  void _showNotificationsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Notifications',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView(
              shrinkWrap: true,
              children: [
                _buildNotificationItem(
                  'Order #1234 has been delivered',
                  'Your order from Mama\'s Kitchen has been delivered.',
                  '10 mins ago',
                ),
                _buildNotificationItem(
                  'Special Offer!',
                  'Get 20% off on your next order with code QUICK20',
                  '2 hours ago',
                ),
                _buildNotificationItem(
                  'Order Confirmed',
                  'Your order #1234 has been confirmed and is being prepared.',
                  '1 day ago',
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Close',
                style: GoogleFonts.poppins(
                  color: Colors.red[700],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Add this helper method to create notification items
  Widget _buildNotificationItem(String title, String message, String time) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            message,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            time,
            style: GoogleFonts.poppins(
              fontSize: 10,
              color: Colors.grey[500],
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return Padding(
      padding: const EdgeInsets.only(top: 24),
      child: Column(
        children: [
          TabBar(
            controller: _tabController,
            isScrollable: true,
            labelColor: Colors.red[700],
            unselectedLabelColor: Colors.grey[600],
            indicatorColor: Colors.red[700],
            indicatorWeight: 3,
            labelStyle: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            unselectedLabelStyle: GoogleFonts.poppins(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            tabs: const [
              Tab(text: 'All'),
              Tab(text: 'Nigerian'),
              Tab(text: 'Fast Food'),
              Tab(text: 'Chinese'),
              Tab(text: 'Desserts'),
            ],
          ),
        ],
      ),
    );
  }

  // Inside the _buildPopularRestaurants method
  Widget _buildPopularRestaurants() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 0, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Popular Restaurants',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: TextButton(
                  onPressed: () {
                    // Navigate to all restaurants
                  },
                  child: Text(
                    'See All',
                    style: GoogleFonts.poppins(
                      color: Colors.red[700],
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          
          // Restaurant list
          SizedBox(
            height: 200,
            child: _isLoading 
              ? const Center(child: CircularProgressIndicator())
              : ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _restaurants.length,
                  itemBuilder: (context, index) {
                    final restaurant = _restaurants[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => RestaurantDetailsScreen(),
                              settings: RouteSettings(arguments: restaurant),
                            ),
                          );
                        },
                        child: RestaurantCard(
                          name: restaurant['name'],
                          cuisine: restaurant['cuisine'],
                          rating: restaurant['rating'],
                          deliveryTime: restaurant['deliveryTime'],
                          imageUrl: restaurant['imageUrl'],
                        ),
                      ),
                    );
                  },
                ),
          ),
        ],
      ),
    );
  }

  Widget _buildRestaurants() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
          child: Text(
            'Popular Restaurants',
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 220,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 8, 0, 8),
            scrollDirection: Axis.horizontal,
            children: [
              RestaurantCard(
                name: "Mama's Kitchen",
                cuisine: 'Nigerian',
                rating: 4.8,
                deliveryTime: '25-35 min',
                imageUrl:
                    'https://images.pexels.com/photos/5560763/pexels-photo-5560763.jpeg',
              ),
              RestaurantCard(
                name: 'Chicken Republic',
                cuisine: 'Fast Food',
                rating: 4.5,
                deliveryTime: '15-25 min',
                imageUrl:
                    'https://images.pexels.com/photos/2983101/pexels-photo-2983101.jpeg',
              ),
              RestaurantCard(
                name: 'Golden Dragon',
                cuisine: 'Chinese',
                rating: 4.7,
                deliveryTime: '30-40 min',
                imageUrl:
                    'https://images.pexels.com/photos/2347311/pexels-photo-2347311.jpeg',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRestaurantCard(
    String name,
    String cuisine,
    double rating,
    String deliveryTime,
    String imageUrl,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/restaurant_details',
          arguments: {
            'restaurantName': name,
            'imageUrl': imageUrl,
          },
        );
      },
      child: Container(
        width: 260,
        margin: const EdgeInsets.only(right: 16),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Restaurant Image
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  child: Image.network(
                    imageUrl,
                    height: 130,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 130,
                      color: Colors.grey[300],
                      child: Center(
                        child: Icon(Icons.restaurant,
                            color: Colors.grey[400], size: 40),
                      ),
                    ),
                  ),
                ),
                // Rating badge
                Positioned(
                  top: 8,
                  right: 8,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 16),
                        const SizedBox(width: 4),
                        Text(
                          rating.toString(),
                          style: GoogleFonts.poppins(
                            color: Colors.black87,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            // Restaurant Info
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        cuisine,
                        style: GoogleFonts.poppins(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        height: 4,
                        width: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[400],
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        deliveryTime,
                        style: GoogleFonts.poppins(
                          color: Colors.grey[600],
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularFoodItems() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Popular Food',
                style: GoogleFonts.poppins(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  // Navigate to all food items
                },
                child: Text(
                  'See All',
                  style: GoogleFonts.poppins(
                    color: Colors.red[700],
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          // Show loading indicator while data is loading
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
              ),
            )
          // Show message when no items match the filter
          else if (_filteredFoodItems.isEmpty)
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Icon(
                    Icons.search_off,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No items match your filters',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _activeFilters = {};
                      });
                      _applyFilters();
                    },
                    child: Text(
                      'Clear Filters',
                      style: GoogleFonts.poppins(
                        color: Colors.red[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            )
          // Show the grid of food items
          else
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: _filteredFoodItems.length,
              itemBuilder: (context, index) {
                final item = _filteredFoodItems[index];
                // Inside _buildPopularFoodItems method, replace the onTap in FoodItemCard
                return FoodItemCard(
                  name: item['name'],
                  restaurant: item['restaurant'],
                  price: item['price'],
                  imageUrl: item['imageUrl'],
                  rating: item['rating'],
                  onTap: () {
                    _navigateToFoodDetails(context, item);
                  },
                  onAddToCart: () {
                    // Add to cart logic
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '${item['name']} added to cart!',
                          style: GoogleFonts.poppins(),
                        ),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                );
              },
            ),
        ],
      ),
    );
  }

  // Add these methods properly inside the class, not as loose code
  void _navigateToFoodDetails(BuildContext context, Map<String, dynamic> foodItem) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FoodDetailsScreen(),
        settings: RouteSettings(arguments: foodItem),
      ),
    );
  }

  void _navigateToRestaurantDetails(BuildContext context, Map<String, dynamic> restaurant) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RestaurantDetailsScreen(),
        settings: RouteSettings(arguments: restaurant),
      ),
    );
  }
}
