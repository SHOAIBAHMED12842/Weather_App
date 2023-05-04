
import 'package:weather_app/services/location.dart';
import 'package:weather_app/services/networking.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

const apiKey = '6003852987ff375fa1ed44f9d3159aa6';
const openWeatherMap = "https://api.openweathermap.org/data/2.5/weather";
class WeatherModel {

void showsnackbar(String message) {
    Fluttertoast.showToast(
      //msg: response.statusCode.toString() + response.body,
      msg: message,
      //toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 5,
      //backgroundColor: const Color.fromRGBO(232, 141, 20, 1),
      backgroundColor: Colors.black,
      textColor: Colors.white,
      fontSize: 16,
    );
  }
  Future<dynamic> getCityWeather(String cityName) async{
    var url = '$openWeatherMap?q=$cityName&appid=$apiKey&units=metric';
    NetworkHelper networkHelper = NetworkHelper(url);

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();
    await location.getCurrentLocation();

    NetworkHelper networkHelper = NetworkHelper('$openWeatherMap?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();

    return weatherData;

  }



  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '🌩';
    } else if (condition < 400) {
      return '🌧';
    } else if (condition < 600) {
      return '☔️';
    } else if (condition < 700) {
      return '☃️';
    } else if (condition < 800) {
      return '🌫';
    } else if (condition == 800) {
      return '☀️';
    } else if (condition <= 804) {
      return '☁️';
    } else {
      return '🤷‍';
    }
  }

  String getMessage(double temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 20) {
      return 'You\'ll buy 🧣 and 🧤 soon';
    } else if (temp < 15) {
      return 'You\'ll buy 🧣 and 🧤 soon';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
