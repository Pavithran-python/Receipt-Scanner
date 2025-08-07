import 'package:scanner/core/constants/json_constant.dart';

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
    id: json[billJsonId],
    merchant: json[merchantJsonText],
    total: (json[totalJsonText] as num).toDouble(),
    date: json[dateJsonText],
    category: json[categoryJsonText],
    items: List<String>.from(json[itemsJsonText]),
    imageUrl: json[imageUrlJsonText],
  );

  Map<String, dynamic> toJson() => {
    merchantJsonText : merchant,
    totalJsonText : total,
    dateJsonText : date,
    categoryJsonText : category,
    itemsJsonText : items,
    imageUrlJsonText : imageUrl,
  };
}
