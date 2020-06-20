import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

abstract class IGetRequestByApiKey {
  String get baseUrl;
  http.Client get httpClient;
  String apiKey;

  Future<Map<String,dynamic>> request({
    @required String terms, 
  });
  // IN: "term&term&term", onError
  // OUT: GET response as a decoded JSON
}

class DefaultGetRequestByApiKey implements IGetRequestByApiKey {
  final String baseUrl;
  final http.Client httpClient;
  String apiKey;

  DefaultGetRequestByApiKey({

    String termKey= "key",
    @required this.apiKey,
    @required  String baseUrl,
    http.Client httpClient,

  }) 
  : this.baseUrl = "$baseUrl?$termKey=$apiKey&",
  this.httpClient = httpClient ?? http.Client();

  @override
  Future<Map<String,dynamic>> request({
    @required String terms, 
  }) async {

    final response= await httpClient.get(Uri.parse("$baseUrl$terms"));
    
    final results= json.decode(response.body);

    return results;
  }
}