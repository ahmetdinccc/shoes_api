import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:like_button/like_button.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shoes_bloc/bloc/basket_cubit.dart';
import 'package:shoes_bloc/bloc/basket_state.dart';
import 'package:shoes_bloc/bloc/shoes_cubit.dart';
import 'package:shoes_bloc/bloc/shoes_repository.dart';
import 'package:shoes_bloc/bloc/shoes_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoes_bloc/bloc/basket_screen.dart';
import 'package:shoes_bloc/bloc/shoes.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import 'package:shoes_bloc/bloc/bloc_shoes_view.dart';
import 'package:shoes_bloc/widget/shoes_widget.dart';

class BlocshoesView extends StatefulWidget {
  BlocshoesView({Key? key}) : super(key: key);

  @override
  State<BlocshoesView> createState() => _BlocshoesViewState();
}

class _BlocshoesViewState extends State<BlocshoesView> {
  int _selectedIndex = 0;
  bool _isFavorite = false;
  List<Widget> _widgetOptions = <Widget>[BlocshoesView(), basketView()];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onTapFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => shoesCubit(SampleshoesRepository()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: buildScaffold(context),
      ),
    );
  }

  Scaffold buildScaffold(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            "Senin Ayakkabın",
            style: TextStyle(fontSize: 25),
          ),
          centerTitle: true,
          actions: [
            BlocBuilder<BasketCubit, basketState>(
              builder: (context, state) {
                int? basketCount;
                if (state is basketCompleted) {
                  basketCount = state.response.length;
                }
                return Stack(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => basketView()),
                        );
                      },
                      icon: Icon(
                        Icons.shopping_cart,
                        size: 25,
                      ),
                    ),
                    context.read<BasketCubit>().basketItems.length > 0
                        ? Positioned(
                            right: 15.0,
                            top: 0.0,
                            child: Container(
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.red,
                              ),
                              child: Text(
                                context
                                    .read<BasketCubit>()
                                    .basketItems
                                    .length
                                    .toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                );
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: const Text(
                  "Ahmet Dinç",
                  style: TextStyle(color: Colors.black),
                ),
                accountEmail: const Text("ahmettalhadinc50@gmail.com",
                    style: TextStyle(color: Colors.black)),
                currentAccountPicture: ClipOval(
                  child: Image.network(
                    "https://media.licdn.com/dms/image/D4D03AQHYial4hJsbYQ/profile-displayphoto-shrink_200_200/0/1700325137144?e=1707955200&v=beta&t=JFPyP-bb0J_EPHR-p1WOb0dZMfG9pwdY-IOzmJxKE4E",
                  ),
                ),
                decoration: const BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              const ListTile(
                leading: Icon(Icons.home),
                title: Text("ANA SAYFAM"),
              ),
              const ListTile(
                leading: Icon(Icons.shopping_cart),
                title: Text("SEPETİM"),
              ),
              const ListTile(
                leading: Icon(Icons.favorite),
                title: Text("FAVORİLERİM"),
              ),
            ],
          ),
        ),
        body: BlocConsumer<shoesCubit, shoesState>(
          listener: (context, state) {
            if (state is shoesError) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            if (state is shoesInitial) {
              context.read<shoesCubit>().getshoes();
              return buildCenterLoading();
            } else if (state is shoesLoading) {
              return buildCenterLoading();
            } else if (state is shoesCompleted) {
              return buildListViewShoes(state);
            } else {
              return buildError(state);
            }
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color.fromARGB(255, 255, 0, 0),
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined), label: 'Ana Sayfa'),
            BottomNavigationBarItem(
              icon: BlocBuilder<BasketCubit, basketState>(
                builder: (context, state) {
                  int? basketCount;
                  if (state is basketCompleted) {
                    basketCount = state.response.length;
                  }
                  return Stack(
                    children: [
                      Icon(Icons.shopping_bag_outlined),
                      context.read<BasketCubit>().basketItems.length > 0
                          ? Positioned(
                              bottom: 11,
                              child: Container(
                                padding: EdgeInsets.all(3),
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: Colors.red),
                                child: Text(
                                  context
                                      .read<BasketCubit>()
                                      .basketItems
                                      .length
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                            )
                          : Container()
                    ],
                  );
                },
              ),
              label: 'Sepet',
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite_border), label: 'Favori'),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_2_outlined), label: 'Hesabım'),
          ],
          selectedItemColor: Color.fromARGB(255, 89, 255, 0),
          unselectedItemColor: const Color.fromARGB(255, 0, 0, 0),
          iconSize: 30,
          currentIndex: _selectedIndex,
          onTap: _onItemTap,
        ),
      );

  Text buildError(shoesState state) {
    final error = state as shoesError;
    return Text(error.message);
  }

  ListView buildListViewShoes(shoesCompleted state) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ShoesWidget(
          avatar: state.response[index].avatar,
          name: state.response[index].name ?? '',
          price: state.response[index].price ?? '0,0',
          onTap: () {
            context.read<BasketCubit>().getBasket(state.response[index]);

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.black,
                content: Text(
                  "${state.response[index].name.toString()} Ürünü Eklendi",
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
          id: '',
        );
      },
      itemCount: state.response.length,
    );
  }
}

Center buildCenterLoading() {
  return const Center(
    child: CircularProgressIndicator(
      backgroundColor: Colors.amber,
      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
    ),
  );
}
