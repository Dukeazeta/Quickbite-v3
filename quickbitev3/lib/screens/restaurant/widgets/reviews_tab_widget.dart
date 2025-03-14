import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewsTabWidget extends StatelessWidget {
  const ReviewsTabWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildReviewSummary(),
        const SizedBox(height: 24),
        _buildReviewCard(
          'Adebayo Johnson',
          'https://randomuser.me/api/portraits/men/12.jpg',
          5.0,
          'The jollof rice was absolutely delicious! Perfect spice level and the chicken was tender. Service was also excellent.',
          '2 days ago',
        ),
        _buildReviewCard(
          'Chioma Okafor',
          'https://randomuser.me/api/portraits/women/32.jpg',
          4.0,
          'Great food and atmosphere. The egusi soup was prepared perfectly. Only giving 4 stars because the delivery took a bit longer than expected.',
          '1 week ago',
        ),
        _buildReviewCard(
          'Ngozi Williams',
          'https://randomuser.me/api/portraits/women/45.jpg',
          4.5,
          'Ordered the puff puff and it was heavenly! Will definitely order again. The packaging was also very secure.',
          '2 weeks ago',
        ),
        _buildReviewCard(
          'Emeka Obi',
          'https://randomuser.me/api/portraits/men/57.jpg',
          5.0,
          'Outstanding service and food quality. The pepper soup was exceptional. Highly recommend this restaurant!',
          '3 weeks ago',
        ),
      ],
    );
  }

  Widget _buildReviewSummary() {
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
        children: [
          Row(
            children: [
              Column(
                children: [
                  Text(
                    '4.5',
                    style: GoogleFonts.poppins(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  RatingBar.builder(
                    initialRating: 4.5,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemSize: 18,
                    ignoreGestures: true,
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (rating) {},
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '328 reviews',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  children: [
                    _buildRatingBar(5, 0.7),
                    _buildRatingBar(4, 0.2),
                    _buildRatingBar(3, 0.05),
                    _buildRatingBar(2, 0.03),
                    _buildRatingBar(1, 0.02),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {},
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
            child: Text(
              'Write a Review',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingBar(int rating, double percentage) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text(
            '$rating',
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(width: 4),
          Icon(Icons.star, color: Colors.amber, size: 14),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: percentage,
                backgroundColor: Colors.grey[200],
                color: Colors.amber,
                minHeight: 8,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildReviewCard(
    String name,
    String imageUrl,
    double rating,
    String comment,
    String time,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
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
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(imageUrl),
                onBackgroundImageError: (exception, stackTrace) {},
                backgroundColor: Colors.grey[300],
                child: Icon(Icons.person, color: Colors.grey[400]),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      time,
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.green[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Icon(Icons.star, color: Colors.green[700], size: 14),
                    const SizedBox(width: 4),
                    Text(
                      rating.toStringAsFixed(1),
                      style: GoogleFonts.poppins(
                        color: Colors.green[700],
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            comment,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _buildReactionButton(Icons.thumb_up_outlined, 'Helpful (12)'),
              const SizedBox(width: 16),
              _buildReactionButton(Icons.comment_outlined, 'Comment'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildReactionButton(IconData icon, String label) {
    return InkWell(
      onTap: () {},
      child: Row(
        children: [
          Icon(icon, color: Colors.grey[600], size: 16),
          const SizedBox(width: 4),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}