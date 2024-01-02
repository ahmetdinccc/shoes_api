import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoes_bloc/bloc/shoes_repository.dart';

import 'shoes_state.dart';

class shoesCubit extends Cubit<shoesState> {
  final shoesRepository _shoesRepository;
  shoesCubit(this._shoesRepository) : super(const shoesInitial());

  Future<void> getshoes() async {
    try {
      emit(const shoesLoading());
    await Future.delayed(const Duration(milliseconds: 200));
      final response = await _shoesRepository.getshoes();
      emit(shoesCompleted(response));
    } on NetworkError catch (e) {
      emit(shoesError(e.message));
    }
  }
}



