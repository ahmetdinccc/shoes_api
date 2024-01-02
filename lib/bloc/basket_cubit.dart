import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoes_bloc/bloc/shoes.dart';
import 'package:shoes_bloc/bloc/shoes_repository.dart';
import 'package:shoes_bloc/bloc/basket_state.dart';
import 'shoes_state.dart';

class BasketCubit extends Cubit<basketState> {
  final shoesRepository _shoesRepository;
  BasketCubit(this._shoesRepository) : super(const basketInitial());


  List<Shoes> basketItems =[];


  Future<void> getBasket(Shoes newBasketItems) async {
    
    emit(basketLoading());
    basketItems.add(newBasketItems);
    await Future.delayed(Duration(milliseconds: 300));
     emit(basketCompleted(basketItems));
    }   
  }
