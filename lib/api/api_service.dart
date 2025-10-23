import 'package:dio/dio.dart';
import 'package:galvan_webapp/models/nft_web_app.dart';
import 'package:injectable/injectable.dart';

// Nuevo import moderno para entorno web
import 'package:web/web.dart' as web;

@lazySingleton
class ApiService {
  final Dio _dio;
  String? jwtToken;

  ApiService()
    : _dio = Dio(
        BaseOptions(
          baseUrl: String.fromEnvironment('API_URL'),
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {'Content-Type': 'application/json'},
        ),
      );

  /// Guarda token en memoria y cookie (si web)
  void setToken(String token) {
    jwtToken = token;
    _dio.options.headers['Authorization'] = 'Bearer $token';

    if (_isWeb) {
      web.document.cookie =
          'jwt=$token; path=/; max-age=3600; SameSite=Lax; Secure';
    }
  }

  /// Lee el token guardado (cookie si web)
  Future<void> loadTokenFromCookie() async {
    if (_isWeb) {
      final cookies = web.document.cookie.split('; ');
      final jwtPair = cookies.firstWhere(
        (c) => c.startsWith('jwt='),
        orElse: () => '',
      );
      if (jwtPair.isNotEmpty) {
        final token = jwtPair.split('=')[1];
        jwtToken = token;
        _dio.options.headers['Authorization'] = 'Bearer $token';
      }
    }
  }

  Future<Map<String, dynamic>> login(String username, String password) async {
    final response = await _dio.post(
      '/webapp/login',
      options: Options(
        headers: {
          'Authorization': 'Bearer ${String.fromEnvironment('API_KEY')}',
        },
      ),
      data: {'username': username, 'password': password},
    );

    final token = response.data['token'] as String?;
    if (token != null) {
      setToken(token);
    }

    return response.data;
  }

  Future<List<dynamic>> getUsers() async {
    await loadTokenFromCookie(); // asegura tener el token antes
    final response = await _dio.get('/users');
    return response.data;
  }

  /// Limpia el token de la cookie y de memoria
  void logout() {
    jwtToken = null;
    _dio.options.headers.remove('Authorization');

    if (_isWeb) {
      web.document.cookie = 'jwt=; path=/; max-age=0';
    }
  }

  bool get _isWeb => identical(0, 0.0); // simple detección de entorno web

  // ------------------- NFT CRUD -------------------

  Future<NftWebApp> createNft(NftWebApp nft) async {
    final response = await _dio.post('/webapp/nfts', data: nft.toJson());
    return NftWebApp.fromJson(response.data);
  }

  Future<NftWebApp> updateNft(NftWebApp nft) async {
    final response = await _dio.put(
      '/webapp/nfts/${nft.id}',
      data: nft.toJson(),
    );
    return NftWebApp.fromJson(response.data);
  }

  Future<void> deleteNft(int id) async {
    await _dio.delete('/webapp/nfts/$id');
  }

  Future<List<NftWebApp>> getNfts() async {
    final response = await _dio.get('/webapp/nfts');
    final List data = response.data as List;
    return data.map((e) => NftWebApp.fromJson(e)).toList();
  }

  Future<NftWebApp> getNftById(int id) async {
    final response = await _dio.get('/webapp/nfts/$id');
    return NftWebApp.fromJson(response.data);
  }
}
