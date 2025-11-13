import 'package:dio/dio.dart';
import 'package:galvan_webapp/models/nft_web_app.dart';
import 'package:galvan_webapp/models/proof_of_action.dart';
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
          baseUrl: const String.fromEnvironment('API_URL'),
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
          'Authorization': 'Bearer ${const String.fromEnvironment('API_KEY')}',
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
    final response = await _dio.post('/webapp/nft', data: nft.toJson());
    return NftWebApp.fromJson(response.data);
  }

  Future<NftWebApp> updateNft(NftWebApp nft) async {
    final response = await _dio.put(
      '/webapp/nft/${nft.id}',
      data: nft.toJson(),
    );
    return NftWebApp.fromJson(response.data);
  }

  Future<void> deleteNft(int id) async {
    await _dio.delete('/webapp/nft/$id');
  }

  Future<List<NftWebApp>> getNfts() async {
    final response = await _dio.get('/webapp/nft');
    final List data = response.data as List;
    return data.map((e) => NftWebApp.fromJson(e)).toList();
  }

  Future<NftWebApp> getNftById(int id) async {
    final response = await _dio.get('/webapp/nft/$id');
    return NftWebApp.fromJson(response.data);
  }

  // ------------------- Availability -------------------

  /// Creates a new availability period for a NFT
  Future<void> createAvailability(
    int nftId,
    DateTime startAt,
    DateTime endAt,
  ) async {
    await _dio.post(
      '/webapp/nft/availability',
      data: {
        'nftId': nftId,
        'startAt': startAt.toIso8601String(),
        'endAt': endAt.toIso8601String(),
      },
    );
  }

  /// Stops the current availability for a NFT by setting endAt = now
  Future<void> stopAvailability(int nftId) async {
    await _dio.patch('/webapp/nft/availability/$nftId/stop');
  }

  /// Returns the list of availability periods for a NFT
  Future<List<Map<String, dynamic>>> getAvailabilities(int nftId) async {
    final response = await _dio.get('/webapp/nft/$nftId/availability');
    final List data = response.data as List;
    return List<Map<String, dynamic>>.from(data);
  }

  // ------------------- Proof of Action -------------------

  /// Obtiene todos los registros de Proof of Action
  Future<List<ProofOfAction>> getProofsOfAction() async {
    final response = await _dio.get('/webapp/proof-of-action');
    final List data = response.data as List;
    return data.map((e) => ProofOfAction.fromJson(e)).toList();
  }

  /// Crea un nuevo Proof of Action
  Future<ProofOfAction> createProofOfAction(ProofOfAction proof) async {
    final response = await _dio.post(
      '/webapp/proof-of-action',
      data: proof.toJson(),
    );
    return ProofOfAction.fromJson(response.data);
  }

  /// Obtiene un Proof of Action por ID
  Future<ProofOfAction> getProofOfActionById(int id) async {
    final response = await _dio.get('/webapp/proof-of-action/$id');
    return ProofOfAction.fromJson(response.data);
  }

  /// Aprueba o desaprueba un Proof of Action
  Future<void> approveProof(int id) async {
    await _dio.patch(
      '/webapp/proof-of-action/$id/approve'
    );
  }

  /// Elimina un Proof of Action
  Future<void> deleteProofOfAction(int id) async {
    await _dio.delete('/webapp/proof-of-action/$id');
  }
}
