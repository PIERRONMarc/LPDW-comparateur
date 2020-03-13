import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myflutterproject/appbar.dart';

import 'product.dart';
import 'product_details_bloc.dart';

class ProductDetailsScreen extends StatelessWidget {
  final String barcode;

  ProductDetailsScreen(this.barcode) : assert(barcode != null);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: OFFAppBar(
              title: 'Détails',
              bottom: TabBar(labelPadding: EdgeInsets.all(10), tabs: [
                Text('Fiche'),
                Text('Détails'),
              ]),
            ),
            body: BlocProvider(
                create: (_) =>
                    ProductsDetailsBloc()..add(ProductsDetailsEvent(barcode)),
                child: TabBarView(children: <Widget>[Fiche(), Nutrition()]))));
  }
}

class Fiche extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsDetailsBloc, ProductsDetailsState>(
      builder: (BuildContext context, ProductsDetailsState state) {
        if (state.product == null) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[CircularProgressIndicator()],
          );
        } else {
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Image.network(state.product.picture, height: 290.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                              child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                state.product.name,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text((state.product.brands?.join(", ") ??
                                  "Aucune marque trouvée"))
                            ],
                          )),
                          Image.asset("res/drawables/nutriscore_" +
                              state.product.nutriScore.toLowerCase() +
                              ".png")
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text("Code-barres : " + state.product.barcode),
                      ),
                      Text("Quantité : ${state.product.quantity}"),
                      Text("vendu en : " +
                          (state.product.manufacturingCountries?.join(", ") ??
                              "Aucun pays trouvé")),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text("Ingrédients : " +
                                (state.product.ingredients?.join(", ")) ??
                            "Aucun ingrédient trouvé"),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text("Substances allergènes : " +
                            (state.product.allergens?.join(", ") ?? "Aucune")),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
                        child: Text("Additifs : " +
                            (_generateAdditives(state.product.additives) ??
                                "Aucun")),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        }
      },
    );
  }

  String _generateAdditives(Map<String, String> additives) {
    StringBuffer buffer = StringBuffer();

    for (var key in additives.keys) {
      buffer.write(key);
      buffer.write(' : ');

      buffer.write(additives[key] + ', ');
    }

    return buffer.toString();
  }
}

class Nutrition extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Widget circle = Container(
      width: 25,
      height: 25,
      decoration:
          new BoxDecoration(color: Colors.black, shape: BoxShape.circle),
    );

    Widget _generateCircle(Color color) {
      return Container(
        width: 25,
        height: 25,
        decoration: new BoxDecoration(color: color, shape: BoxShape.circle),
      );
    }

    Row _generateRow(String type, Nutriment nutriment) {
      double maxLow, minHigh;
      switch (type) {
        case 'Matières grasses / lipides':
          maxLow = 3;
          minHigh = 20;
          break;
        case 'Sucres':
          maxLow = 5;
          minHigh = 12.5;
          break;
        case 'Sel':
          maxLow = 0.3;
          minHigh = 1.5;
          break;
        default:
          break;
      }

      Widget circle;
      String quantitySentence;
      if (double.parse(nutriment.per100g) <= maxLow) {
        circle = _generateCircle(Colors.green);
        quantitySentence = "en faible quantité";
      } else if (double.parse(nutriment.per100g) >= minHigh) {
        circle = _generateCircle(Colors.red);
        quantitySentence = "en quantité elevée";
      } else {
        circle = _generateCircle(Colors.orange);
        quantitySentence = "en quantité modéré";
      }

      return Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: circle,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(nutriment.per100g + "g de " + type),
              Text(quantitySentence),
            ],
          )
        ],
      );
    }

    return BlocBuilder<ProductsDetailsBloc, ProductsDetailsState>(
      builder: (BuildContext context, ProductsDetailsState state) {
        if (state.product == null) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[CircularProgressIndicator()],
          );
        } else {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, left: 20.0),
                    child: Text(
                      "Repères nutritionnels pour 100g",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: _generateRow('Matières grasses / lipides',
                            state.product.nutritionFacts.fat)),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: _generateRow(
                            'Sucres', state.product.nutritionFacts.sugar)),
                    Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: _generateRow(
                            'Sel', state.product.nutritionFacts.salt)),
                  ],
                ),
              )
            ],
          );
        }
      },
    );
  }
}
