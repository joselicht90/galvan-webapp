import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galvan_webapp/api/api_service.dart';
import 'package:galvan_webapp/models/nft_web_app.dart';
import 'package:injectable/injectable.dart';

class NftFormState extends Equatable {
  final bool isLoading;
  final String? error;
  final NftWebApp? nft;
  final bool isEditMode;
  final bool isSuccess;

  const NftFormState({
    this.isLoading = false,
    this.error,
    this.nft,
    this.isEditMode = false,
    this.isSuccess = false,
  });

  NftFormState copyWith({
    bool? isLoading,
    String? error,
    NftWebApp? nft,
    bool? isEditMode,
    bool? isSuccess,
  }) {
    return NftFormState(
      isLoading: isLoading ?? this.isLoading,
      error: error,
      nft: nft ?? this.nft,
      isEditMode: isEditMode ?? this.isEditMode,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }

  @override
  List<Object?> get props => [isLoading, error, nft, isEditMode, isSuccess];
}

@injectable
class NftFormCubit extends Cubit<NftFormState> {
  final ApiService apiService;

  NftFormCubit({required this.apiService}) : super(const NftFormState());

  /// Loads an existing NFT by ID for editing
  Future<void> loadNft(int id) async {
    emit(state.copyWith(isLoading: true, error: null, isEditMode: true));
    try {
      final nft = await apiService.getNftById(id);
      emit(state.copyWith(isLoading: false, nft: nft, isEditMode: true));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  /// Creates or updates depending on whether ID == 0 (new NFT)
  Future<void> submit(NftWebApp nft) async {
    emit(state.copyWith(isLoading: true, error: null, isSuccess: false));

    try {
      final isNew = nft.id == 0;
      final response = isNew
          ? await apiService.createNft(nft)
          : await apiService.updateNft(nft);

      emit(
        state.copyWith(
          isLoading: false,
          nft: response,
          isSuccess: true,
          isEditMode: !isNew,
        ),
      );
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}
