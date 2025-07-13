// history_screen.dart
import 'package:flutter/material.dart';

class HistoryScreen extends StatelessWidget {
  final List<Map<String, String>> history;

  const HistoryScreen({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Translation History"),
        backgroundColor: Colors.indigo.shade900,
      ),
      body: history.isEmpty
          ? const Center(child: Text("No history available"))
          : ListView.builder(
        itemCount: history.length,
        itemBuilder: (context, index) {
          final item = history[index];
          return ListTile(
            leading: const Icon(Icons.history),
            title: Text(item['original'] ?? ''),
            subtitle: Text(item['translated'] ?? ''),
          );
        },
      ),
    );
  }
}
