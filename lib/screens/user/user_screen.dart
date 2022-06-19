import 'package:cine_view/Services/CineService.dart';
import 'package:cine_view/models/User.dart';
import 'package:cine_view/screens/user/userProfile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:shared_preferences/shared_preferences.dart';

// const users = const {
//   'dribbble@gmail.com': '12345',
//   'hunter@gmail.com': 'hunter',
// };
class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final CineService _cineService = CineService();
  User? user;
  Duration get loginTime => const Duration(milliseconds: 2250);

  bool isLoggedIn = false;
  //String name = '';
  @override
  void initState() {
    super.initState();
    autoLogIn();
  }

  void autoLogIn() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('username');

    if (userId != null && userId != '') {
      debugPrint('User login Email' + userId);
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => UserProfileScreen(),
      ));
      return;
    }
  }

  Future<String?> _authUser(LoginData data) {
    debugPrint('Name: ${data.name}, Password: ${data.password}');

    return Future.delayed(loginTime).then((_) async {
      await _cineService
          .getUser(data.name, data.password)
          .then((value) => {user = value, print(value)});
      if (user == null) {
        return 'Usuario o contraseña incorrecta';
      }
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      if (user?.email != null && user?.email != '') {
        prefs.setString('username', user!.email);
      }
      // Navigator.push(BuildContext context,MaterialPageRoute(builder: (context) => const UserProfileScreen()),);
      return null;
    });
  }

  Future<String?> _signupUser(SignupData data) {
    debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) async {
      if (data.name == null && data.password == null)
        return 'Completar todos los campos';
      await _cineService
          .saveUser(data.name.toString(), data.password.toString())
          .then((value) => {user = value, print(value)});
      if (user == null) {
        return 'Registro fallido';
      }

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      if (user?.email != null && user?.email != '') {
        prefs.setString('username', user!.email);
      }

      return null;
    });
  }

  Future<String> _recoverPassword(String name) {
    debugPrint('Name: $name');
    return Future.delayed(loginTime).then((_) {
      // if (!users.containsKey(name)) {
      //   return 'User not exists';
      // }
      return '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      onLogin: _authUser,
      onSignup: _signupUser,
      messages: LoginMessages(
        loginButton: 'INICIAR SESIÓN',
        signupButton: 'REGISTRARME',
        forgotPasswordButton: 'Recuperar contraseña',
        recoverPasswordButton: 'ENVIAR',
        goBackButton: 'VOLVER',
        confirmPasswordError: 'No Coincide!',
        recoverPasswordDescription:
            'Te enviaremos un correo para poder restablecer tu contraseña',
        recoverPasswordSuccess:
            'Correo recuperar contraseña enviado correctamente',
        passwordHint: 'Contraseña',
        confirmPasswordHint: 'Confirmar Contraseña',
      ),
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => UserProfileScreen(),
        ));
      },
      onRecoverPassword: (String) {
        return null;
      },
    );
  }
}
