import 'dart:async';
import '../models/payment_method.dart'; // Import the model

class PaymentService {
  // In a real app, this would connect to a backend service
  // For demo purposes, we'll use a mock implementation
  
  Future<List<PaymentMethod>> getUserPaymentMethods() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    
    // Return mock payment methods
    return [
      PaymentMethod(
        id: '1',
        name: 'Credit Card',
        type: 'card',
        details: '**** **** **** 4242',
        isDefault: true,
      ),
      PaymentMethod(
        id: '2',
        name: 'PayPal',
        type: 'paypal',
        details: 'user@example.com',
      ),
      PaymentMethod(
        id: '3',
        name: 'Cash on Delivery',
        type: 'cash',
        details: 'Pay when you receive your order',  // Added the missing required parameter
      ),
    ];
  }

  Future<PaymentMethod> addPaymentMethod(PaymentMethod method) async {
    // In a real app, this would send the payment method to a backend
    // For demo purposes, we'll just return the method with an ID
    await Future.delayed(const Duration(milliseconds: 800));
    
    return method.copyWith(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
    );
  }

  Future<void> deletePaymentMethod(String id) async {
    // In a real app, this would delete the payment method from a backend
    // For demo purposes, we'll just simulate a delay
    await Future.delayed(const Duration(milliseconds: 800));
  }

  // Add this method to remove a payment method
  Future<bool> removePaymentMethod(String id) async {
    try {
      // Here you would typically make an API call to remove the payment method
      // For now, we'll simulate a successful removal
      await Future.delayed(const Duration(seconds: 1));
      return true;
    } catch (e) {
      print('Error removing payment method: $e');
      return false;
    }
  }

  // Also add this method for setting default payment method
  Future<bool> setDefaultPaymentMethod(String id) async {
    try {
      // Here you would typically make an API call to set the default payment method
      // For now, we'll simulate a successful update
      await Future.delayed(const Duration(seconds: 1));
      return true;
    } catch (e) {
      print('Error setting default payment method: $e');
      return false;
    }
  }
}