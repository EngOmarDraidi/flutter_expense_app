class Transaction {
  num? id;
  String? date;
  num? amount;
  num? categoryId;
  String? categoryName;
  String? categoryIcon;
  num? tranType;
  String? note;

  Transaction.fromMap(Map<String, dynamic> data) {
    id = data['id'];
    date = data['date'];
    amount = data['amount'];
    categoryId = data['category_id'];
    categoryName = data['name'];
    categoryIcon = data['icon'];
    tranType = data['tran_type'];
    note = data['note'];
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'amount': amount,
      'category_id': categoryId,
      'note': note,
    };
  }
}
