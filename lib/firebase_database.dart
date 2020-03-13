import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart' as db;
import 'package:firebase_database/firebase_database.dart';
import 'package:myflutterproject/product.dart';

class FirebaseDatabase {
  static FirebaseDatabase _instance = FirebaseDatabase._();

  FirebaseDatabase._();

  factory FirebaseDatabase() => _instance;

  Future<db.FirebaseDatabase> _database = FirebaseApp.configure(
      name: 'db',
      options: const FirebaseOptions(
        googleAppID: '1:578300219185:android:0bca30e6984bb3ca64ea10',
        apiKey: 'AIzaSyAR5FNkM3WaZZ9n9uTzpfoDKmMslI-3Yl4',
        databaseURL: 'https://comparateur-13418.firebaseio.com',
      )).then((app) => db.FirebaseDatabase(app: app));

  Future<List<Product>> listProducts() async {
    var db = await _database;
    var productRef = db.reference().child('flutterProducts');
    DataSnapshot snapshot = await productRef.once();

    List<Product> products = [];

    for (var key in snapshot.value.keys) {
      products.add(Product.fromAPI(Map.castFrom(snapshot.value[key])));
    }

    print(products.toString());
    return products;
  }

  Future insertProduct(Product product) async {
    var db = await _database;

    var productRef = db
        .reference()
        .child('flutterProducts/${DateTime.now().millisecondsSinceEpoch}');

    productRef.set(product.toDB());
  }
}
