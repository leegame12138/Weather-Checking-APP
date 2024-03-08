import 'dart:convert';
import 'dart:math';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

import '../models/weather_model.dart';
import 'package:http/http.dart' as http;

class WeatherService{
  static const BASE_URL = 'https://api.openweathermap.org/data/2.5/weather';
  final String apiKey;

  WeatherService(this.apiKey);

  Future<Weather> getWeather(String cityName) async {
  //  print("Test2.1");
    final response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$apiKey'));
    //.get(Uri.parse('$BASE_URL?q=London&limit=5&appid=$apiKey'));
  //  print("Test2.2");


    if(response.statusCode == 200) {
  //    print("Test2.3");
      return Weather.fromJson(jsonDecode(response.body));
    }else {
  //    print("Test2.4");
      throw Exception(response.statusCode);

    }
  }

  Future<String> getCurrentCity()async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    //fetch position
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    //print('position');

    //print(position);

    List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);

    String? city = placemarks[0].name;
    //print(placemarks[0].administrativeArea);
    //print(placemarks[0].country);

    //print("TEST city: ");
    //print(city);
    return nextCity();
  }

  String nextCity(){
    var intValue = Random().nextInt(10);
    print(intValue);
    switch(intValue){
      case 0:
        return 'Tokyo';
      case 1:
        return 'Dubai';
      case 2:
        return 'George Town';
      case 3:
        return 'Guangzhou';
      case 4:
        return 'Ho Chi Minh City';
      case 5:
        return 'Jakarta';
      case 6:
        return 'Kawasaki';
      case 7:
        return 'Kota Bharu';
      case 8:
        return 'Mexico City';
      case 9:
        return 'Ottawa';
      default:
        return 'Cairo';


    }
  }


}