sealed class Failure {
  const Failure(this.message);

  final String message;
}

class NetworkFailure extends Failure {
  const NetworkFailure()
    : super('No internet connection. Please check your network.');
}

class TimeoutFailure extends Failure {
  const TimeoutFailure()
    : super('The request timed out. Check your connection and try again.');
}

class ServerFailure extends Failure {
  const ServerFailure(this.statusCode)
    : super('Server error ($statusCode). Please try again later.');

  final int? statusCode;
}

class UnknownFailure extends Failure {
  const UnknownFailure() : super('Something went wrong. Please try again.');
}
