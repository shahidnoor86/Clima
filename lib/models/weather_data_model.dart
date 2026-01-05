class WeatherDateModel {
  double? windSpeed;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? humidity;
  double? feelsLike;

  WeatherDateModel(
      {this.windSpeed,
      this.tempMin,
      this.tempMax,
      this.pressure,
      this.humidity,
      this.feelsLike});

  WeatherDateModel.fromJson(Map<String, dynamic> json) {
    windSpeed = json['windSpeed'];
    tempMin = json['temp_min'];
    tempMax = json['temp_max'];
    pressure = json['pressure'];
    humidity = json['humidity'];
    feelsLike = json['feels_like'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['windSpeed'] = this.windSpeed;
    data['temp_min'] = this.tempMin;
    data['temp_max'] = this.tempMax;
    data['pressure'] = this.pressure;
    data['humidity'] = this.humidity;
    data['feels_like'] = this.feelsLike;
    return data;
  }
}
