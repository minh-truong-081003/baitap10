class UserModel {
  final String? id;
  final String? email;
  final String? fullname;
  final String? phone;
  final String? photoUrl;
  final String? role;
  final String? dateOfBirth;
  final String? gender;

  UserModel({
    this.id,
    this.email,
    this.fullname,
    this.phone,
    this.photoUrl,
    this.role,
    this.dateOfBirth,
    this.gender,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'],
      email: json['email'],
      fullname: json['fullname'],
      phone: json['phone'],
      photoUrl: json['photoUrl'],
      role: json['role'],
      dateOfBirth: json['date_of_birth'],
      gender: json['gender'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'email': email,
      'fullname': fullname,
      'phone': phone,
      'photoUrl': photoUrl,
      'role': role,
      'date_of_birth': dateOfBirth,
      'gender': gender,
    };
  }
} 