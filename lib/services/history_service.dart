import '../models/product.dart';

class Purchase {
  final DateTime date;
  final List<Product> items;
  final double total;

  Purchase({
    required this.date,
    required this.items,
    required this.total,
  });
}

class HistoryService {
  HistoryService._();
  static final HistoryService _instance = HistoryService._();
  factory HistoryService() => _instance;

  final List<Purchase> _purchases = [];
  List<Purchase> get purchases => List.unmodifiable(_purchases);

  void add(Purchase p) => _purchases.add(p);
}
