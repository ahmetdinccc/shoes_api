class Shoes {

  String avatar;
  String? name;
  String? price;
  String? id;

  Shoes({
    
    required this.avatar,
    required this.name,
    required this.price,
    required this.id,
  });

  Shoes.fromJson(Map<String, dynamic> json)
      : 
        avatar = json['avatar'],
        name = json['name'],
        price=json['price'],
        id = json['id'];

  Map<String, dynamic> toJson() {
    return {
    
      'avatar': avatar,
      'name': name,
      'price': price,
      'id': id,
      
    };
  }
}