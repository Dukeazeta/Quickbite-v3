class User {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? profilePicture;
  final List<String>? favoriteItems;
  final List<String>? favoriteRestaurants;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.profilePicture,
    this.favoriteItems,
    this.favoriteRestaurants,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      profilePicture: json['profilePicture'],
      favoriteItems: json['favoriteItems'] != null 
          ? List<String>.from(json['favoriteItems']) 
          : null,
      favoriteRestaurants: json['favoriteRestaurants'] != null 
          ? List<String>.from(json['favoriteRestaurants']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'profilePicture': profilePicture,
      'favoriteItems': favoriteItems,
      'favoriteRestaurants': favoriteRestaurants,
    };
  }

  User copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? profilePicture,
    List<String>? favoriteItems,
    List<String>? favoriteRestaurants,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profilePicture: profilePicture ?? this.profilePicture,
      favoriteItems: favoriteItems ?? this.favoriteItems,
      favoriteRestaurants: favoriteRestaurants ?? this.favoriteRestaurants,
    );
  }
}