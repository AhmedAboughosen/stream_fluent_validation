// import 'package:flutter/material.dart';
//
// import '../controller/change_pin_controller.dart';
//
// var changePinController = ChangePinController();
//
// class ChangePinPage extends StatelessWidget {
//   const ChangePinPage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(),
//         body: Column(
//           children: const [
//             SizedBox(
//               height: 30,
//             ),
//             NewPinInput(
//             ),
//             SizedBox(
//               height: 30,
//             ),
//             ConfirmPinInput(),
//             SizedBox(
//               height: 30,
//             ),
//             SubmitButton()
//           ],
//         ));
//   }
// }
//
// class NewPinInput extends StatelessWidget {
//   const NewPinInput({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) => StreamBuilder(
//         stream: changePinController.changePinValidation.newPin.stream,
//         builder: (context, snap) {
//           return TextField(
//             keyboardType: TextInputType.number,
//             onChanged: changePinController.changePinValidation.newPin.valueChange,
//             decoration: InputDecoration(
//                 labelText: "new Pin",
//                 hintText: "****",
//                 errorText: snap.hasError ? "${snap.error}" : null),
//           );
//         },
//       );
// }
//
// class ConfirmPinInput extends StatelessWidget {
//   const ConfirmPinInput({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) => StreamBuilder(
//         stream: changePinController.changePinValidation.confirmPin.stream,
//         builder: (context, snap) {
//           return TextField(
//             keyboardType: TextInputType.number,
//             onChanged: changePinController.changePinValidation.confirmPin.valueChange,
//             decoration: InputDecoration(
//                 labelText: "confirm Pin",
//                 hintText: "******",
//                 errorText: snap.hasError ? "${snap.error}" : null),
//           );
//         },
//       );
// }
//
// class SubmitButton extends StatelessWidget {
//   const SubmitButton({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return RaisedButton(
//       onPressed: () {
//         changePinController.changePin();
//       },
//       color: Colors.blue,
//       child: const Text(
//         "Login",
//         style: TextStyle(color: Colors.white),
//       ),
//     );
//   }
// }
