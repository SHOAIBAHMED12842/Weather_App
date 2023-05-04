import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:weather_app/services/weather.dart';

class NetworkHelper {
  NetworkHelper(this.url);
  final String url;
  WeatherModel weather = WeatherModel();
  Future getData() async {
    try {
      http.Response response = await http.get(Uri.parse(url));
      print(response.statusCode);
      if (response.statusCode == 200) {
        String data = response.body;
        return jsonDecode(data);
      } else {
        print(response.statusCode);
        throw Exception('Failed to fetch weather data');
      }
    } catch (e) {
      weather.showsnackbar('Either connect the internet or give the location permission!');
    }
  }
}
