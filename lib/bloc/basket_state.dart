import 'package:flutter/foundation.dart';
import 'package:shoes_bloc/model/shoes.dart';

abstract class basketState {
  const basketState();
}

class basketInitial extends basketState {
  const basketInitial();
}

class basketLoading extends basketState {
  const basketLoading();
}

class basketCompleted extends basketState {
  final List<Shoes> response;

  const basketCompleted(this.response);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is basketCompleted && listEquals(o.response, response);
  }

  @override
  int get hashCode => response.hashCode;
}

class basketError extends basketState {
  final String message;
  const basketError(this.message);
}
