import 'package:flutter/material.dart';
import '../Helper/data_helper.dart';

class ProductList extends StatelessWidget {
  const ProductList({
    Key? key,
    required this.onDismiss,
  }) : super(key: key);
  final Function onDismiss;

  @override
  Widget build(BuildContext context) {
    List allProduct = DataHelper.allShoppingList;
    return allProduct.isNotEmpty
        ? ListView.builder(
            itemCount: allProduct.length,
            itemBuilder: (context, index) {
              return Dismissible(
                direction: DismissDirection.startToEnd,
                onDismissed: (e) {
                  onDismiss(index);
                },
                key: UniqueKey(),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Card(
                    child: ListTile(
                      title: Text(allProduct[index].productName),
                      leading: const Icon(Icons.shopping_basket,
                          color: Colors.black),
                      subtitle: Text((allProduct[index].productNumber *
                              allProduct[index].productPrice)
                          .toString()),
                    ),
                  ),
                ),
              );
            })
        : const Center(
            child: Text(
              "Por favor agregue algo al carrito",
              style: TextStyle(
                color: Colors.white,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
  }
}
