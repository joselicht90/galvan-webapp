import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:galvan_webapp/api/api_service.dart';
import 'package:galvan_webapp/models/proof_of_action.dart';

class ProofOfActionState {
  final List<ProofOfAction> proofs;
  final bool isLoading;
  final String? error;
  final int? sortColumnIndex;
  final bool sortAscending;
  final String searchQuery;

  ProofOfActionState({
    required this.proofs,
    this.isLoading = false,
    this.error,
    this.sortColumnIndex,
    this.sortAscending = true,
    this.searchQuery = '',
  });

  ProofOfActionState copyWith({
    List<ProofOfAction>? proofs,
    bool? isLoading,
    String? error,
    int? sortColumnIndex,
    bool? sortAscending,
    String? searchQuery,
  }) {
    return ProofOfActionState(
      proofs: proofs ?? this.proofs,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      sortColumnIndex: sortColumnIndex ?? this.sortColumnIndex,
      sortAscending: sortAscending ?? this.sortAscending,
      searchQuery: searchQuery ?? this.searchQuery,
    );
  }
}

class ProofOfActionCubit extends Cubit<ProofOfActionState> {
  final ApiService _api;

  ProofOfActionCubit(this._api) : super(ProofOfActionState(proofs: []));

  Future<void> fetchProofs() async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final proofs = await _api.getProofsOfAction();
      emit(state.copyWith(isLoading: false, proofs: proofs));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }

  void filterByQuery(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  void sort<T extends Comparable<T>>(
    T Function(ProofOfAction n) getField,
    int columnIndex,
    bool ascending,
  ) {
    final sorted = List<ProofOfAction>.from(state.proofs)
      ..sort((a, b) {
        final aValue = getField(a);
        final bValue = getField(b);
        return ascending ? aValue.compareTo(bValue) : bValue.compareTo(aValue);
      });

    emit(
      state.copyWith(
        proofs: sorted,
        sortColumnIndex: columnIndex,
        sortAscending: ascending,
      ),
    );
  }

  Future<void> approveProof(int id) async {
    await _api.approveProof(id);
    await fetchProofs();
  }

  Future<void> deleteProof(int id) async {
    await _api.deleteProofOfAction(id);
    await fetchProofs();
  }
}
