import 'package:clima/models/weather_data_model.dart';
import 'package:clima/widgets/dashboard_item.dart';
import 'package:flutter/material.dart';

class DashboardDataWidget extends StatelessWidget {
  const DashboardDataWidget({
    super.key,
    required this.weatherDateModel,
    this.isLocationGranted = false,
  });
  final WeatherDateModel weatherDateModel;
  final bool isLocationGranted;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.circular(25),
      ),
      padding: EdgeInsets.all(20),
      child: isLocationGranted
          ? Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DashboardItem(
                      icon: Icons.thermostat,
                      label: "Feels like",
                      value: "${weatherDateModel.feelsLike} *C",
                    ),
                    DashboardItem(
                      icon: Icons.sunny,
                      label: "Max",
                      value: "${weatherDateModel.tempMax} *C",
                    ),
                    DashboardItem(
                      icon: Icons.thermostat,
                      label: "Min",
                      value: "${weatherDateModel.tempMin} *C",
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Divider(color: Colors.grey.shade300),
                SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DashboardItem(
                      icon: Icons.wind_power,
                      label: "Wind",
                      value: "${weatherDateModel.windSpeed} m/s",
                    ),
                    DashboardItem(
                      icon: Icons.water_drop_rounded,
                      label: "Humidity",
                      value: "${weatherDateModel.humidity}%",
                    ),
                    DashboardItem(
                      icon: Icons.air_rounded,
                      label: "Pressure",
                      value: "${weatherDateModel.pressure} hPa",
                    ),
                  ],
                ),
              ],
            )
          : Center(child: Text("Location permission not granted")),
    );
  }
}
