import 'dart:async';

mixin Validation {
  final nameValidate =
  StreamTransformer<String, String>.fromHandlers(handleData: (value, sink) {
    if (value.isEmpty) {
      sink.addError("Please enter name");
    } else if (value.length < 5) {
      sink.addError("name should be more than 5 letters");
    } else {
      sink.add(value);
    }
  });
  final emailValidate =
  StreamTransformer<String, String>.fromHandlers(handleData:( value,sink) {
  if (value.isEmpty) {
  sink.addError("Please enter email");
  } else if (!RegExp(
  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(value)){
  sink.addError("Please enter valid email id");
  }
  else {
    sink.add(value);
  }
  });

  final passwordValidate = StreamTransformer<String, String>.fromHandlers(
  handleData: (value, sink) {
    if (value.isEmpty){
      sink.addError("Please enter password");
    }else if (value.length<6){
      sink.addError("password should be more than 6 digits");
    } else{
      sink.add(value);
    }
  });




  final confirmPassValidate = StreamTransformer<String, String>.fromHandlers(
  handleData: (value, sink) {});
  }
