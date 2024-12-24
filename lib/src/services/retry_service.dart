import 'dart:async';

import 'package:fampay/src/data/error_handler.dart';

class RetryPolicy {
  final int maxAttempts;
  final Duration initialDelay;
  final double backoffFactor;
  final Duration maxDelay;

  RetryPolicy({
    this.maxAttempts = 3,
    this.initialDelay = const Duration(seconds: 1),
    this.backoffFactor = 2.0,
    this.maxDelay = const Duration(seconds: 10),
  });

  Duration getDelayForAttempt(int attempt) {
    if (attempt <= 0) return Duration.zero;
    
    final delay = initialDelay.inMilliseconds * (backoffFactor * (attempt - 1));
    return Duration(milliseconds: delay.toInt().clamp(
      initialDelay.inMilliseconds,
      maxDelay.inMilliseconds,
    ));
  }
}

class RetryService {
  final RetryPolicy policy;

  RetryService({RetryPolicy? policy}) : policy = policy ?? RetryPolicy();

  Future<T> retry<T>(Future<T> Function() operation) async {
    int attempt = 0;
    while (true) {
      try {
        attempt++;
        return await operation();
      } catch (e) {
        if (attempt >= policy.maxAttempts) {
          rethrow;
        }
        
        if (e is ApiException && e.statusCode != null) {
          // Don't retry on certain status codes
          if ([401, 403, 404].contains(e.statusCode)) {
            rethrow;
          }
        }

        final delay = policy.getDelayForAttempt(attempt);
        await Future.delayed(delay);
      }
    }
  }
}