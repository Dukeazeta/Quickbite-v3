import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DeliveryMap extends StatelessWidget {
  final Map<String, double> restaurantLocation;
  final Map<String, double> deliveryLocation;
  final Map<String, double>? driverLocation;

  const DeliveryMap({
    Key? key,
    required this.restaurantLocation,
    required this.deliveryLocation,
    this.driverLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Convert Map<String, double> to LatLng
    final LatLng restaurantLatLng = LatLng(
      restaurantLocation['latitude']!,
      restaurantLocation['longitude']!,
    );
    
    final LatLng deliveryLatLng = LatLng(
      deliveryLocation['latitude']!,
      deliveryLocation['longitude']!,
    );
    
    LatLng? driverLatLng;
    if (driverLocation != null) {
      driverLatLng = LatLng(
        driverLocation!['latitude']!,
        driverLocation!['longitude']!,
      );
    }

    // Calculate the bounds to include all markers
    final bounds = _calculateBounds([
      restaurantLatLng,
      deliveryLatLng,
      if (driverLatLng != null) driverLatLng,
    ]);

    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: _calculateCenter(bounds),
        zoom: 13,
      ),
      markers: {
        // Restaurant marker
        Marker(
          markerId: const MarkerId('restaurant'),
          position: restaurantLatLng,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: const InfoWindow(title: 'Restaurant'),
        ),
        
        // Delivery location marker
        Marker(
          markerId: const MarkerId('delivery'),
          position: deliveryLatLng,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          infoWindow: const InfoWindow(title: 'Delivery Location'),
        ),
        
        // Driver marker (if available)
        if (driverLatLng != null)
          Marker(
            markerId: const MarkerId('driver'),
            position: driverLatLng,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
            infoWindow: const InfoWindow(title: 'Driver'),
          ),
      },
      polylines: {
        // Route from restaurant to delivery location
        Polyline(
          polylineId: const PolylineId('route'),
          points: [restaurantLatLng, deliveryLatLng],
          color: Colors.blue,
          width: 5,
        ),
        
        // Route from driver to delivery (if driver location available)
        if (driverLatLng != null)
          Polyline(
            polylineId: const PolylineId('driver_route'),
            points: [driverLatLng, deliveryLatLng],
            color: Colors.green,
            width: 5,
            patterns: [PatternItem.dash(20), PatternItem.gap(10)],
          ),
      },
      myLocationEnabled: false,
      compassEnabled: false,
      zoomControlsEnabled: false,
      mapToolbarEnabled: false,
    );
  }

  // Helper method to calculate bounds for all markers
  LatLngBounds _calculateBounds(List<LatLng> positions) {
    double minLat = 90.0;
    double maxLat = -90.0;
    double minLng = 180.0;
    double maxLng = -180.0;

    for (final position in positions) {
      if (position.latitude < minLat) minLat = position.latitude;
      if (position.latitude > maxLat) maxLat = position.latitude;
      if (position.longitude < minLng) minLng = position.longitude;
      if (position.longitude > maxLng) maxLng = position.longitude;
    }

    return LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );
  }

  // Helper method to calculate center of bounds
  LatLng _calculateCenter(LatLngBounds bounds) {
    return LatLng(
      (bounds.northeast.latitude + bounds.southwest.latitude) / 2,
      (bounds.northeast.longitude + bounds.southwest.longitude) / 2,
    );
  }
}