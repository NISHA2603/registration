import 'dart:async';
import 'package:rxdart/rxdart.dart';

import 'package:registration/services/validation.dart';

class LoginValidationStreams with Validation {
  final _nameContr = BehaviorSubject<String>();
  final _emailContr = BehaviorSubject<String>();
  final _passwordContr = BehaviorSubject<String>();
  final _confirmPassContr = BehaviorSubject<String>();

  void setName(String name) => _nameContr.sink.add(name);

  void setEmail(String email) => _emailContr.sink.add(email);

  void setPassword(String password) => _passwordContr.sink.add(password);

  void setConfirmPass(String confirmPass) =>
      _confirmPassContr.sink.add(confirmPass);

  Stream<String> get name => _nameContr.stream.transform(nameValidate);

  Stream<String> get email => _emailContr.stream.transform(emailValidate);

  Stream<String> get password =>
      _passwordContr.stream.transform(passwordValidate);

  Stream<String> get confirmPass =>
      _confirmPassContr.stream.transform(passwordValidate).doOnData((String c) {
        if (0 != _passwordContr.stream.value.compareTo(c)) {
          _confirmPassContr.addError("password do not match");
        }
      });

  Stream<bool> get isFormValid$ => CombineLatestStream.combine3(
          _nameContr.stream, _emailContr.stream, _confirmPassContr.stream,
          (name, email, confirmPass) {
        if (name == _nameContr.stream &&
            email == _emailContr.stream &&
            confirmPass == _confirmPassContr.stream) {
          return true;
        } else {
          return false;
        }
      });
}
