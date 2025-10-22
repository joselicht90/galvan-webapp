import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:galvan_webapp/api/api_service.dart';
import 'package:injectable/injectable.dart';

class LoginState extends Equatable {
  final bool isLoading;
  final String? error;
  final String? token;

  const LoginState({this.isLoading = false, this.error, this.token});

  LoginState copyWith({bool? isLoading, String? error, String? token}) {
    return LoginState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      token: token ?? this.token,
    );
  }

  @override
  List<Object?> get props => [isLoading, error, token];
}

@injectable
@lazySingleton
class LoginCubit extends Cubit<LoginState> {
  final GlobalKey<FormBuilderState> formKey = GlobalKey<FormBuilderState>();
  final ApiService apiService;

  LoginCubit({required this.apiService}) : super(const LoginState());

  // Validar y ejecutar login
  Future<void> submit() async {
    final form = formKey.currentState;
    if (form == null || !form.validate()) return;

    form.save();
    // Tomar valores directamente del formulario
    final username = form.value['username']?.toString() ?? '';
    final password = form.value['password']?.toString() ?? '';

    emit(state.copyWith(isLoading: true, error: null));

    try {
      final data = await apiService.login(username, password);
      final token = data['token'] as String;
      apiService.setToken(token);

      emit(state.copyWith(isLoading: false, token: token));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void logout() {
    apiService.setToken('');
    emit(const LoginState());
  }
}
