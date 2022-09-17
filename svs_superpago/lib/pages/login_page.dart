import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:svs_superpago/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formkey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final auth = FirebaseAuth.instance;
  String? errorMessage;

  @override
  Widget build(BuildContext context) {
    final emailField = TextFormField(
        autofocus: false,
        controller: emailController,
        onSaved: (value) {
          emailController.text = value!;
        },
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Por favor ingrese su correo");
          }
          // reg expression for email validation
          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
              .hasMatch(value)) {
            return ("Por favor ingrese un correo válido");
          }
          return null;
        },
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
            hintText: "Correo", border: InputBorder.none));

    final passwordField = TextFormField(
        obscureText: true,
        validator: (value) {
          RegExp regex = RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Contraseña es requerida para ingresar");
          }
          if (!regex.hasMatch(value)) {
            return ("Ingresa una contraseña valida(Min. 6 Character)");
          }
          return null;
        },
        autofocus: false,
        controller: passwordController,
        onSaved: (value) {
          passwordController.text = value!;
        },
        textInputAction: TextInputAction.done,
        decoration: const InputDecoration(
            hintText: "Contraseña", border: InputBorder.none));

    final loginButton = ElevatedButton(
      onPressed: () {
        signIn(emailController.text, passwordController.text);
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
          textStyle:
              const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
      child: const Text('Iniciar Sesión'),
    );

    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            body: Center(
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              const Text(
                "SVS Superpago",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 50),

              //Logo
              Image.asset(
                'assets/images/Logo.png',
                width: 130,
                height: 130,
              ),
              Container(
                padding: const EdgeInsets.all(50),
                width: double.infinity,
                height: 500,
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(234, 62, 62, 50),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        topLeft: Radius.circular(40))),
                child: Column(children: [
                  const Text("Bienvenido",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  const Text(
                    "Ingrese sus credenciales",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 30.0,
                  ), // Formulario de Login
                  Form(
                    key: formkey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                              height: 40.0,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: emailField),
                          const SizedBox(height: 20.0),
                          Container(
                              height: 40.0,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: passwordField),
                          const SizedBox(
                            height: 20.0,
                          ),
                          loginButton
                        ]),
                  ),
                  const SizedBox(
                    height: 40.0,
                  ),
                  // Navegación a página olvido su contraseña y crear cuenta
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: (() =>
                            Navigator.pushNamed(context, 'ForgotPassword')),
                        child: const Text('¿Olvidó su contraseña?',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(
                        height: 50.0,
                      ),
                      GestureDetector(
                        onTap: (() =>
                            Navigator.pushNamed(context, 'CreateAccount')),
                        child: const Text('Crear Cuenta',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ]),
              ),
            ]))));
  }

  //función de login

  void signIn(String email, String password) async {
    if (formkey.currentState!.validate()) {
      await auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((uid) => {
                Fluttertoast.showToast(msg: 'Ingreso con:$email'),
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => const HomePage())),
              });
    }
  }
}
