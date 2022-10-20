import 'package:flutter/material.dart';
import 'package:project_management/presentation/screen/authenticate/sign_in.dart';
import 'package:project_management/presentation/screen/authenticate/register.dart';

// class Authenticate extends StatelessWidget {
//   bool signIn = true;

//   void toggleForms() {
//     setState(() => signIn = !signIn);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return const Scaffold(
//       body: Register(),
//     );
//   }
// }

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key}) : super(key: key);

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool signIn = true;

  void toggleForms() {
    setState(() => signIn = !signIn);
  }

  @override
  Widget build(BuildContext context) {
    if (signIn) {
      return SignIn(toggleForms: toggleForms);
    } else {
      return Register(toggleForms: toggleForms);
    }
  }
}
