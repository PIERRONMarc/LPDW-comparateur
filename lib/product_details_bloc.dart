import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myflutterproject/firebase_database.dart';
import 'package:myflutterproject/product.dart';

class ProductsDetailsBloc
    extends Bloc<ProductsDetailsEvent, ProductsDetailsState> {
  @override
  ProductsDetailsState get initialState => ProductsDetailsState(null);

  @override
  Stream<ProductsDetailsState> mapEventToState(
      ProductsDetailsEvent event) async* {
    yield ProductsDetailsState(null);

    String barcode = event.barcode;

    Dio dio = new Dio();
    var response = await dio.get("https://api.formation-android.fr/getProduct",
        queryParameters: {"barcode": barcode});

    Map<String, dynamic> mappedResult = Map.castFrom(response.data);

    Product product = Product.fromAPI(mappedResult['response']);

    await FirebaseDatabase().insertProduct(product);

    yield ProductsDetailsState(product);
  }
}

class ProductsDetailsEvent {
  final String barcode;

  ProductsDetailsEvent(this.barcode);
}

class ProductsDetailsState {
  final Product product;

  ProductsDetailsState(this.product);
}
