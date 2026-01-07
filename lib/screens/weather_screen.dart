import 'package:clima/models/weather_data_model.dart';
import 'package:clima/screens/city_screen.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/utilities/utils.dart';
import 'package:clima/widgets/dashboard_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key, required this.locationWeather});
  final locationWeather;

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  WeatherModel weather = WeatherModel();
  int temperature = 0;
  String weatherIcon = "";
  String weatherMessage = "";
  String cityName = '';
  DateModel? dateTimeData;
  WeatherDateModel weatherDateModel = WeatherDateModel(
    windSpeed: 0,
    tempMax: 0,
    tempMin: 0,
    humidity: 0,
    pressure: 0,
    feelsLike: 0,
  );

  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);
  }

  Future<bool> isLocationPermissionGranted() async {
    bool status = await Permission.location.isGranted;
    return status;
  }

  void updateUI(dynamic weatherData) async {
    bool locationAccess = await isLocationPermissionGranted();
    setState(() {
      if (weatherData == null) {
        weatherMessage = 'Unable to get weather data.';
        return;
      } else if (!locationAccess) {
        weatherMessage = 'Location permission required. Search by city name.';
        return;
      } else {
        temperature = 0;
        weatherIcon = 'Error';
        cityName = '';
      }
      double temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weather.getWeatherIcon(condition);
      weatherMessage = weather.getMessage(temperature);
      cityName = weatherData['name'];
      dateTimeData = DateTimeUtils.formatFromTimestamp(
        widget.locationWeather['dt'],
      );
      weatherDateModel = WeatherDateModel(
        windSpeed: weatherData['wind']['speed'],
        tempMax: weatherData['main']['temp_max'],
        tempMin: weatherData['main']['temp_min'],
        humidity: weatherData['main']['humidity'],
        pressure: weatherData['main']['pressure'],
        feelsLike: weatherData['main']['feels_like'],
      );
    });
  }

  DateTime covertTimestampToDateTime(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return date;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(color: Colors.lightBlue),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async {
                      var weatherData = await weather.getLocationWeather();
                      setState(() {
                        updateUI(weatherData);
                      });
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 30.0,
                      color: Colors.indigo,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      var typedName = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return CityScreen();
                          },
                        ),
                      );
                      if (typedName != null) {
                        var weatherData = await weather.getCityWeather(
                          typedName,
                        );
                        setState(() {
                          updateUI(weatherData);
                        });
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 30.0,
                      color: Colors.indigo,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Expanded(
                child: Container(
                  child: Column(
                    children: [
                      Text(
                        cityName,
                        style: TextStyle(fontSize: 22.0, color: Colors.white),
                      ),
                      SizedBox(height: 5.0),
                      Text(
                        '$temperature°C',
                        style: TextStyle(fontSize: 48.0, color: Colors.white),
                      ),
                      SizedBox(height: 5.0),
                      widget.locationWeather != null
                          ? Text(
                              widget.locationWeather?['weather'][0]['main'] ??
                                  "",
                              style: TextStyle(
                                fontSize: 22.0,
                                color: Colors.white,
                              ),
                            )
                          : Text(""),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(dateTimeData?.day ?? ""),
                          SizedBox(width: 5),
                          Text(dateTimeData?.date ?? ""),
                        ],
                      ),
                      Text(dateTimeData?.time ?? ""),
                      SizedBox(height: 15),
                      Text(
                        weatherIcon.isNotEmpty ? weatherIcon : "",
                        style: TextStyle(fontSize: 64.0, color: Colors.white),
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        weatherMessage.isNotEmpty ? weatherMessage : "",
                        style: TextStyle(fontSize: 18.0, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 30.0),
              DashboardDataWidget(
                weatherDateModel: weatherDateModel,
                isLocationGranted: weatherIcon == 'Error' ? false : true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
