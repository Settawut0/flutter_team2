class TextUser{
  String userid='';
  static final TextUser id=TextUser._internal();
  factory TextUser(){
    return id;

  }
  TextUser._internal();
}
