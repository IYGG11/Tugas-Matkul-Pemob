// Model Admin: representasi satu data admin dari endpoint /admins
class Admin {
  final int id;
  final String name;
  final String email;
  final String department;

  Admin({
    required this.id,
    required this.name,
    required this.email,
    required this.department,
  });

  // fromJson: mengubah Map (hasil jsonDecode dari API) menjadi objek Admin
  factory Admin.fromJson(Map<String, dynamic> json) {
    return Admin(
      id: json['id'],
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      department: json['department'] ?? '',
    );
  }

  // toJson: mengubah objek Admin menjadi Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'department': department,
    };
  }
}
