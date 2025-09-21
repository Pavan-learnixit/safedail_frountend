/// Base class for all failures in the app.
class Failure {
  final String message;

  Failure(this.message);

  @override
  String toString() => message;
}

/// Optional: Extend for specific failure types
class NetworkFailure extends Failure {
  NetworkFailure(String message) : super(message);
}

class ValidationFailure extends Failure {
  ValidationFailure(String message) : super(message);
}

class ServerFailure extends Failure {
  ServerFailure(String message) : super(message);
}
