import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shoes_bloc/model/shoes.dart';

abstract class shoesRepository {
  Future<List<Shoes>> getshoes();
}

class SampleshoesRepository implements shoesRepository {
  final baseUrl = "https://657845bcf08799dc8044bfe2.mockapi.io/Shoe";

  @override
  Future<List<Shoes>> getshoes() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == HttpStatus.ok) {
        final List<dynamic> jsonData = jsonDecode(response.body);

        if (jsonData is List) {
          return jsonData
              .map((e) => Shoes.fromJson(e as Map<String, dynamic>))
              .toList();
        } else {
          throw NetworkError('Error', 'Unexpected data structure');
        }
      } else {
        throw NetworkError(response.statusCode.toString(), response.body);
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print(stackTrace.toString());
      }
      if (kDebugMode) {
        print(e.toString());
      }
      throw NetworkError('Error', e.toString());
    }
  }
}

class NetworkError implements Exception {
  final String statusCode;
  final String message;

  NetworkError(this.statusCode, this.message);

  @override
  String toString() {
    return 'NetworkError: Status Code: $statusCode, Message: $message';
  }
}
