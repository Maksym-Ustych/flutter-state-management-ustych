import 'package:flutter/material.dart';

import '../state/counter_state.dart';
import '../widgets/counter_value.dart';
import '../widgets/history_badge.dart';
import 'history_screen.dart';

class CounterScreen extends StatefulWidget {
  const CounterScreen({super.key});

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _selectedStep = 1;

  void _increment() {
    CounterScope.read(context).increment(_selectedStep);
  }

  void _decrement() {
    final success =
        CounterScope.read(context).decrement(_selectedStep);

    if (!success) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Значення не може бути від’ємним',
          ),
        ),
      );
    }
  }

  void _reset() {
    CounterScope.read(context).reset();
  }

  void _openHistory() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const HistoryScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint('build: CounterScreen');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Лічильник'),
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                onPressed: _openHistory,
                icon: const Icon(Icons.history),
                tooltip: 'Історія',
              ),
              const HistoryBadge(),
            ],
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Поточне значення',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 16),
              const CounterValue(),
              const SizedBox(height: 32),
              const Text(
                'Крок зміни',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),
              SegmentedButton<int>(
                segments: const [
                  ButtonSegment<int>(
                    value: 1,
                    label: Text('1'),
                  ),
                  ButtonSegment<int>(
                    value: 5,
                    label: Text('5'),
                  ),
                  ButtonSegment<int>(
                    value: 10,
                    label: Text('10'),
                  ),
                ],
                selected: {_selectedStep},
                onSelectionChanged: (values) {
                  setState(() {
                    _selectedStep = values.first;
                  });
                },
              ),
              const SizedBox(height: 32),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                alignment: WrapAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _increment,
                    child: const Text(
                      '+',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _decrement,
                    child: const Text(
                      '−',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: _reset,
                    icon: const Icon(Icons.refresh),
                    label: const Text('Скинути'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}