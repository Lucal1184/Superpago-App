import 'package:flutter/material.dart';
import 'package:svs_superpago/pages/login_page.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final formkey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  String? errorMessage;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      const Text(
        "¿Olvidó su contraseña?",
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.black,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(height: 20),
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
                  topRight: Radius.circular(50), topLeft: Radius.circular(40))),
          child: Column(children: [
            const Text(
                "Ingrese su correo electrónico para reestablecer su contraseña",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                )),
            const SizedBox(height: 30),
            ingresarCorreo(),
            const SizedBox(
              height: 50,
            ),
            botonEnviar(),
          ])),
    ]);
  }

  Widget ingresarCorreo() {
    return Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
        child: TextFormField(
          controller: emailController,
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
          decoration: const InputDecoration(
            border: InputBorder.none,
            hintText: "Correo",
          ),
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.done,
        ));
  }

  Widget botonEnviar() {
    return ElevatedButton(
      onPressed: () {
        passwordReset(emailController);
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          textStyle:
              const TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
      child: const Text('Enviar'),
    );
  }

  Future passwordReset(TextEditingController emailController) async {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            content: Text(
                'Enlace de reestablecimiento de contraseña fue enviado, por favor revise su correo'),
          );
        });
  }
}
