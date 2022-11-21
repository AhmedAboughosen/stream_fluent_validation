import 'package:flutter/material.dart';
import 'package:stream_fluent_validation/fluent_validation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}
var loginController = LoginController();

class LoginController {
  final LoginValidation loginValidation = LoginValidation();

  void login() {
    if (!loginValidation.validate()) {
      print("you can not login");
      return;
    }
    print("your login succeed ");
  }
}

class LoginValidation extends AbstractValidator<LoginValidation> {
  StreamValidator<String> email = StreamValidator<String>();
  StreamValidator<String> password = StreamValidator<String>();

  LoginValidation() {
    ruleFor((e) => (e as LoginValidation).email)
        .notEmpty()
        .withMessage("email should not be empty")
        .emailAddress()
        .withMessage("email should be valid !!.");

    ruleFor((e) => (e as LoginValidation).password)
        .length(3, 4)
        .withMessage("password  should contain from 3 to 4 digit  !!.");
  }
}

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
            EmailInput(),
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
