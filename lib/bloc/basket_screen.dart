import 'package:flutter/material.dart';
import 'package:shoes_bloc/bloc/basket_cubit.dart';
import 'package:shoes_bloc/bloc/shoes_cubit.dart';
import 'package:shoes_bloc/bloc/shoes_repository.dart';
import 'package:shoes_bloc/bloc/shoes_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class basketView extends StatefulWidget {
 basketView({Key? key}) : super(key: key);

  @override
  State<basketView> createState() => _basketViewState();
}




class _basketViewState extends State<basketView> {
  @override
  Widget build(BuildContext context) {
     return BlocProvider(
  create: (context) => shoesCubit(SampleshoesRepository()),
  child: buildScaffold(context),
);
 
    
  }

  Scaffold buildScaffold(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text(
            "Sepetim",
            style: TextStyle(fontSize: 25),
          ),
          centerTitle: true,
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                accountName: const Text(
                  "Ahmet Talha Dinç",
                  style: TextStyle(color: Colors.black),
                ),
                accountEmail: const Text("ahmettalhadinc50@gmail.com",
                    style: TextStyle(color: Colors.black)), // "gmail" düzeltilmiş
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
              context.read<shoesCubit>().getshoes(); // Yüklemeyi başlat
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

  



      );

  Text buildError(shoesState state) {
    final error = state as shoesError;
    return Text(error.message);
  }

  Widget buildListViewShoes(shoesCompleted state) {
    return ListView.builder(
      itemBuilder: (context, index) => 
      Padding(
        padding: const EdgeInsets.only(right: 35,left: 35,top: 10),
        child: Card(
        
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
           
            
            
            child: Stack(
        children: <Widget>[
          AspectRatio(
            aspectRatio: 40.0 / 40.0,
            child: Image.network(
              state.response[index].avatar,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom:245,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    state.response[index].name.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    state.response[index].price.toString(),
                    style: const TextStyle(color: Colors.black, fontSize: 15),
                  )
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 40,
                  height: 50,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black,
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.delete_forever,
                      color: Colors.white,
                    ),
                  ),
                ),
               
              
              ],
            ),
          )
        ],
            ),
          ),
        ),
      ),
      itemCount: state.response.length,
    );
  }

  Center buildCenterLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}