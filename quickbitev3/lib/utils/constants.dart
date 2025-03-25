class AppConstants {
  static const String currencySymbol = '₦';
  
  // Conversion rate from USD to Naira (example rate)
  static const double usdToNairaRate = 1550.0;
  
  // Helper method to convert USD to Naira
  static double convertUsdToNaira(double usdAmount) {
    return usdAmount * usdToNairaRate;
  }
  
  // Format price with Naira symbol
  static String formatNairaPrice(double amount) {
    // Format with commas for thousands
    final formattedAmount = amount.toStringAsFixed(0);
    return '$currencySymbol$formattedAmount';
  }
  
  // Convert USD price and format with Naira symbol
  static String convertAndFormatPrice(double usdAmount) {
    final nairaAmount = convertUsdToNaira(usdAmount);
    return formatNairaPrice(nairaAmount);
  }
}
