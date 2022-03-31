class LoginModel{
  late String email;
  late String password;

  LoginModel( this.email, this.password);

  Map<String,dynamic>toMap(){
    return {
      "email":email,
      "password":password,
    };
  }
}