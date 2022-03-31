class RegisterModel{
  late String name;
  late String email;
  late String password;
  late String phone;

  RegisterModel(this.name, this.email, this.password, this.phone);

  Map<String,dynamic>toMap(){
    return {
      "name":name,
      "email":email,
      "password":password,
      "phone":phone
    };
  }
}