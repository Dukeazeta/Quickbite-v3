import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../models/order.dart';

class OrderStatusTimeline extends StatelessWidget {
  final String currentStatus;
  final List<StatusUpdate> statusUpdates;

  const OrderStatusTimeline({
    Key? key,
    required this.currentStatus,
    required this.statusUpdates,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Sort updates by timestamp
    final sortedUpdates = List<StatusUpdate>.from(statusUpdates)
      ..sort((a, b) => b.timestamp.compareTo(a.timestamp));

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: List.generate(sortedUpdates.length, (index) {
          final update = sortedUpdates[index];
          final isLast = index == sortedUpdates.length - 1;
          
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Status indicator and line
              Column(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                      color: update.status == currentStatus
                          ? Colors.red[700]
                          : Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                    child: update.status == currentStatus
                        ? const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 12,
                          )
                        : null,
                  ),
                  if (!isLast)
                    Container(
                      width: 2,
                      height: 50,
                      color: Colors.grey[300],
                    ),
                ],
              ),
              
              // Status details
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, bottom: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            update.status,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              color: update.status == currentStatus
                                  ? Colors.red[700]
                                  : Colors.black,
                            ),
                          ),
                          Text(
                            DateFormat('hh:mm a').format(update.timestamp),
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                      if (update.message != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            update.message!,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.grey[600],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}