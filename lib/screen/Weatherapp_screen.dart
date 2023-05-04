import 'package:flutter/material.dart';
import 'package:weather_app/screen/WeatherScreen.dart';
import 'package:weather_app/screen/location_weather.dart';
import 'package:weather_app/utilities/constants.dart';

class ScreenWeather extends StatefulWidget {
  const ScreenWeather({super.key});

  @override
  State<ScreenWeather> createState() => _ScreenWeatherState();
}

class _ScreenWeatherState extends State<ScreenWeather> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
        constraints: const BoxConstraints.expand(),
        //margin: const EdgeInsets.only(left: 50, right: 50),
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/weather.jpeg'),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(
                      height: 50,
                      child: Image(
                        image: AssetImage('images/weather.png'),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Weather App',
                      style: kTempTextStyle,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(left: 50, right: 50),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 100,
                        ),
                        SizedBox(
                          height: 100,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WeatherScreen(),
                                ),
                              );
                            },
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.location_city,
                                  size: 50.0,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  'City Weather',
                                  style: kButtonTextStyle,
                                )
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 75,
                        ),
                        SizedBox(
                          height: 100,
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LocationScreen(),
                                ),
                              );
                            },
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.map_sharp,
                                  size: 50.0,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  'Location Weather',
                                  style: kButtonTextStyle,
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
