import 'package:bloc/bloc.dart';
import 'package:ticketflow/core/common/debouncer.dart';
import 'package:ticketflow/core/enums/ticket_status.dart';
import 'package:ticketflow/features/search/data/repos/search_repo.dart';
import 'package:ticketflow/core/models/ticket_model.dart';

import 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final SearchRepository _repository;
  final Debouncer _debouncer = Debouncer(milliseconds: 500);

  List<TicketModel> searchResults = [];
  TicketStatus? selectedStatus;
  String currentQuery = '';
  bool isDescending = true;

  SearchCubit(this._repository) : super(SearchInitial()) {
    _performSearch();
  }

  /// Called when the text field value changes.
  /// Debounces the input before performing the search.
  void onQueryChanged(String query) {
    currentQuery = query.trim();
    _debouncer.run(() => _performSearch());
  }

  /// Called when a filter chip is selected.
  /// Triggers an immediate search.
  /// Pass `null` for the "All" chip.
  void onStatusChanged(TicketStatus? status) {
    selectedStatus = status;
    _performSearch();
  }

  /// Toggles the sort order between descending and ascending
  /// on the current result list by `createdAt`.
  void toggleSortOrder() {
    isDescending = !isDescending;

    if (searchResults.isNotEmpty) {
      searchResults = List<TicketModel>.from(searchResults)
        ..sort(
          (a, b) => isDescending
              ? b.createdAt.compareTo(a.createdAt)
              : a.createdAt.compareTo(b.createdAt),
        );
      emit(SearchSuccess());
    }
  }

  /// Core search logic — always delegates to `searchTickets`.
  Future<void> _performSearch() async {

    emit(SearchLoading());

    final result = await _repository.searchTickets(
      subject: currentQuery.isNotEmpty ? currentQuery : null,
      status: selectedStatus,
    );

    result.fold(
      (error) => emit(SearchFailure(error)),
      (tickets) {
        final sortedTickets = List<TicketModel>.from(tickets)
          ..sort(
            (a, b) => isDescending
                ? b.createdAt.compareTo(a.createdAt)
                : a.createdAt.compareTo(b.createdAt),
          );
        searchResults = sortedTickets;

        if (searchResults.isEmpty) {
          emit(SearchEmpty());
        } else {
          emit(SearchSuccess());
        }
      },
    );
  }

  @override
  Future<void> close() {
    _debouncer.dispose();
    return super.close();
  }
}
