import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';

part 'weather_bloc_event.dart';
part 'weather_bloc_state.dart';

class WeatherBlocBloc extends Bloc<WeatherBlocEvent, WeatherBlocState> {
  WeatherBlocBloc() : super(WeatherBlocInitial()) {
    on<FetWeather>((event, emit) async {
      emit(WeatherBlocLoading());
      try {
        final response = await http.get(
          Uri.parse('https://inamhi.gob.ec/api_rest/data_forecast/test-forecast/'),
        );

        if (response.statusCode == 200) {
          final data = jsonDecode(response.body);
          // Mapear los datos recibidos a un modelo Weather
          Weather weather = Weather.fromJson(data);
          emit(WeatherBlocSuccess(weather));
        } else {
          emit(WeatherBlocFailure());
        }
      } catch (e) {
        emit(WeatherBlocFailure());
      }
    });
  }
}

// Asegúrate de tener un modelo Weather que pueda mapear los datos de la API
class Weather {
  final String areaName;
  final double temperature;
  final String weatherMain;

  Weather({required this.areaName, required this.temperature, required this.weatherMain});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      areaName: json['locality'],
      temperature: json['forecast_first_day']['tmp_max'], // Ajusta según tu estructura de datos
      weatherMain: json['forecast_first_day']['rd_Uv'].toString(), // Ajusta según tu estructura de datos
    );
  }
}
