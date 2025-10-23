import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:galvan_webapp/api/api_service.dart';
import 'package:galvan_webapp/models/nft_web_app.dart';
import 'package:injectable/injectable.dart';

class NftFormState extends Equatable {
  final bool isLoading;
  final String? error;
  final NftWebApp? nft;

  const NftFormState({this.isLoading = false, this.error, this.nft});

  NftFormState copyWith({bool? isLoading, String? error, NftWebApp? nft}) {
    return NftFormState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      nft: nft ?? this.nft,
    );
  }

  @override
  List<Object?> get props => [isLoading, error, nft];
}

@injectable
class NftFormCubit extends Cubit<NftFormState> {
  final ApiService apiService;

  NftFormCubit({required this.apiService}) : super(const NftFormState());

  Future<void> submit(NftWebApp nft) async {
    emit(state.copyWith(isLoading: true, error: null));

    try {
      final response = await apiService.createNft(nft);
      emit(state.copyWith(isLoading: false, nft: response));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
