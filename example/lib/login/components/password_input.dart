// import 'package:flutter/material.dart';
// import 'package:flutter_clean_architecture_rx/core/domain/blocs/login/login_bloc.dart';
//
// import '../../../shared/components/bloc_provider.dart';
//
// class PasswordInput extends StatelessWidget {
//   const PasswordInput({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) => StreamBuilder(
//     stream: (BlocProvider.of<LoginBloc>(context)).loginValidation.password.stream,
//     builder: (context, snap) {
//       return TextField(
//         keyboardType: TextInputType.visiblePassword,
//         onChanged:
//         (BlocProvider.of<LoginBloc>(context)).loginValidation.password.valueChange,
//         decoration: InputDecoration(
//             labelText: "Password",
//             hintText: "******",
//             errorText: snap.hasError ? "${snap.error}" : null),
//       );
//     },
//   );
// }
