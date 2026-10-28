import 'package:flutter/material.dart';

import '../state/counter_state.dart';

class HistoryBadge extends StatelessWidget {
  const HistoryBadge({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('build: HistoryBadge');

    final state = CounterScope.of(context);

    if (state.historyCount == 0) {
      return const SizedBox.shrink();
    }

    return Container(
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
        '${state.historyCount}',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}