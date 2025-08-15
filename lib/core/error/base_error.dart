abstract class BaseError {
  int httpError;
  String message;

  BaseError({this.httpError = 0, this.message = ""});
}

class FirebaseError extends BaseError {
  FirebaseError({required super.message, int? httpError}) : super(httpError: httpError ?? 0);
}
