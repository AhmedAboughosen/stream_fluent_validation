import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_rx/core/domain/blocs/login/login_bloc.dart';

import 'package:form_bloc_version/src/bloc_provider.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      onPressed: () {
       BlocProvider.of<LoginBloc>(context).login();
      },
      color: Colors.blue,
      child: const Text(
        "Login",
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
