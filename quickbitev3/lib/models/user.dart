class User {
  final String id;
  final String name;
  final String email;
  final String? phone;
  final String? profilePicture;

  User({
    required this.id,
    required this.name,
    required this.email,
    this.phone,
    this.profilePicture,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      profilePicture: json['profilePicture'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'profilePicture': profilePicture,
    };
  }
}