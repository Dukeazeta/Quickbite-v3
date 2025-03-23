import 'dart:async';
import '../models/address.dart';

class AddressService {
  // In a real app, this would connect to a backend service
  // For demo purposes, we'll use a mock implementation
  
  Future<List<Address>> getUserAddresses() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 800));
    
    // Return mock addresses
    return [
      Address(
        id: '1',
        label: 'Home',
        street: '123 Main Street',
        city: 'Lagos',
        state: 'Lagos State',
        country: 'Nigeria',
        postalCode: '100001',
        isDefault: true,
        additionalInfo: 'Gate with blue door',
      ),
      Address(
        id: '2',
        label: 'Work',
        street: '456 Office Avenue',
        city: 'Lagos',
        state: 'Lagos State',
        country: 'Nigeria',
        postalCode: '100002',
        isDefault: false,
      ),
      Address(
        id: '3',
        label: 'School',
        street: '789 Campus Road',
        city: 'Lagos',
        state: 'Lagos State',
        country: 'Nigeria',
        postalCode: '100003',
        isDefault: false,
        additionalInfo: 'Near the main library',
      ),
    ];
  }

  Future<Address> getAddressById(String id) async {
    final addresses = await getUserAddresses();
    return addresses.firstWhere(
      (address) => address.id == id,
      orElse: () => throw Exception('Address not found'),
    );
  }

  Future<Address> addAddress(Address address) async {
    // In a real app, this would send the address to a backend
    // For demo purposes, we'll just return the address with an ID
    await Future.delayed(const Duration(milliseconds: 800));
    
    return address.copyWith(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
    );
  }

  Future<Address> updateAddress(Address address) async {
    // In a real app, this would update the address in a backend
    // For demo purposes, we'll just return the address
    await Future.delayed(const Duration(milliseconds: 800));
    
    return address;
  }

  Future<void> deleteAddress(String id) async {
    // In a real app, this would delete the address from a backend
    // For demo purposes, we'll just simulate a delay
    await Future.delayed(const Duration(milliseconds: 800));
  }

  Future<void> setDefaultAddress(String id) async {
    // In a real app, this would update the default address in a backend
    // For demo purposes, we'll just simulate a delay
    await Future.delayed(const Duration(milliseconds: 800));
  }
}