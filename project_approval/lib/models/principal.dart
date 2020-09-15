class Principal {
  final String id;
  final String userType;
  final String name;
  final String email;
  final String password;
  final String profileImage;
  final String phone;
  final String designation;

  Principal({
    this.id,
    this.userType,
    this.name,
    this.email,
    this.password,
    this.profileImage,
    this.phone,
    this.designation,
  });

  @override
  String toString() {
    return 'Principal{id: $id, userType: $userType, name: $name, email: $email, password: $password, profileImage: $profileImage, phone: $phone, designation: $designation}';
  }
}
