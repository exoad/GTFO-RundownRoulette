/// Good enough for my use cases hahaha
///
/// a basic type that operates similar on java's optional type
/// which allows for a more explicit and strongly typed value
/// rather than just a nullable type (Type?)
final class Result<A, E /*usually this is a string*/ > {
  final A? _payload;
  final E message;
  final bool _good; // bum

  Result._(this._payload, this.message, this._good);

  /// good job :D
  factory Result.good(A payload, E message) => Result<A, E>._(payload, message, true);

  /// bad job >:(
  factory Result.bad(E message) => Result<A, E>._(null, message, false);

  factory Result.fromNullable(A? payload, E message) =>
      payload == null ? Result<A, E>.bad(message) : Result<A, E>.good(payload, message);

  A get payload {
    if (_payload == null || !_good) {
      throw const BadResultException("payload is not available!");
    }
    return _payload;
  }

  bool get isGood => _good;

  bool get isBad => !_good;

  void onBad(void Function(E message) consumer) {
    if (isBad) {
      consumer(message);
    }
  }

  void onGood(void Function(A payload, E message) consumer) {
    if (isGood) {
      consumer(payload, message);
    }
  }
}

/// represents a bad result exception for when the payload doesnt exist or the
/// result is no good
final class BadResultException implements Exception {
  final String message;
  const BadResultException(this.message);

  @override
  String toString() => "BadResult: $message";
}