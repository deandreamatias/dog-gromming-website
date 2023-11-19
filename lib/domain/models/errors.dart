sealed class MainError {
  const MainError();
}

class NoInternet extends MainError {
  const NoInternet();
}

class UnknownError extends MainError {
  const UnknownError();
}

sealed class FormError extends MainError {
  const FormError();
}

class InvalidDataForm extends FormError {
  const InvalidDataForm();
}

sealed class ApiError extends MainError {
  final String message;

  const ApiError({this.message = ''});
}

class BadRequestError extends ApiError {
  const BadRequestError({super.message = ''});
}

class ForbiddenError extends ApiError {
  const ForbiddenError({super.message = ''});
}

class NotFoundError extends ApiError {
  const NotFoundError({super.message = ''});
}

class UnauthError extends ApiError {
  const UnauthError({super.message = ''});
}

class ExpiredSessionError extends ApiError {
  const ExpiredSessionError({super.message = ''});
}

class ServerError extends ApiError {
  const ServerError({super.message = ''});
}

class UnknowApiError extends ApiError {
  const UnknowApiError({super.message = ''});
}
