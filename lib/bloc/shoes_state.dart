import 'package:flutter/foundation.dart';
import 'package:shoes_bloc/bloc/shoes.dart';

abstract class shoesState {
  const shoesState();
}

class shoesInitial extends shoesState {
  const shoesInitial();
}

class shoesLoading extends shoesState {
  const shoesLoading();
}

class shoesCompleted extends shoesState {
  final List<Shoes> response;

  const shoesCompleted(this.response);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is shoesCompleted && listEquals(o.response, response);
  }

  @override
  int get hashCode => response.hashCode;
}

class shoesError extends shoesState {
  final String message;
  const shoesError(this.message);
  
}
