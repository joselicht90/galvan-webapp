import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:galvan_webapp/api/api_service.dart';
import 'package:galvan_webapp/models/nft_web_app.dart';

class NftHomeState extends Equatable {
  final List<NftWebApp> nfts;
  final List<NftWebApp> allNfts;
  final bool isLoading;
  final String? error;
  final int? sortColumnIndex;
  final bool sortAscending;
  final String query;

  const NftHomeState({
    this.nfts = const [],
    this.allNfts = const [],
    this.isLoading = false,
    this.error,
    this.sortColumnIndex,
    this.sortAscending = true,
    this.query = '',
  });

  NftHomeState copyWith({
    List<NftWebApp>? nfts,
    List<NftWebApp>? allNfts,
    bool? isLoading,
    String? error,
    int? sortColumnIndex,
    bool? sortAscending,
    String? query,
  }) {
    return NftHomeState(
      nfts: nfts ?? this.nfts,
      allNfts: allNfts ?? this.allNfts,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      sortColumnIndex: sortColumnIndex ?? this.sortColumnIndex,
      sortAscending: sortAscending ?? this.sortAscending,
      query: query ?? this.query,
    );
  }

  @override
  List<Object?> get props => [
    nfts,
    allNfts,
    isLoading,
    error,
    sortColumnIndex,
    sortAscending,
    query,
  ];
}

class NftHomeCubit extends Cubit<NftHomeState> {
  final ApiService _api;
  NftHomeCubit(this._api) : super(const NftHomeState());

  Future<void> fetchNfts() async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final nfts = await _api.getNfts();
      emit(state.copyWith(isLoading: false, allNfts: nfts, nfts: nfts));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  Future<void> deleteNft(int id) async {
    try {
      await _api.deleteNft(id);
      // Refresh the list after deletion
      fetchNfts();
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  Future<void> startAvailability({
    required int nftId,
    required DateTime startAt,
    required DateTime endAt,
  }) async {
    try {
      emit(state.copyWith(isLoading: true));
      await _api.createAvailability(nftId, startAt, endAt);
      await fetchNfts(); // reload list
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  Future<void> stopAvailability(int nftId) async {
    try {
      emit(state.copyWith(isLoading: true));
      await _api.stopAvailability(nftId);
      await fetchNfts(); // reload list
    } catch (e) {
      emit(state.copyWith(error: e.toString(), isLoading: false));
    }
  }

  void filterByQuery(String query) {
    final lower = query.toLowerCase();
    final filtered = state.allNfts.where((nft) {
      return nft.name.toLowerCase().contains(lower) ||
          nft.standardName.toLowerCase().contains(lower) ||
          (nft.owner ?? '').toLowerCase().contains(lower);
    }).toList();
    emit(state.copyWith(nfts: filtered, query: query));
  }

  void sort<T extends Comparable>(
    T Function(NftWebApp n) getField,
    int columnIndex,
    bool ascending,
  ) {
    final sorted = [...state.nfts];
    sorted.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);
      return ascending ? aValue.compareTo(bValue) : bValue.compareTo(aValue);
    });
    emit(
      state.copyWith(
        nfts: sorted,
        sortColumnIndex: columnIndex,
        sortAscending: ascending,
      ),
    );
  }
}
