import 'package:flutter/material.dart';

import '../state/counter_state.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  String _formatTime(DateTime time) {
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');
    final seconds = time.second.toString().padLeft(2, '0');

    return '$hours:$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    final state = CounterScope.of(context);
    final history = state.history;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Історія змін'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${state.historyCount}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: history.isEmpty
          ? const Center(
              child: Text(
                'Історія поки порожня',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: history.length,
              itemBuilder: (context, index) {
                final entry = history[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Text(entry.action),
                    ),
                    title: Text(
                      '${entry.beforeValue} → ${entry.afterValue}',
                    ),
                    subtitle: Text(
                      'Час: ${_formatTime(entry.time)}',
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: history.isEmpty
          ? null
          : FloatingActionButton.extended(
              onPressed: () {
                CounterScope.read(context).clearHistory();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Історію очищено'),
                  ),
                );
              },
              icon: const Icon(Icons.delete_outline),
              label: const Text('Очистити історію'),
            ),
    );
  }
}