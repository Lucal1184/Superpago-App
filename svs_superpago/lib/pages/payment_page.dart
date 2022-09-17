import 'package:flutter/material.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: const BackButton(color: Colors.black)),
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
                    const Text("Eliga el medio de pago",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        )),
                    const SizedBox(height: 100.0),
                    Image.asset(
                      'assets/images/BotonPSE.png',
                      width: 150,
                      height: 150,
                    ),
                  ])),
            ]))));
  }
}
