class Weather {

  final String cityName;
  final String temperature;
  final String mainCondition;

  Weather({
    required this.cityName,
    required this.mainCondition,
    required this.temperature,
  });


  factory Weather.fromJson(Map<String, dynamic> json){
    // print("Test2.3.1");
    // print(json);
    // print(json['name']);
    // print(json['main']['temp']);
    // print(json['weather'][0]['main']);
    // Weather( cityName: json['name'],
    //   mainCondition: json['main']['temp'].toString(),);

      // temperature: json['weather'][0]['main'])
    return Weather( cityName: json['name'],
      mainCondition: json['main']['temp'].toString(),
       temperature: json['weather'][0]['main'],
    );
  }
}
