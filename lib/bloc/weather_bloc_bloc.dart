import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Define los eventos
abstract class WeatherEvent extends Equatable {
  const WeatherEvent();
}

class FetWeather extends WeatherEvent {
  final Position position;

  const FetWeather(this.position);

  @override
  List<Object> get props => [position];
}

// Define los estados
abstract class WeatherState extends Equatable {
  const WeatherState();
}

class WeatherInitial extends WeatherState {
  @override
  List<Object> get props => [];
}

class WeatherLoading extends WeatherState {
  @override
  List<Object> get props => [];
}

class WeatherLoaded extends WeatherState {
  final Map<dynamic, dynamic> weatherData;

  const WeatherLoaded(this.weatherData);

  @override
  List<Object> get props => [weatherData];
}

class WeatherError extends WeatherState {
  final String message;

  const WeatherError(this.message);

  @override
  List<Object> get props => [message];
}

// Define el BLoC
class WeatherBlocBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBlocBloc() : super(WeatherInitial()) {
    on<FetWeather>(_onFetchWeather);
  }

  Future<void> _onFetchWeather(FetWeather event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    try {
      final weatherData = await fetchWeatherData(event.position);
      emit(WeatherLoaded(weatherData));
    } catch (e) {
      emit(WeatherError(e.toString()));
    }
  }

  Future<Map<dynamic, dynamic>> fetchWeatherData(Position position) async {
    final url = Uri.parse('https://inamhi.gob.ec/api_rest/data_forecast/test-forecast/');
    Map<dynamic, dynamic>? minimoList;
    num tempo = 10000;

    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> dataList = json.decode(response.body);
        for (var item in dataList) {
          if (item is Map<dynamic, dynamic>) {
            if (item.containsKey("province")) {
              num disstanciax = pow(position.longitude - item["longitude"], 2);
              num disstanciay = pow(position.latitude - item["latitude"], 2);
              num totaldis = pow(disstanciax + disstanciay, 0.5);

              if (totaldis < tempo) {
                minimoList = item;
                tempo = totaldis;
              }
            }
          }
        }
        if (minimoList != null) {
          return minimoList;
        } else {
          throw 'No se encontró una provincia cercana';
        }
      } else {
        throw 'Error al obtener los datos de la API: ${response.statusCode}';
      }
    } catch (e) {
      throw 'Error: $e';
    }
  }
}
