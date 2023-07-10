import 'package:shoes_app/model/product_model.dart';

class CartModel {
  int? id;
  late int quantity;
  ProductModel? product;

  CartModel({
    this.id,
    this.product,
    required this.quantity,
  });

  CartModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product = json['product'];
    quantity = json['quantity'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product!.toJson(),
      'quantity': quantity,
    };
  }

  double totalPrice() {
    return product!.price! * quantity;
  }
}
