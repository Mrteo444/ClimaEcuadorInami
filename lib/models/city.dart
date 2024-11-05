import 'dart:convert';
import 'package:http/http.dart' as http;

class City {
  bool isSelected;
  final String city;
  final String country;
  final bool isDefault;
  final int? tmpMax;
  final int? tmpMin;
  final WeatherCondition? condClimMorning; // Nueva propiedad para condiciones climáticas

  City({
    required this.isSelected,
    required this.city,
    required this.country,
    required this.isDefault,
    this.tmpMax,
    this.tmpMin,
    this.condClimMorning, // Nueva propiedad
  });

  // Constructor para convertir JSON en City
  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      isSelected: false,
      city: json['province'],
      country: 'Ecuador',
      isDefault: false,
      tmpMax: json['forecast_first_day']['tmp_max'],
      tmpMin: json['forecast_first_day']['tmp_min'],
      condClimMorning: json['forecast_first_day']['cond_Clim_Morning'] != null 
          ? WeatherCondition.fromJson(json['forecast_first_day']['cond_Clim_Morning']) 
          : null, // Inicializa la nueva propiedad
    );
  }

  // Método para obtener las ciudades desde la API
  static Future<List<City>> fetchCitiesFromApi() async {
    final response = await http.get(Uri.parse('https://inamhi.gob.ec/api_rest/data_forecast/test-forecast/'));

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => City.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load cities');
    }
  }

  // Listado predeterminado de ciudades
  static List<City> citiesList = [
    City(
      isSelected: false,
      city: 'Esmeraldas',
      country: 'Ecuador',
      isDefault: true,
    ),
    // Agrega más ciudades predeterminadas si es necesario
  ];

  // Obtener las ciudades seleccionadas
  static List<City> getSelectedCities() {
    return citiesList.where((city) => city.isSelected == true).toList();
  }
}

// Clase para representar las condiciones climáticas
class WeatherCondition {
  final int id;
  final String name;
  final String description;
  final String path;

  WeatherCondition({
    required this.id,
    required this.name,
    required this.description,
    required this.path,
  });

  factory WeatherCondition.fromJson(Map<String, dynamic> json) {
    return WeatherCondition(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      path: json['path'],
    );
  }
}
