class Product {
  final String name;
  final String altName;
  final String barcode;
  final String picture;
  final String quantity;
  final List<String> brands;
  final List<String> manufacturingCountries;
  final String nutriScore;
  final String novaScore;
  final List<String> ingredients;
  final List<String> traces;
  final List<String> allergens;
  final Map<String, String> additives;
  final NutrientLevels nutrientLevels;
  final NutritionFacts nutritionFacts;
  final bool ingredientsFromPalmOil;

  Product(
      {this.name,
      this.altName,
      this.barcode,
      this.picture,
      this.quantity,
      this.brands,
      this.manufacturingCountries,
      this.nutriScore,
      this.novaScore,
      this.ingredients,
      this.traces,
      this.allergens,
      this.additives,
      this.nutrientLevels,
      this.nutritionFacts,
      this.ingredientsFromPalmOil});

  Product.fromAPI(Map<String, dynamic> api)
      : name = api['name'],
        altName = api['altName'],
        barcode = api['barcode'],
        picture = api['picture'],
        quantity = api['quantity'],
        brands =
            _Utils.toListFromObject(api['brands'], (item) => item as String),
        manufacturingCountries = _Utils.toListFromObject(
            api['manufacturingCountries'], (item) => item as String),
        nutriScore = api['nutriScore'],
        novaScore = api['novaScore'],
        ingredients = _Utils.toListFromObject(
            api['ingredients'], (item) => item as String),
        traces =
            _Utils.toListFromObject(api['traces'], (item) => item as String),
        allergens =
            _Utils.toListFromObject(api['allergens'], (item) => item as String),
        additives =
            api['additives'] != null ? Map.castFrom(api['additives']) : null,
        nutritionFacts = api['nutritionFacts'] != null
            ? NutritionFacts.fromAPI(Map.castFrom(api['nutritionFacts']))
            : null,
        nutrientLevels = api['nutrientLevels'] != null
            ? NutrientLevels.fromAPI(Map.castFrom(api['nutrientLevels']))
            : null,
        ingredientsFromPalmOil = api['containsPalmOil'];

  Map<String, dynamic> toDB() => {
        'name': name,
        'altName': altName,
        'barcode': barcode,
        'picture': picture,
        'quantity': quantity,
        'brands': brands,
        'manufacturingCountries': manufacturingCountries,
        'nutriScore': nutriScore,
        'novaScore': novaScore,
        'ingredients': ingredients,
        'traces': traces,
        'allergens': allergens,
        'additives': additives,
        'nutritionFacts': nutritionFacts?.toDB(),
        'nutrientLevels': nutrientLevels?.toDB(),
        'ingredientsFromPalmOil': ingredientsFromPalmOil,
      };

  static List<String> stringToList(String text) {
    if (text == null || text.isEmpty) {
      return null;
    }

    RegExp('\\(.*?\\)').allMatches(text).forEach((match) {
      var group = match.group(0);
      text = text.replaceAll(group, group.replaceAll(',', '****'));
    });

    return null;
  }

  static Map<String, String> extractAdditives(List additivesTags) {
    return null;
  }

  static bool extractPalmOil(dynamic object) {
    if (object == null || object is! num) {
      return false;
    }
    return object >= 1;
  }

  @override
  String toString() {
    return 'Product{name: $name, altName: $altName, barcode: $barcode, picture: $picture, quantity: $quantity, brands: $brands, manufacturingCountries: $manufacturingCountries, nutriScore: $nutriScore, novaScore: $novaScore, ingredients: $ingredients, traces: $traces, allergens: $allergens, additives: $additives, nutrientLevels: $nutrientLevels, nutritionFacts: $nutritionFacts, ingredientsFromPalmOil: $ingredientsFromPalmOil}';
  }
}

class NutritionFacts {
  final String servingSize;
  final Nutriment calories;
  final Nutriment fat;
  final Nutriment saturatedFat;
  final Nutriment carbohydrate;
  final Nutriment sugar;
  final Nutriment fiber;
  final Nutriment proteins;
  final Nutriment sodium;
  final Nutriment salt;
  final Nutriment energy;

  NutritionFacts(
      {this.servingSize,
      this.calories,
      this.fat,
      this.saturatedFat,
      this.carbohydrate,
      this.sugar,
      this.fiber,
      this.proteins,
      this.sodium,
      this.salt,
      this.energy});

  NutritionFacts.fromAPI(Map<String, dynamic> api)
      : servingSize = api['servingSize'],
        calories =
            _Utils.extract(api['calories'], (item) => Nutriment.fromAPI(item)),
        fat = _Utils.extract(api['fat'], (item) => Nutriment.fromAPI(item)),
        saturatedFat = _Utils.extract(
            api['saturatedFat'], (item) => Nutriment.fromAPI(item)),
        carbohydrate = _Utils.extract(
            api['carbohydrate'], (item) => Nutriment.fromAPI(item)),
        sugar = _Utils.extract(api['sugar'], (item) => Nutriment.fromAPI(item)),
        fiber = _Utils.extract(api['fiber'], (item) => Nutriment.fromAPI(item)),
        proteins =
            _Utils.extract(api['proteins'], (item) => Nutriment.fromAPI(item)),
        sodium =
            _Utils.extract(api['sodium'], (item) => Nutriment.fromAPI(item)),
        energy =
            _Utils.extract(api['energy'], (item) => Nutriment.fromAPI(item)),
        salt = _Utils.extract(api['salt'], (item) => Nutriment.fromAPI(item));

  Map<String, dynamic> toDB() => {
        'servingSize': servingSize,
        'calories': calories?.toDB(),
        'fat': fat?.toDB(),
        'saturatedFat': saturatedFat?.toDB(),
        'carbohydrate': carbohydrate?.toDB(),
        'sugar': sugar?.toDB(),
        'fiber': fiber?.toDB(),
        'proteins': proteins?.toDB(),
        'sodium': sodium?.toDB(),
        'energy': energy?.toDB(),
        'salt': salt?.toDB()
      };

  @override
  String toString() {
    return 'NutritionFacts{servingSize: $servingSize, calories: $calories, fat: $fat, saturatedFat: $saturatedFat, carbohydrate: $carbohydrate, sugar: $sugar, fiber: $fiber, proteins: $proteins, sodium: $sodium, salt: $salt, energy: $energy}';
  }
}

class Nutriment {
  final String unit;
  final dynamic perServing;
  final dynamic per100g;

  Nutriment({this.unit, this.perServing, this.per100g});

  Nutriment.fromAPI(Map<String, dynamic> api)
      : per100g = api['per100g'],
        perServing = api['perServing'],
        unit = api['unit'];

  Map<String, dynamic> toDB() =>
      {'per100g': per100g, 'perServing': perServing, 'unit': unit};

  @override
  String toString() {
    return 'Nutriment{unit: $unit, perServing: $perServing, per100g: $per100g}';
  }
}

class NutrientLevels {
  final String salt;
  final String saturatedFat;
  final String sugars;
  final String fat;

  NutrientLevels({this.salt, this.saturatedFat, this.sugars, this.fat});

  NutrientLevels.fromAPI(Map<String, dynamic> api)
      : salt = api['salt'],
        saturatedFat = api['saturated-fat'],
        sugars = api['sugars'],
        fat = api['fat'];

  Map<String, dynamic> toDB() => {
        'salt': salt,
        'saturated-fat': saturatedFat,
        'sugars': sugars,
        'fat': fat
      };

  @override
  String toString() {
    return 'NutrientLevels{salt: $salt, saturatedFat: $saturatedFat, sugars: $sugars, fat: $fat}';
  }
}

class _Utils {
  static List<O> toListFromObject<I, O>(List<I> object, ListItemBuilder<I, O> f,
      [bool returnNonNullList = false, bool acceptNullItems = false]) {
    if (object != null) {
      List<O> list = [];

      for (var item in object) {
        if (acceptNullItems == true || item != null) {
          addNonNull(list, f(item));
        }
      }

      return list;
    }

    if (returnNonNullList == true) {
      return List(0);
    } else {
      return null;
    }
  }

  static void addNonNull(List<Object> list, Object item) {
    if (item != null) {
      list.add(item);
    }
  }

  static T extract<T>(Object object, ObjectBuilder<T> f) {
    try {
      return f(object);
    } catch (e) {
      return null;
    }
  }
}

typedef ListItemBuilder<I, O> = O Function(I object);
typedef ObjectBuilder<T> = T Function(Map<String, Object> object);

Product generateFakeProduct() => Product(
    name: 'Barres Glacées Cœur Croustillant',
    brands: ['Twix'],
    barcode: '5000159484695',
    picture:
        'https://static.openfoodfacts.org/images/products/500/015/948/4695/front_fr.13.full.jpg',
    quantity: '205,2 g / 258,6 ml',
    manufacturingCountries: ['France'],
    nutriScore: 'E',
    novaScore: '4',
    ingredients: [
      'Sucre',
      'lait écrémé',
      'sirop de glucose',
      'crème légère (lait)',
      'eau',
      'lait écrémé en poudre',
      'pâte de cacao',
      'lait écrémé concentré sucré',
      'matière grasse de noix de coco',
      'matière grasse de palme',
      'farine de blé',
      'beurre de cacao',
      'beurre concentré (lait)',
      'lactose',
      'petit-lait en poudre',
      'cacao maigre',
      'beurre (lait)',
      'émulsifiants (lécithine de soja, E471, E492)',
      'lait entier en poudre',
      'arômes naturels',
      'sel',
      'stabilisants (E407, E410, E412)',
      'colorant naturel (caramel ordinaire)',
      'cacao en poudre',
      'poudre à lever (E503)',
      'extrait naturel de vanille'
    ],
    allergens: ['Gluten', 'Lait', 'Soja'],
    traces: ['Fruits à coque', 'Arachides'],
    nutritionFacts: NutritionFacts(
      servingSize: '100g',
      energy: Nutriment(
        unit: 'kCal',
        per100g: '286',
        perServing: '123',
      ),
      fat: Nutriment(
        unit: 'g',
        per100g: '14,2',
        perServing: '6,12',
      ),
      saturatedFat: Nutriment(
        unit: 'g',
        per100g: '9,6',
        perServing: '4,14',
      ),
      carbohydrate: Nutriment(
        unit: 'g',
        per100g: '36,4',
        perServing: '15,7',
      ),
      sugar: Nutriment(
        unit: 'g',
        per100g: '29,2',
        perServing: '12,6',
      ),
      fiber: null,
      salt: Nutriment(
        unit: 'g',
        per100g: '0,3',
        perServing: '0,129',
      ),
      sodium: Nutriment(
        unit: 'g',
        per100g: '0,12',
        perServing: '0,052',
      ),
    ),
    additives: {
      'E123': 'Nom de l\'additif',
      'E234': 'Nom de l\'additif',
      'E345': 'Nom de l\'additif',
      'E456': 'Nom de l\'additif',
    },
    ingredientsFromPalmOil: true);
