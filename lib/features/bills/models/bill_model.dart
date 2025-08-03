class Bill {
  final String? id;
  final String merchant;
  final double total;
  final String date;
  final String category;
  final List<String> items;
  final String imageUrl;

  Bill({
    this.id,
    required this.merchant,
    required this.total,
    required this.date,
    required this.category,
    required this.items,
    required this.imageUrl,
  });

  factory Bill.fromJson(Map<String, dynamic> json) => Bill(
    id: json['_id'],
    merchant: json['merchant'],
    total: (json['total'] as num).toDouble(),
    date: json['date'],
    category: json['category'],
    items: List<String>.from(json['items']),
    imageUrl: json['imageUrl'],
  );

  Map<String, dynamic> toJson() => {
    "merchant": merchant,
    "total": total,
    "date": date,
    "category": category,
    "items": items,
    "imageUrl": imageUrl,
  };
}
