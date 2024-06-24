import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:ecuador_clima/bloc/weather_bloc_bloc.dart';
import 'package:ecuador_clima/ui/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FutureBuilder<Position>(
        future: _determinePosition(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text('Error: ${snapshot.error}'),
              ),
            );
          } else if (snapshot.hasData) {
            // Imprimir la geolocalización en la consola
            print('Latitud: ${snapshot.data!.latitude}, Longitud: ${snapshot.data!.longitude}');

            // Obtener datos de la API y imprimir en consola
            fetchWeatherData(snapshot.data!);

            return BlocProvider<WeatherBlocBloc>(
              create: (context) => WeatherBlocBloc()
                ..add(
                  FetWeather(snapshot.data!),
                ),
              child: const Home(),
            );
          } else {
            return const Scaffold(
              body: Center(
                child: Text('No se pudo determinar la posición'),
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> fetchWeatherData(Position position) async {
    final url = Uri.parse('https://inamhi.gob.ec/api_rest/data_forecast/test-forecast/');

    Map<dynamic, dynamic>? minimoList;
    num tempo = 10000;

    try {
      print(' XXXANDROID Latitud: ${position.latitude}, Longitud: ${position.longitude}');

      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> dataList = json.decode(response.body);

        for (var item in dataList) {
          if (item is Map<dynamic, dynamic>) {
            // Ejemplo de acceso a una propiedad específica
            if (item.containsKey("province")) {
              print('Province: ${item["province"]}');
              print('id: ${item["id"]}');
              print('latitude: ${item["latitude"]}');
              print('longitude: ${item["longitude"]}');

              num disstanciax = pow(position.longitude - item["longitude"], 2);
              num disstanciay = pow(position.latitude - item["latitude"], 2);

              num totaldis = pow(disstanciax + disstanciay, 0.5);

              if (totaldis < tempo) {
                minimoList = item;
                print('Provincexxx: ${minimoList["province"]}');
                tempo = totaldis;
              }

              print("ladistancia: $totaldis");
            } else {
              print('Elemento sin propiedad "province"');
            }
            print('--------------');
          } else {
            print('Elemento no es un Map válido');
          }
        }

        // Imprimir la provincia más cercana con el mensaje especificado
        if (minimoList != null) {
          print('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');
          print('EL USUARIO ESTA EN ESTA PARTE!!!!!! Provincia: ${minimoList["province"]}');
          print('EL USUARIO ESTA EN ESTA PARTE!!!!!! Provincia: ${minimoList["locality"]}');
          print('EL USUARIO ESTA EN ESTA PARTE!!!!!! Provincia: ${minimoList["id"]}');
          print('!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!');


        }

      } else {
        print('Error al obtener los datos de la API: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw 'Los servicios de ubicación están desactivados.';
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'Los permisos de ubicación fueron denegados';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw 'Los permisos de ubicación están permanentemente denegados, no podemos solicitar permisos.';
    }

    return await Geolocator.getCurrentPosition();
  }
}
