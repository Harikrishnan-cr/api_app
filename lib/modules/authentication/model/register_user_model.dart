class RegisterUserModel {
  String? fullName;
  String? email;
  String? phone;
  String? countryCode;
  String? password;
  String? firebaseId;

  RegisterUserModel(
      {this.fullName,
      this.email,
      this.phone,
      this.countryCode,
      this.password,
      this.firebaseId});
}
