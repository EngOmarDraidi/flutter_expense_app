class Category {
  num? id;
  String? name;
  String? icon;
  num? transactionType;

  Category(this.name, this.icon, this.transactionType);

  Category.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    name = data['name'];
    icon = data['icon'];
    transactionType = data['tran_type'];
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'icon': icon,
      'tran_type': transactionType,
    };
  }
}
