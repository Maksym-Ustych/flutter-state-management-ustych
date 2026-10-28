import 'package:flutter/material.dart';

import 'screens/counter_screen.dart';
import 'state/counter_state.dart';

void main() {
  runApp(const CounterApp());
}

class CounterApp extends StatefulWidget {
  const CounterApp({super.key});

  @override
  State<CounterApp> createState() => _CounterAppState();
}

class _CounterAppState extends State<CounterApp> {
  late final CounterState _counterState;

  @override
  void initState() {
    super.initState();
    _counterState = CounterState();
  }

  @override
  void dispose() {
    _counterState.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CounterScope(
      notifier: _counterState,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Лічильник з історією',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
          ),
          useMaterial3: true,
        ),
        home: const CounterScreen(),
      ),
    );
  }
}