import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class ApiService {
  final Dio _dio = Dio(BaseOptions(
    // URL de producción final en Render
    baseUrl: 'https://backend-fastapi-4g1h.onrender.com', 
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 3),
  ));

  // --- Clientes ---

  Future<Response> loginCliente(String correo, String password) async {
    return await _dio.post('/api/clientes/login', data: {
      'correo': correo,
      'password': password,
    });
  }

  Future<Response> registerCliente({
    required String nombres,
    required String apellidos,
    required String telefono,
    required String correo,
    required String password,
  }) async {
    return await _dio.post('/api/clientes/', data: {
      'nombres': nombres,
      'apellidos': apellidos,
      'telefono': telefono,
      'correo': correo,
      'password': password,
    });
  }

  // --- Talleres ---

  Future<Response> loginTaller(String correo, String password) async {
    return await _dio.post('/api/talleres/login', data: {
      'correo': correo,
      'password': password,
    });
  }

  Future<Response> registerTaller(Map<String, dynamic> data) async {
    return await _dio.post('/api/talleres/', data: data);
  }
}
