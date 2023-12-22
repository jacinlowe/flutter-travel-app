import 'dart:ffi';

abstract class Failure {
  final String message;

  Failure(this.message);
}

class GetTripError extends Failure {
  GetTripError(String message) : super(message);
}
