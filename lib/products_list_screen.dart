import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myflutterproject/button.dart';
import 'package:myflutterproject/product_detail_screen.dart';
import 'package:myflutterproject/product_list_bloc.dart';

import 'appIcons.dart';
import 'appbar.dart';

class ProdutsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: OFFAppBar(title: 'Mes produits'),
        body: BlocProvider(
            create: (_) => ProductsListBloc(), child: ProductsList()));
  }
}

class ProductsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsListBloc, ProductsListState>(
        builder: (BuildContext context, ProductsListState state) {
      print(state.products);
      if (state.products == null) {
        return ProductsEmptyList();
      } else {
        return ProductsFullList();
      }

//      FloatingActionButton(
//        child: Text("Click me"),
//      )
    });
  }
}

class ProductsFullList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var products = BlocProvider.of<ProductsListBloc>(context).state.products;

    return Stack(
      children: <Widget>[
        ListView.builder(
          itemCount: products.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailsScreen(products[index].barcode)));
              },
              child: Card(
                  margin:
                      EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Image.network(products[index].picture, height: 290.0),
                        Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        products[index].name,
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Text((products[index]
                                                .brands
                                                ?.join(", ") ??
                                            "Aucune marque trouvée")),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        child: Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 5),
                                              child: Icon(AppIcons.calories,
                                                  size: 15),
                                            ),
                                            Text(
                                                "Nutriscore : ${products[index].nutriScore}")
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ])),
                      ])),
            );
          },
        ),
        Positioned(
          right: 30,
          bottom: 30,
          child: OFFFloatingActionButton(
              icon: AppIcons.barcode_scanner,
              onPressed: () async {
                String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                    '#ff6666', "Retour", false, ScanMode.BARCODE);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailsScreen(barcodeScanRes)));
              }),
        )
      ],
    );
  }
}

class ProductsEmptyList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Image.asset('res/drawables/ic_empty_list.png'),
        Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Text("Vous n'avez encore rien scanné",
              style: TextStyle(fontWeight: FontWeight.bold)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Text("Cliquez sur le bouton ci-dessous pour commencer",
              style: TextStyle(fontSize: 16.0)),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: OFFButton(
              text: 'Scanner un produit',
              onPressed: () async {
                String barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
                    '#ff6666', "Retour", false, ScanMode.BARCODE);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProductDetailsScreen(barcodeScanRes)));
              }),
        )
      ],
    ));
  }
}
