import 'package:flutter/material.dart';

class CounterScreen extends StatefulWidget {
  final int value;
  final int historyCount;
  final void Function(int step) onIncrement;
  final void Function(int step) onDecrement;
  final VoidCallback onReset;
  final VoidCallback onOpenHistory;

  const CounterScreen({
    super.key,
    required this.value,
    required this.historyCount,
    required this.onIncrement,
    required this.onDecrement,
    required this.onReset,
    required this.onOpenHistory,
  });

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  int _selectedStep = 1;

  void _decrement() {
    if (widget.value < _selectedStep) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Значення не може бути від’ємним'),
        ),
      );
      return;
    }

    widget.onDecrement(_selectedStep);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Лічильник'),
        actions: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              IconButton(
                onPressed: widget.onOpenHistory,
                icon: const Icon(Icons.history),
                tooltip: 'Історія',
              ),
              if (widget.historyCount > 0)
                Container(
                  margin: const EdgeInsets.only(
                    top: 4,
                    right: 4,
                  ),
                  padding: const EdgeInsets.all(4),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    '${widget.historyCount}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
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
              Text(
                '${widget.value}',
                style: const TextStyle(
                  fontSize: 64,
                  fontWeight: FontWeight.bold,
                ),
              ),
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
                    onPressed: () {
                      widget.onIncrement(_selectedStep);
                    },
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
                    onPressed: widget.onReset,
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