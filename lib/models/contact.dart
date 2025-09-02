class ContactModel {
  final String name;
  final String phone;

  ContactModel({required this.name, required this.phone});

  Map<String, dynamic> toJson() {
    return {"name": name, "phone": phone};
  }
}
