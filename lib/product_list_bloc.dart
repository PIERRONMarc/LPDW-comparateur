import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myflutterproject/product.dart';

import 'firebase_database.dart';

class ProductsListBloc extends Bloc<ProductsListEvent, ProductsListState> {
  ProductsListBloc() {
    add(ProductsListEvent());
  }

  @override
  ProductsListState get initialState => ProductsListState(null);

  @override
  Stream<ProductsListState> mapEventToState(ProductsListEvent event) async* {
    yield ProductsListState(null);

    var firebase = FirebaseDatabase;

    List products = [
      generateFakeProduct(),
      generateFakeProduct(),
      generateFakeProduct(),
      generateFakeProduct(),
      generateFakeProduct(),
    ];

    yield ProductsListState(await FirebaseDatabase().listProducts());
  }
}

class ProductsListEvent {
  const ProductsListEvent();
}

class ProductsListState {
  final List<Product> products;

  ProductsListState(this.products);
}
