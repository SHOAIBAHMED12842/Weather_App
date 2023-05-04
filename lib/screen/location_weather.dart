import 'package:flutter/material.dart';
import 'package:weather_app/screen/Weatherapp_screen.dart';
import 'package:weather_app/utilities/constants.dart';
import 'package:weather_app/services/weather.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather1 = WeatherModel();
  String _cityName = '', country = '';
  String _weatherDescription = '';
  double _temperature = 0.0;
  double _feels_like = 0.0;
  double _temp_min = 0.0;
  double _temp_max = 0.0;
  var _speed;
  var temperatureMassage;
  var pressure, humidity;
  var lat = 0.0, long = 0.0;

  String _iconUrl = '';
  TextEditingController cityinput = TextEditingController();
  var getweatherdata = false;

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  //Future<void> _fetchWeatherData(String cityname) async {
  void _fetchWeatherData() async {
    // final apiKey = '6003852987ff375fa1ed44f9d3159aa6';
    // final url =
    //     'https://api.openweathermap.org/data/2.5/weather?q=$cityname&appid=$apiKey&units=metric';
    // final response = await http.get(Uri.parse(url));
    // print(response.statusCode.toString());
    //print(response.body);

    dynamic weatherData = await weather1.getLocationWeather();
    //if (response.statusCode == 200) {
    if (weatherData != null) {
      final weather = weatherData['weather'][0];
      final main = weatherData['main'];
      double temp = weatherData['main']['temp'];
      setState(() {
        _weatherDescription = weather['description'];
        _temperature = temp;
        temperatureMassage = weather1.getMessage(_temperature);
        var conditionNumber = weatherData['weather'][0]['id'];
        lat = weatherData['coord']['lat'];
        long = weatherData['coord']['lon'];
        _feels_like = main['feels_like'];
        _temp_min = main['temp_min'];
        _temp_max = main['temp_max'];
        pressure = main['pressure'];
        humidity = main['humidity'];
        _speed = weatherData['wind']['speed'];
        _cityName = weatherData['name'];
        country = weatherData['sys']['country'];
        //_iconUrl = 'http://openweathermap.org/img/w/${weather['icon']}.png';
        _iconUrl = weather1.getWeatherIcon(conditionNumber);
        getweatherdata = true;
      });
      print(_weatherDescription);
    } else {
      setState(() {
        getweatherdata = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Center(child: Text('City Weather')),
      // ),
      body:
          // Center(
          //   child:
          //   SingleChildScrollView(
          // child:
          Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        constraints: const BoxConstraints.expand(),
        //margin: const EdgeInsets.only(left: 50, right: 50),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ScreenWeather(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.arrow_back_ios_sharp),
                      color: Colors.white,
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    const Text(
                      'Location Weather',
                      style: kTempTextStyle,
                    ),
                    const SizedBox(
                      width: 40,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LocationScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.refresh_sharp),
                      color: Colors.white,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                getweatherdata
                    ? Center(
                        child: Column(
                          children: [
                            Text(
                              'Latitude : $lat',
                              style: kTempTextStyle,
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              'Longitude : $long',
                              style: kTempTextStyle,
                            ),
                            const SizedBox(height: 16),
                            Row(
                              children: [
                                const SizedBox(
                                  width: 120,
                                ),
                                Text(
                                  _cityName,
                                  style: kTempTextStyle,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  country,
                                  style: kTempTextStyle,
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            // Image.network(
                            //   _iconUrl,
                            //   //scale: 2,
                            // ),
                            Text(
                              _iconUrl,
                              style: kMessageTextStyle,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              _weatherDescription,
                              style: kMessageTextStyle,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              ' Temprature : $_temperature°C',
                              style: kTempTextStyle,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              ' Feels Like : $_feels_like°C',
                              style: kTempTextStyle,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              ' Temp Min : $_temp_min°C',
                              style: kTempTextStyle,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              ' Temp Max : $_temp_max°C',
                              style: kTempTextStyle,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              ' Pressure : $pressure',
                              style: kTempTextStyle,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              ' Humidity : $humidity',
                              style: kTempTextStyle,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              ' Wind Speed : $_speed',
                              style: kTempTextStyle,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              "$temperatureMassage in $_cityName $country",
                              style: kConditionTextStyle,
                            ),
                          ],
                        ),
                      )
                    : const Center(
                        child: SpinKitCircle(
                          color: Colors.white,
                          size: 50.0,
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
      // ),
      //),
    );
  }
}
