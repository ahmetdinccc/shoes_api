import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/basket_cubit.dart';

class ShoesWidget extends StatefulWidget {
  const ShoesWidget({super.key,

  required this.avatar,
  required this.name,
  required this.price,
  required this.id,
  required this.onTap,

  }
  

  
  );
  final String avatar;
  final String name;
  final String price;
  final String id;
  final Function() onTap;
  

  @override
  State<ShoesWidget> createState() => _ShoesWidgetState();
}

class _ShoesWidgetState extends State<ShoesWidget> {

  bool _isFavorite=false;
  @override
  Widget build(BuildContext context) {
    return   Padding(
        padding: const EdgeInsets.only(right: 35, left: 35, top: 10),
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: SizedBox(
            child: Stack(
              children: <Widget>[
                AspectRatio(
                  aspectRatio: 40.0 / 40.0,
                  child: Image.network(
                    widget.avatar,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  bottom: 245,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          widget.name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                         widget.price,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
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
                          child: _isFavorite
                              ? IconButton(
                                  onPressed: () {
                                    setState(() {
                                       _isFavorite = !_isFavorite;
                                    });
                                   
                                  },
                                  icon: Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  ),
                                )
                              : IconButton(
                                  onPressed: () {
                            setState(() {
                                       _isFavorite = !_isFavorite;
                                    });
                                  },
                                  icon: Icon(
                                    Icons.favorite_border,
                                    color: Colors.white,
                                  ))),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.black,
                        ),
                        child: IconButton(
                          onPressed: () {
                            widget.onTap();
                            
                          },
                          icon: const Icon(
                            Icons.shopping_cart,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      );;
  }
}