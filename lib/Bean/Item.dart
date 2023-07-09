import 'dart:convert';

class Product {
  final String id;
  final String title;
  final String category;
  final Price price;
  final String brand;
  final List<String> images;
  final List<String> features;
  final List<Spec> specs;
  final Rating rating;

  Product({
    required this.id,
    required this.title,
    required this.category,
    required this.price,
    required this.brand,
    required this.images,
    required this.features,
    required this.specs,
    required this.rating,
  });
}

class Price {
  final String currency;
  final int value;
  final int discount;

  Price({
    required this.currency,
    required this.value,
    required this.discount,
  });
}

class Spec {
  final String name;
  final String value;

  Spec({
    required this.name,
    required this.value,
  });
}

class Rating {
  final int count;
  final int value;

  Rating({
    required this.count,
    required this.value,
  });
}

List<Product> productsFromJson(String json) {
  //print(json);
  List<dynamic> parsedJson = jsonDecode(json);

  return parsedJson
      .map((json) => Product(
            id: json['id'],
            title: json['title'],
            category: json['category'],
            price: Price(
              currency: json['price']['currency'],
              value: int.parse(json['price']['value'].toString()),
              discount: json['price']['discount'],
            ),
            brand: json['brand'],
            images: List<String>.from(json['images']),
            features: List<String>.from(json['features']),
            specs: json['specs'] != null
                ? List<Spec>.from(json['specs'].map((spec) => Spec(
                      name: spec['name'],
                      value: spec['value'],
                    )))
                : [],
            rating: Rating(
              count: json['rating']['count'],
              value: json['rating']['value'],
            ),
          ))
      .toList();
}
