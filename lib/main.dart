import 'package:flutter/material.dart';

import 'models/history_entry.dart';
import 'screens/counter_screen.dart';
import 'screens/history_screen.dart';

void main() {
  runApp(const CounterApp());
}

class CounterApp extends StatelessWidget {
  const CounterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Лічильник з історією',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const CounterHome(),
    );
  }
}

class CounterHome extends StatefulWidget {
  const CounterHome({super.key});

  @override
  State<CounterHome> createState() => _CounterHomeState();
}

class _CounterHomeState extends State<CounterHome> {
  int _value = 0;
  final List<HistoryEntry> _history = [];

  void _addHistory({
    required String action,
    required int beforeValue,
    required int afterValue,
  }) {
    _history.insert(
      0,
      HistoryEntry(
        time: DateTime.now(),
        action: action,
        beforeValue: beforeValue,
        afterValue: afterValue,
      ),
    );
  }

  void _increment(int step) {
    setState(() {
      final beforeValue = _value;
      _value += step;

      _addHistory(
        action: '+$step',
        beforeValue: beforeValue,
        afterValue: _value,
      );
    });
  }

  void _decrement(int step) {
    setState(() {
      final beforeValue = _value;
      _value -= step;

      _addHistory(
        action: '-$step',
        beforeValue: beforeValue,
        afterValue: _value,
      );
    });
  }

  void _reset() {
    if (_value == 0) {
      return;
    }

    setState(() {
      final beforeValue = _value;
      _value = 0;

      _addHistory(
        action: 'R',
        beforeValue: beforeValue,
        afterValue: _value,
      );
    });
  }

  void _clearHistory() {
    setState(() {
      _history.clear();
    });
  }

  void _openHistory() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return HistoryScreen(
            history: _history,
            onClearHistory: _clearHistory,
          );
        },
      ),
    ).then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return CounterScreen(
      value: _value,
      historyCount: _history.length,
      onIncrement: _increment,
      onDecrement: _decrement,
      onReset: _reset,
      onOpenHistory: _openHistory,
    );
  }
}