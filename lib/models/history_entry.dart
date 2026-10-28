class HistoryEntry {
  final DateTime time;
  final String action;
  final int beforeValue;
  final int afterValue;

  const HistoryEntry({
    required this.time,
    required this.action,
    required this.beforeValue,
    required this.afterValue,
  });
}