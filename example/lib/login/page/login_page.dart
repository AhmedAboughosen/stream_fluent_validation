import 'package:flutter/material.dart';

import '../controller/login_controller.dart';

var loginController = LoginController();

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: Column(
          children: const [
            SizedBox(
              height: 30,
            ),
            EmailInput(
            ),
            SizedBox(
              height: 30,
            ),
            PasswordInput(),
            SizedBox(
              height: 30,
            ),
            SubmitButton()
          ],
        ));
  }
}

class EmailInput extends StatelessWidget {
  const EmailInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => StreamBuilder(
        stream: loginController.loginValidation.email.stream,
        builder: (context, snap) {
          return TextField(
            keyboardType: TextInputType.emailAddress,
            onChanged: loginController.loginValidation.email.valueChange,
            decoration: InputDecoration(
                labelText: "Email address",
                hintText: "you@example.com",
                errorText: snap.hasError ? "${snap.error}" : null),
          );
        },
      );
}

class PasswordInput extends StatelessWidget {
  const PasswordInput({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => StreamBuilder(
        stream: loginController.loginValidation.password.stream,
        builder: (context, snap) {
          return TextField(
            keyboardType: TextInputType.number,
            onChanged: loginController.loginValidation.password.valueChange,
            obscureText: true,
            decoration: InputDecoration(
                labelText: "Password",
                hintText: "******",
                errorText: snap.hasError ? "${snap.error}" : null),
          );
        },
      );
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
        loginController.login();
      },
      color: Colors.blue,
      child: const Text(
        "Login",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}