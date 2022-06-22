import 'dart:async';

import 'package:registration/services/validation.dart';

class LoginValidationStreams with Validation {
  final _nameContr = StreamController<String>.broadcast();
  final _emailContr = StreamController<String>.broadcast();
  final _passwordContr = StreamController<String>.broadcast();
  final _confirmPassContr = StreamController<String>.broadcast();

  void setName(String name) => _nameContr.sink.add(name);
  void setEmail(String email) => _emailContr.sink.add(email);
  void setPassword(String password) => _passwordContr.sink.add(password);
  void setConfirmPass(String confirmPass) => _confirmPassContr.sink.add(confirmPass);

  Stream<String> get name => _nameContr.stream.transform(nameValidate);
  Stream<String> get email => _emailContr.stream.transform(emailValidate);
  Stream<String> get password => _passwordContr.stream.transform(passwordValidate);
  Stream<String> get confirmPass => _confirmPassContr.stream.transform(confirmPassValidate);
}
