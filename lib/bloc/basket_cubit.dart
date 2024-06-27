import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoes_bloc/bloc/basket_state.dart';
import 'package:shoes_bloc/bloc/shoes_repository.dart';
import 'package:shoes_bloc/model/shoes.dart';

class BasketCubit extends Cubit<basketState> {
  BasketCubit(SampleshoesRepository sampleshoesRepository) : super(const basketInitial());


  List<Shoes> basketItems =[];


  Future<void> getBasket(Shoes newBasketItems) async {
    
    emit(const basketLoading());
    basketItems.add(newBasketItems);
    await Future.delayed(const Duration(milliseconds: 300));
     emit(basketCompleted(basketItems));
    }   
  }
