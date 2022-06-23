import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:registration/screens/home.dart';
import 'package:registration/services/streams.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  var name = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  var confirmPass = TextEditingController();

  late bool _passwordVisible = false;
  var obj = LoginValidationStreams();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login Form"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                children: [
                  StreamBuilder(
                      stream: obj.name,
                      builder: (context, snapshot) {
                        return Column(
                          children: [
                            TextFormField(
                              onChanged: (name) => obj.setName(name),
                              controller: name,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.perm_identity_outlined),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                labelText: "Enter your Name",
                                hintText: "Enter your first name and last name",
                              ),
                            ),
                            if (snapshot.hasError)
                              Text(snapshot.error.toString())
                          ],
                        );
                      }),
                  SizedBox(height: 10),
                  StreamBuilder(
                      stream: obj.email,
                      builder: (context, snapshot) {
                        return Column(children: [
                          TextFormField(
                            onChanged: (email) => obj.setEmail(email),
                            controller: email,
                            validator: (val) {
                              if (!RegExp(
                                      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                  .hasMatch(val!)) {
                                return "Invalid Email";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                                prefixIcon: Icon(Icons.email),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                labelText: "   Email",
                                hintText: "Enter your proper mail id"),
                          ),
                          if (snapshot.hasError) Text(snapshot.error.toString())
                        ]);
                      }),
                  SizedBox(height: 10),
                  StreamBuilder(
                      stream: obj.password,
                      builder: (context, snapshot) {
                        return Column(
                          children: [
                            TextFormField(
                              onChanged: (password) =>
                                  obj.setPassword(password),
                              controller: password,
                              obscureText: !_passwordVisible,
                              // validator: MinLengthValidator(6,
                              //     errorText: "Should be At least 6 Digits Length"),
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.password),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  labelText: "Enter your Password",
                                  hintText: "Enter your proper password",
                                  suffixIcon: IconButton(
                                    icon: Icon(_passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                  )),
                            ),
                            if (snapshot.hasError)
                              Text(snapshot.error.toString())
                          ],
                        );
                      }),
                  SizedBox(height: 10),
                  StreamBuilder(
                      stream: obj.confirmPass,
                      builder: (context, snapshot) {
                        return Column(
                          children: [
                            TextFormField(
                              onChanged: (confirmPass) =>
                                  obj.setConfirmPass(confirmPass),
                              controller: confirmPass,
                              obscureText: true,
                              // validator: (val) {
                              //   if (val != password.text) {
                              //     return "Invalid password";
                              //   } else {
                              //     return "valid Password";
                              //   }
                              // },
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.password),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                labelText: "Confirm your Password",
                                hintText: "Enter your proper password",
                              ),
                            ),
                            if (snapshot.hasError)
                              Text(snapshot.error.toString())
                          ],
                        );
                      }),
                  SizedBox(height: 30),
                  StreamBuilder(
                    stream: obj.isFormValid$,
                    builder: (context,AsyncSnapshot<bool> snapshot) {
                      print(snapshot.data);
                      return ElevatedButton(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.white)),
                          onPressed: snapshot.data==true?(){
                            Get.to(Home());
                          }:null,
                          child: Text(
                            "Submit",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ));
                    }
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
