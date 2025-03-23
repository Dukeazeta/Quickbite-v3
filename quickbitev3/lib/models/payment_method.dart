class PaymentMethod {
  final String id;
  final String name;
  final String type;
  final String details;
  final bool isDefault;
  final String? icon;
  final String? lastFour;

  PaymentMethod({
    required this.id,
    required this.name,
    required this.type,
    required this.details,
    this.isDefault = false,
    this.icon,
    this.lastFour,
  });

  // Add a getter for title that returns the name
  String get title => name;

  // Add a copyWith method for creating copies with modified fields
  PaymentMethod copyWith({
    String? id,
    String? name,
    String? type,
    String? details,
    bool? isDefault,
    String? icon,
    String? lastFour,
  }) {
    return PaymentMethod(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      details: details ?? this.details,
      isDefault: isDefault ?? this.isDefault,
      icon: icon ?? this.icon,
      lastFour: lastFour ?? this.lastFour,
    );
  }
}