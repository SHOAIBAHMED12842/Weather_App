import 'package:flutter/material.dart';
import 'package:weather_app/screen/Weatherapp_screen.dart';
import 'package:weather_app/utilities/constants.dart';
import 'package:weather_app/services/weather.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
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
  var getpressed = false;

  String _iconUrl = '';
  TextEditingController cityinput = TextEditingController();
  FocusNode cityfocus = FocusNode();
  var getweatherdata = false;

  @override
  void initState() {
    super.initState();
    //_fetchWeatherData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    cityfocus.dispose();
    super.dispose();
  }

  //Future<void> _fetchWeatherData(String cityname) async {
  void _fetchWeatherData(String cityname) async {
    // final apiKey = '6003852987ff375fa1ed44f9d3159aa6';
    // final url =
    //     'https://api.openweathermap.org/data/2.5/weather?q=$cityname&appid=$apiKey&units=metric';
    // final response = await http.get(Uri.parse(url));
    // print(response.statusCode.toString());
    //print(response.body);
    dynamic weatherData = await weather1.getCityWeather(cityname);
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
        getpressed = false;
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
            image: AssetImage('images/city_background1.jpg'),
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
                      width: 75,
                    ),
                    const Text(
                      'City Weather',
                      style: kTempTextStyle,
                    ),
                    const SizedBox(
                      width: 50,
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WeatherScreen(),
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
                Container(
                  margin: const EdgeInsets.only(left: 40, right: 40),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        100,
                      ),
                    ),
                  ),
                  child: Center(
                    child: TextFormField(
                      controller: cityinput,
                      focusNode: cityfocus,
                      decoration: const InputDecoration(
                        //labelText: 'Enter a city name',
                        hintText: 'Enter a city name',
                        filled: true,
                        fillColor: Colors.white,
                        hintStyle: khintStyle,
                        //labelStyle: ktextformTextStyle,
                        // border: OutlineInputBorder(
                        //   borderSide: BorderSide(
                        //       color:
                        //           Colors.yellow), // Change the border color to red
                        // ),
                        prefixIcon: Icon(
                          Icons.location_city_sharp,
                          size: 25,
                          color: Colors.black,
                        ),
                        //border: InputBorder.none,
                      ),
                      style: const TextStyle(
                        color: Colors.black, // Change the text color to red
                      ),
                    ),
                  ),
                ),

                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    cityfocus.unfocus();
                    setState(() {
                      getpressed = true;
                    });
                    final enteredText = cityinput.text;
                    _fetchWeatherData(enteredText);
                  },
                  child: const Text(
                    'Get Weather ☁️',
                    style: kButtonTextStyle,
                  ),
                ),
                // Text(
                //   _cityName,
                //   style: const TextStyle(fontSize: 24),
                // ),
                const SizedBox(height: 16),
                (getweatherdata && !getpressed)
                    ? Center(
                        child: Column(
                          children: [
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
                    : const SizedBox(),
                getpressed
                    ? const Center(
                        child: SpinKitCircle(
                          color: Colors.white,
                          size: 50.0,
                        ),
                      )
                    : const SizedBox(),
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
