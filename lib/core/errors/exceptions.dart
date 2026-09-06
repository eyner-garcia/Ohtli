class AppException implements Exception {
  final String message;
  AppException(this.message);

  @override
  String toString() => message;
}

class NetworkException extends AppException {
  NetworkException([super.message = 'Sin conexión a Internet. Por favor, verifica tu red.']);
}

class ServerException extends AppException {
  ServerException([super.message = 'Ocurrió un error en el servidor. Intente más tarde']);
}