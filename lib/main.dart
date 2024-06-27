import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoes_bloc/page/bloc_shoes_view.dart';
import 'package:shoes_bloc/bloc/basket_cubit.dart';
import 'package:shoes_bloc/bloc/shoes_cubit.dart';
import 'package:shoes_bloc/bloc/shoes_repository.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider<shoesCubit>(
            create: (context) => shoesCubit(SampleshoesRepository()),
          ),
          BlocProvider<BasketCubit>(
            create: (context) => BasketCubit(SampleshoesRepository()),
          ),
        ],
        child: BlocshoesView(),
      ),
    );
  }
}