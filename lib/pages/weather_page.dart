import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_service.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {

  //api key
  final _weatherService = WeatherService(dotenv.env['API_KEY']!);


  Weather? _weather;
  //fetch weather
  _fetchWeather() async {
    String cityName = _weatherService.nextCity();
    // print("Test 1");

    //get weather
    try {
      // print("Test 2");
      print(_weatherService.getWeather(cityName));
      _weather = await _weatherService.getWeather(cityName);
      // print("Test 3");
      //jsonDecode(weather.toString());
      setState(() {
        // print("Test 4");
         //_weather?.cityName = weather?[0];
      });

      //any error
    } catch (e) {
      print("Error occur");
    }
  }

String getWeatherAnimation(String? mainCondition){
    if(mainCondition == null)return 'assets/unknown.json';
    print("mainCondition:$mainCondition");
    switch(mainCondition.toLowerCase()){
      case 'clouds':
      case 'mist':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloudy.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
        return 'assets/rain.json';
      case 'thunderstorm':
        return 'assets/thunder.json';
      case 'clear':
        return 'assets/sunny.json';
      default:

        return 'assets/rain.json';


    }
}


  @override
  void initState() {
    super.initState();

    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Color.fromARGB(255, 255, 197, 197),
      floatingActionButton: FloatingActionButton.small(onPressed: _fetchWeather,backgroundColor: Color.fromARGB(255, 199, 220, 167),),
      body: Center(
        
        child: Column(
          
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_weather?.cityName ?? "Loading city..."
              ,style: const TextStyle(fontSize: 40,color: Color.fromARGB(255, 255, 235, 216),shadows: <Shadow>[
        Shadow(offset: Offset(2.5, 2.5),blurRadius: 3.0,color: Color.fromARGB(255, 199, 220, 167),)],),),

             Padding(
               padding: const EdgeInsets.only(top: 10,bottom: 20),
               child: Center(child: Lottie.asset(getWeatherAnimation(_weather?.temperature))),
             ),

             Text('${_weather?.mainCondition} C',style: const TextStyle(fontSize: 24,color: Color.fromARGB(255, 255, 235, 216),shadows: <Shadow>[
        Shadow(offset: Offset(2.5, 2.5),blurRadius: 3.0,color: Color.fromARGB(255, 199, 220, 167),)],)),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('${_weather?.temperature}',style: const TextStyle(fontSize: 18, )),
            ),
          ],
        ),
      ),
    );
  }
}
