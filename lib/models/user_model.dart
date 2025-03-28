class UserModel {
  String fullName;
  String lastName;
  String email;
  String password;
  String age;
  String gender; // Varsayılan değer kaldırıldı!

  UserModel({
    required this.fullName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.gender, // Cinsiyet artık zorunlu bir alan!
    this.age = "",
  });

  Map<String, dynamic> toMap() {
    return {
      "fullName": fullName,
      "lastName": lastName,
      "email": email,
      "password": password,
      "age": age,
      "gender": gender, // Gender artık null olamaz!
    };
  }
}
