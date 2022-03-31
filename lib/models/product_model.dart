class ProductModel{
  String? id;
  String? name;
  String? price;
  String? image;
  String? oldPrice;
  String? discount;
  String? description;
  bool? inFavourite;
  bool? inCart;
  List<dynamic>?images;

  ProductModel(this.id, this.name, this.price, this.image, this.oldPrice, this.discount,
      this.description, this.inFavourite, this.inCart, this.images);

  ProductModel.fromJson(Map<String,dynamic>data){
    id = data['id'].toString();
    name=data['name'];
    price=data['price'].toString();
    oldPrice=data['old_price'].toString();
    discount=data['discount'].toString();
    image=data['image'];
    description=data['description'];
    images=data['images'];
    inFavourite=data['in_favorites'];
    inCart=data['in_cart'];
  }
}