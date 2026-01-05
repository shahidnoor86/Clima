import 'package:http/http.dart' as http;
import 'dart:convert';

class NetworkHelper {
  NetworkHelper(this.url);

  final String url;

  Future getData() async {
    final response = await http.get(Uri.parse(url));
    print(response.body);
    if (response.statusCode == 200) {
      String data = response.body;

      return jsonDecode(data);
    } else {
      print(response.statusCode);
    }

    /* return jsonDecode(
        '{"coord":{"lon":77.6033,"lat":12.9762},"weather":[{"id":801,"main":"Clouds","description":"few clouds","icon":"02d"}],"base":"stations","main":{"temp":25.66,"feels_like":25.69,"temp_min":24.9,"temp_max":26.12,"pressure":1013,"humidity":54,"sea_level":1013,"grnd_level":915},"visibility":6000,"wind":{"speed":4.92,"deg":108,"gust":11.62},"clouds":{"all":20},"dt":1767355765,"sys":{"type":2,"id":2017753,"country":"IN","sunrise":1767316317,"sunset":1767357276},"timezone":19800,"id":1277333,"name":"Yelahanka","cod":200}'); */
  }
}
