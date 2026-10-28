import 'package:flutter/material.dart';

import '../state/counter_state.dart';

class CounterValue extends StatelessWidget {
  const CounterValue({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('build: CounterValue');

    final state = CounterScope.of(context);

    return Text(
      '${state.value}',
      style: const TextStyle(
        fontSize: 64,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}