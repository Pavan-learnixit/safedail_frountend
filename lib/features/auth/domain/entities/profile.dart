class Profile {
  final String name;
  final String email;
  final String phone;

  Profile({required this.name, required this.email, required this.phone});

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {"name": name, "email": email, "phone": phone};
  }
}
