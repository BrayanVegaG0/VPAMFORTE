class SendResult {
  final int successCount;
  final int failureCount;

  const SendResult({required this.successCount, required this.failureCount});

  int get totalCount => successCount + failureCount;
  bool get hasFailures => failureCount > 0;
  bool get hasSuccesses => successCount > 0;
  bool get allSucceeded => failureCount == 0 && successCount > 0;
  bool get allFailed => successCount == 0 && failureCount > 0;
}
