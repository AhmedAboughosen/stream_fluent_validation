import 'package:fluent_validation/fluent_validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture_rx/core/domain/blocs/login/login_bloc.dart';
import 'package:form_bloc_version/src/bloc_listener.dart';
import 'package:form_bloc_version/src/bloc_provider.dart';

import '../components/submit_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _bloc = getIt<LoginBloc>();

    return BlocProvider<LoginBloc>(
      create: _bloc,
      child: Scaffold(
          appBar: AppBar(),
          body: BlocListener(
            listener: (context, state) {
              print("state");
              print("$state");
            },
            state: _bloc.loginApi,
            bloc: _bloc,
            child: Column(
              children: const [
                // SizedBox(
                //   height: 30,
                // ),
                // EmailInput(
                // ),
                // SizedBox(
                //   height: 30,
                // ),
                // PasswordInput(),
                // SizedBox(
                //   height: 30,
                // ),
                SubmitButton()
              ],
            ),
          )),
    );
  }
}
