import 'package:flutter/material.dart';
import 'package:project_management/domain/model/login_user.dart';
import 'package:project_management/presentation/screen/authenticate/authenticate.dart';
import 'package:project_management/presentation/screen/home/home.dart';
import 'package:project_management/application/service/auth_service.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  AuthService authService = AuthService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<LoginUser>(context);
    if (user.uid != null) {
      return Home();
    } else {
      return const Authenticate();
    }
  }
}
