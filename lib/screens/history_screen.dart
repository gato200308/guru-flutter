import 'package:flutter/material.dart';
import '../services/history_service.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final history = HistoryService().purchases;

    return Scaffold(
      appBar: AppBar(title: const Text('Historial de Compras')),
      body: history.isEmpty
          ? const Center(child: Text('Aún no hay compras registradas'))
          : ListView.builder(
              itemCount: history.length,
              itemBuilder: (context, i) {
                final h = history[i];
                return Card(
                  margin: const EdgeInsets.all(8),
                  child: ListTile(
                    title: Text(
                      'Compra ${i + 1} · \$${h.total.toStringAsFixed(2)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      '${h.date}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (_) => ListView(
                          padding: const EdgeInsets.all(16),
                          children: h.items
                              .map((p) => ListTile(
                                    title: Text(p.name),
                                    trailing: Text(
                                        '\$${p.price.toStringAsFixed(2)}'),
                                  ))
                              .toList(),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
