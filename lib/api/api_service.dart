import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class ApiService {
  final Dio _dio;

  ApiService()
    : _dio = Dio(
        BaseOptions(
          baseUrl: dotenv.env['API_URL'] ?? 'http://localhost:5000',
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {'Content-Type': 'application/json'},
        ),
      );

  String? jwtToken;

  void setToken(String token) {
    jwtToken = token;
    _dio.options.headers['Authorization'] = 'Bearer $token';
  }

  Future<Map<String, dynamic>> login(String username, String password) async {
    final apiKey = dotenv.env['API_KEY'] ?? '';
    final response = await _dio.post(
      '/webapp/login',
      data: {'username': username, 'password': password},
      options: Options(headers: {'Authorization': 'Bearer $apiKey'}),
    );
    return response.data;
  }

  Future<List<dynamic>> getUsers() async {
    final response = await _dio.get('/users');
    return response.data;
  }
}
