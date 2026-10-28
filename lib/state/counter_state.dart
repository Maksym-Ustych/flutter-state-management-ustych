import 'package:flutter/material.dart';

import '../models/history_entry.dart';

class CounterState extends ChangeNotifier {
  int _value = 0;
  final List<HistoryEntry> _history = [];

  int get value => _value;

  List<HistoryEntry> get history => List.unmodifiable(_history);

  int get historyCount => _history.length;

  void increment(int step) {
    final beforeValue = _value;
    _value += step;

    _addHistory(
      action: '+$step',
      beforeValue: beforeValue,
      afterValue: _value,
    );

    notifyListeners();
  }

  bool decrement(int step) {
    if (_value < step) {
      return false;
    }

    final beforeValue = _value;
    _value -= step;

    _addHistory(
      action: '-$step',
      beforeValue: beforeValue,
      afterValue: _value,
    );

    notifyListeners();
    return true;
  }

  void reset() {
    if (_value == 0) {
      return;
    }

    final beforeValue = _value;
    _value = 0;

    _addHistory(
      action: 'R',
      beforeValue: beforeValue,
      afterValue: _value,
    );

    notifyListeners();
  }

  void clearHistory() {
    if (_history.isEmpty) {
      return;
    }

    _history.clear();
    notifyListeners();
  }

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
}

class CounterScope extends InheritedNotifier<CounterState> {
  const CounterScope({
    super.key,
    required CounterState notifier,
    required super.child,
  }) : super(notifier: notifier);

  static CounterState of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<CounterScope>();

    assert(
      scope != null,
      'CounterScope не знайдено в дереві віджетів',
    );

    return scope!.notifier!;
  }

  static CounterState read(BuildContext context) {
    final element =
        context.getElementForInheritedWidgetOfExactType<CounterScope>();

    final scope = element?.widget as CounterScope?;

    assert(
      scope != null,
      'CounterScope не знайдено в дереві віджетів',
    );

    return scope!.notifier!;
  }
}