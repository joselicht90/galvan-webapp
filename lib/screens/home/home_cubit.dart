import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubitState extends Equatable {
  final bool loading;

  const HomeCubitState({this.loading = false});

  HomeCubitState copyWith({bool? loading}) {
    return HomeCubitState(loading: loading ?? this.loading);
  }

  @override
  List<Object?> get props => [loading];
}

class HomeCubit extends Cubit<HomeCubitState> {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  HomeCubit() : super(const HomeCubitState());

  Future<void> fetchData() async {
    emit(state.copyWith(loading: true));
    try {
      // Simula una llamada a una API o alguna operación asíncrona
      await Future.delayed(const Duration(seconds: 2));
    } finally {
      emit(state.copyWith(loading: false));
    }
  }
}
