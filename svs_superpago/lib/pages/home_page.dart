import 'package:flutter/material.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:svs_superpago/helper/data_helper.dart';
import 'package:svs_superpago/model/shopping.dart';
import 'package:svs_superpago/widgets/product_list.dart';
import 'package:svs_superpago/widgets/show_money.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var nameFormKey = GlobalKey<FormState>();
  var totalPriceKey = GlobalKey<FormState>();
  String imputProductName = " ";
  String imputPrice = " ";
  TextEditingController imputNumberController = TextEditingController();

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromRGBO(234, 62, 62, 5),
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Center(
          child: Text(
            "Supermercado",
            style: TextStyle(color: Colors.black, fontSize: 18),
          ),
        ),
        backgroundColor: Colors.white,
      ),
      drawer: Drawer(
          child: ListView(
        children: const <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
                color: Colors.white,
                image: DecorationImage(
                    fit: BoxFit.scaleDown,
                    image: AssetImage(
                      'assets/images/Logo.png',
                    ))),
            child: null,
          ),
          ListTile(
            title: Text('Perfil'),
          ),
          ListTile(
            title: Text('Configuración'),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      )),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              const SizedBox(height: 30.0),
              const Text('Valor Total',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  )),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 50),
                  child: ShowPrice(
                    totalPrice: DataHelper.total(),
                  ),
                ),
              ),
              const SizedBox(
                height: 60,
              ),
              TextButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, 'PaymentPage');
                  },
                  icon: const Icon(
                    Icons.payment,
                    size: 35.0,
                    color: Colors.white,
                  ),
                  label: const Text(
                    "Medio de pago",
                    style: TextStyle(color: Colors.white, fontSize: 20.0),
                  )),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(padding: EdgeInsets.all(5.0)),
                  Container(
                    child: _builProductNameForm(),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(children: [
                    Expanded(
                      flex: 2,
                      child: _buildProductPriceNumber(),
                    ),
                    Expanded(
                        flex: 1,
                        child: IconButton(
                          icon: const Icon(
                            Icons.add_shopping_cart,
                          ),
                          color: Colors.white,
                          iconSize: 70.0,
                          onPressed: _totalCalculate,
                        ))
                  ]),
                ],
              )
            ],
          ),
          Expanded(
            child: ProductList(onDismiss: (index) {
              DataHelper.allShoppingList.removeAt(index);
              setState(() {});
            }),
          )
        ],
      ),
    );
  }

  Widget _builProductNameForm() {
    return Form(
      key: nameFormKey,
      child: _builtNameTextFormField(),
    );
  }

  _builtNameTextFormField() {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
        onSaved: (deger) {
          setState(() {
            imputProductName = deger!;
          });
        },
        controller: TextEditingController(),
        decoration: InputDecoration(
            hintText: "Producto",
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(color: Colors.black)),
            filled: true,
            fillColor: Colors.white),
      ),
    );
  }

  _buildProductPriceNumber() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Form(
          key: totalPriceKey,
          child: Column(
            children: [
              _builPriceFormField(),
              const SizedBox(
                height: 20,
              ),
              _buildProductNumber(),
            ],
          )),
    );
  }

  _builPriceFormField() {
    return TextFormField(
        onSaved: (deger) {
          setState(() {
            imputPrice = deger!;
          });
        },
        decoration: const InputDecoration(
            hintText: "Precio", fillColor: Colors.white, filled: true));
  }

  _buildProductNumber() {
    return NumberInputWithIncrementDecrement(
      incDecBgColor: Colors.white,
      decIconColor: Colors.white,
      incIconColor: Colors.white,
      min: 0,
      max: 15,
      numberFieldDecoration: const InputDecoration(
        hintText: "Cantidad",
        fillColor: Colors.white,
        filled: true,
      ),
      widgetContainerDecoration: BoxDecoration(
          color: Colors.black, borderRadius: BorderRadius.circular(5.0)),
      controller: imputNumberController,
    );
  }

  void _totalCalculate() {
    if (nameFormKey.currentState!.validate()) {
      nameFormKey.currentState!.save();
      totalPriceKey.currentState!.save();
      var addShopping = Shopping(
          productName: imputProductName,
          productPrice: double.parse(imputPrice),
          productNumber: int.parse(imputNumberController.text));

      DataHelper.addShoppingList(addShopping);
    }
  }
}
