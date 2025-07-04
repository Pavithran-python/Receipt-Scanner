class Receipt {
  final int? id;
  final String merchant;
  final double total;
  final String date;
  final String category;
  final List items;
  final String imageBase64;

  Receipt({
    this.id,
    required this.merchant,
    required this.total,
    required this.date,
    required this.category,
    required this.items,
    required this.imageBase64,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'merchant': merchant,
      'total': total,
      'date': date,
      'category': category,
      'items': items.join(','),
      'imageBase64': imageBase64,
    };
  }

  factory Receipt.fromMap(Map<String, dynamic> map) {
    return Receipt(
      id: map['id'],
      merchant: map['merchant'],
      total: map['total'],
      date: map['date'],
      category: map['category'],
      items: map['items'].split(','),
      imageBase64: map['imageBase64'],
    );
  }
}
