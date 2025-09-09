class Purchase {
  final String titulo;
  final String fecha;
  final int cantidad;
  final double precio;

  Purchase({
    required this.titulo,
    required this.fecha,
    required this.cantidad,
    required this.precio,
  });
}

class HistoryService {
  static final HistoryService _instance = HistoryService._internal();
  factory HistoryService() => _instance;
  HistoryService._internal();

  final List<Purchase> _purchases = [
    Purchase(titulo: 'Summer Monument', fecha: '09/09/2023', cantidad: 1, precio: 12.00),
    Purchase(titulo: 'Customer Element', fecha: '09/09/2023', cantidad: 1, precio: 12.75),
  ];

  List<Purchase> get purchases => List.unmodifiable(_purchases);

  void add(Purchase purchase) {
    _purchases.add(purchase);
  }
}