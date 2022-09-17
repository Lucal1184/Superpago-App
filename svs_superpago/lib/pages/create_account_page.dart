import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:svs_superpago/model/user_model.dart';
import 'package:svs_superpago/pages/home_page.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final formkey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  String? errorMessage;

  final firstNameEditingController = TextEditingController();
  final lastNameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final firstNameField = TextFormField(
        autofocus: false,
        controller: firstNameEditingController,
        onSaved: (newValue) {
          firstNameEditingController.text = newValue!;
        },
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("Nombres no puede estar vacio");
          }
          if (!regex.hasMatch(value)) {
            return ("Ingrese un nombre válido(Min. 3 Character)");
          }
          return null;
        },
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
            hintText: "Nombres", border: InputBorder.none));

    final lastNamedField = TextFormField(
        obscureText: false,
        autofocus: false,
        controller: lastNameEditingController,
        onSaved: (value) {
          lastNameEditingController.text = value!;
        },
        keyboardType: TextInputType.name,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Apellidos no puede estar vacio");
          }
          return null;
        },
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
            hintText: "Apellidos", border: InputBorder.none));

    final emailField = TextFormField(
        autofocus: false,
        controller: emailEditingController,
        onSaved: (value) {
          emailEditingController.text = value!;
        },
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return ("Por favor ingrese su correo");
          }

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
        autofocus: false,
        validator: (value) {
          RegExp regex = RegExp(r'^.{6,}$');
          if (value!.isEmpty) {
            return ("Contraseña es requerida para ingresar");
          }
          if (!regex.hasMatch(value)) {
            return ("Ingrese una contraseña válida(Min. 6 Character)");
          }
          return null;
        },
        controller: passwordEditingController,
        onSaved: (value) {
          passwordEditingController.text = value!;
        },
        textInputAction: TextInputAction.next,
        decoration: const InputDecoration(
            hintText: "Contraseña", border: InputBorder.none));

    final confirmPasswordField = TextFormField(
        obscureText: true,
        autofocus: false,
        validator: (value) {
          if (confirmPasswordEditingController.text !=
              passwordEditingController.text) {
            return "La contraseña no coincide";
          }
          return null;
        },
        controller: confirmPasswordEditingController,
        onSaved: (newValue) {
          confirmPasswordEditingController.text = newValue!;
        },
        textInputAction: TextInputAction.done,
        decoration: const InputDecoration(
            hintText: "Confirmar contraseña", border: InputBorder.none));

    final registerButton = ElevatedButton(
      onPressed: () {
        signUp(emailEditingController.text, passwordEditingController.text);
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 20.0),
          textStyle:
              const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
      child: const Text('Registrar'),
    );

    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )),
            body: Center(
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              const Text(
                "Registro",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),

              //Logo
              Image.asset('assets/images/Logo.png',
                  width: 130.0, height: 130.0),
              Container(
                  padding: const EdgeInsets.all(50),
                  width: double.infinity,
                  height: 600,
                  decoration: const BoxDecoration(
                      color: Color.fromRGBO(234, 62, 62, 50),
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(50),
                          topLeft: Radius.circular(40))),
                  child: Column(children: [
                    const Text("Ingresa tus datos",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(
                      height: 20.0,
                    ),
                    Form(
                      key: formkey,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                                height: 40.0,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: firstNameField),
                            const SizedBox(height: 20.0),
                            Container(
                                height: 40.0,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: lastNamedField),
                            const SizedBox(
                              height: 30.0,
                            ),
                            Container(
                                height: 40.0,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: emailField),
                            const SizedBox(height: 20.0),
                            Container(
                                height: 40.0,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: passwordField),
                            const SizedBox(
                              height: 30.0,
                            ),
                            Container(
                                height: 40.0,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10.0)),
                                child: confirmPasswordField),
                            const SizedBox(
                              height: 30.0,
                            ),
                            registerButton,
                          ]),
                    ),
                    const SizedBox(
                      height: 20.0,
                    ),
                  ])),
            ]))));
  }

  void signUp(String email, String password) async {
    if (formkey.currentState!.validate()) {
      try {
        await auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.message);
        });
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "invalid-email":
            errorMessage = "Su dirección de correo parece estar mal escrita.";
            break;
          case "wrong-password":
            errorMessage = "Su contraseña es incorrecta.";
            break;
          case "user-not-found":
            errorMessage = "El usuario con este correo no existe.";
            break;
          case "user-disabled":
            errorMessage = "El usuario con este correo hja sido deshabilitado.";
            break;
          case "too-many-requests":
            errorMessage = "Demasiados intentos";
            break;
          case "operation-not-allowed":
            errorMessage =
                "el inicio de sesión con correo y contraseña no esta habilitado.";
            break;
          default:
            errorMessage = "Ocurrió un error indefinido.";
        }
        Fluttertoast.showToast(msg: errorMessage!);
      }
    }
  }

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = auth.currentUser;

    UserModel userModel = UserModel();

    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstNameEditingController.text;
    userModel.lastName = lastNameEditingController.text;

    await firebaseFirestore
        .collection("usuarios")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Cuenta creada correctamente :) ");

    Navigator.pushAndRemoveUntil(
        (context),
        MaterialPageRoute(builder: (context) => const HomePage()),
        (route) => false);
  }
}
