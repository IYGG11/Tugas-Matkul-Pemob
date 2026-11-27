// Model User: representasi satu data user dari endpoint /users
class User {
  final int id;
  final String name;
  final String email;
  final String city;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.city,
  });

  // fromJson: mengubah Map (hasil jsonDecode dari API) menjadi objek User
  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      city: json['city'] ?? '',
    );
  }

  // toJson: mengubah objek User menjadi Map untuk dikirim ke API (POST/PUT)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'city': city,
    };
  }
}
