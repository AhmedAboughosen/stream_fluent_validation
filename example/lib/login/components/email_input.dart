// import 'package:flutter/material.dart';
// import 'package:flutter_clean_architecture_rx/core/domain/blocs/login/login_bloc.dart';
// import 'package:form_bloc_version/src/bloc_builder.dart';
//
// class EmailInput extends StatelessWidget {
//   const EmailInput({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) => BlocBuilder<String>(
//     build: (context,state){
//       return Container();
//     },
//
//         // stream: (BlocProvider.of<LoginBloc>(context)).loginValidation.email.stream,
//         // builder: (context, snap) {
//         //   return TextField(
//         //     keyboardType: TextInputType.emailAddress,
//         //     onChanged:
//         //     (BlocProvider.of<LoginBloc>(context)).loginValidation.email.valueChange,
//         //     decoration: InputDecoration(
//         //         labelText: "Email address",
//         //         hintText: "you@example.com",
//         //         errorText: snap.hasError ? "${snap.error}" : null),
//         //   );
//         // },
//       );
// }
