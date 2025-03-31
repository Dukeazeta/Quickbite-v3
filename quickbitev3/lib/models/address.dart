
class Address {
  final String id;
  final String label;
  final String street;
  final String city;
  final String state;
  final String country;
  final String postalCode;
  final bool isDefault;
  final String? additionalInfo;

  Address({
    required this.id,
    required this.label,
    required this.street,
    required this.city,
    required this.state,
    required this.country,
    required this.postalCode,
    this.isDefault = false,
    this.additionalInfo,
  });

  String get formattedAddress {
    return '$street, $city, $state, $country${postalCode.isNotEmpty ? ', $postalCode' : ''}';
  }

  Address copyWith({
    String? id,
    String? label,
    String? street,
    String? city,
    String? state,
    String? country,
    String? postalCode,
    bool? isDefault,
    String? additionalInfo,
  }) {
    return Address(
      id: id ?? this.id,
      label: label ?? this.label,
      street: street ?? this.street,
      city: city ?? this.city,
      state: state ?? this.state,
      country: country ?? this.country,
      postalCode: postalCode ?? this.postalCode,
      isDefault: isDefault ?? this.isDefault,
      additionalInfo: additionalInfo ?? this.additionalInfo,
    );
  }
}
