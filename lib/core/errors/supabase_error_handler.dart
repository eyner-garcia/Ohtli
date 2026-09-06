import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'exceptions.dart';

Future<T> supabaseCallHandler<T>(Future<T> Function() apiCall) async {
  try {
    return await apiCall();
  } on SocketException catch (_) {
    throw NetworkException();
  } on AuthException catch (e) {
    final msg = e.message.toLowerCase();

    if (msg.contains('socketexception') ||
        msg.contains('failed host lookup') ||
        msg.contains('clientexception') ||
        msg.contains('network')) {
      throw NetworkException();
    }

    if (msg.contains('invalid login credentials')) {
      throw ServerException('Correo o contraseña incorrectos.');
    }

    throw ServerException(e.message);
  } on PostgrestException catch (e) {
    throw ServerException(e.message);
  } catch (e) {
    final errorString = e.toString().toLowerCase();

    if (errorString.contains('socketexception') ||
        errorString.contains('failed host lookup') ||
        errorString.contains('clientexception') ||
        errorString.contains('connection refused') ||
        errorString.contains('network is unreachable')) {
      throw NetworkException();
    }

    throw ServerException('Error inesperado: $e');
  }
}