import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_management/domain/model/login_user.dart';
import 'package:project_management/application/service/auth_service.dart';
import 'presentation/screen/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<LoginUser>.value(
      value: AuthService().loginUser,
      initialData: LoginUser(uid: null),
      child: const MaterialApp(
        localizationsDelegates: [
          FormBuilderLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        // supportedLocales:FormBuilderLocalizations.delegate.supportedLocales,

        home: Wrapper(),
      ),
    );
  }
}
