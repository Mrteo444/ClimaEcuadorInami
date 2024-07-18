import 'dart:ui';

import 'package:ecuador_clima/ui/clima.dart';
import 'package:ecuador_clima/ui/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:ecuador_clima/ui/utils.dart' as utils;

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        // Agregado SingleChildScrollView aquí
        child: Padding(
          padding: const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
          child: Stack(
            children: [
              Align(
                alignment: AlignmentDirectional(3, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(-3, -0.3),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.deepPurple,
                  ),
                ),
              ),
              Align(
                alignment: AlignmentDirectional(0, -1.2),
                child: Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 235, 252, 4),
                  ),
                ),
              ),
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                  child: Container(
                    decoration:
                        const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0)),
                  ),
                ),
              ),
              BlocBuilder<WeatherBlocBloc, WeatherState>(
                builder: (context, state) {
                  if (state is WeatherLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is WeatherLoaded) {
                    final weatherMain = state.weatherData["weatherMain"];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            '📍 ${state.weatherData["province"]}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text(
                            'Localidad ${state.weatherData["locality"]}',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        // Image.asset('assets/clear.png'),
                        Center(
                          child: Image.asset(
                            'assets/clear.png',
                            width: 155, // Ajusta el ancho según tu preferencia
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              '  ${state.weatherData["forecast_first_day"]["tmp_max"]} ° ',
                              style: const TextStyle(
                                color: Color.fromARGB(255, 225, 81, 81),
                                fontSize: 55,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            weatherMain != null
                                ? weatherMain.toUpperCase()
                                : 'Temperatura',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${utils.getFormattedWeekday()}',
                                style: TextStyle(
                                  color: Colors.white, // Cambiado a blanco
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              SizedBox(
                                  height:
                                      8), // Separación entre el día de la semana y la hora
                              Text(
                                '${utils.getFormattedTime()}',
                                style: TextStyle(
                                  color: Colors.white, // Cambiado a blanco
                                  fontSize: 16,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        Column(
                          children: [
                            Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Image.asset(
                                        'assets/sleet.png',
                                        scale: 5,
                                      ),
                                      const SizedBox(height: 3),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            'frio',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 28,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(height: 6),
                                          Text(
                                            '10.10 am',
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Column(
                                    children: [
                                      Image.asset(
                                        'assets/lightrain.png',
                                        scale: 8,
                                      ),
                                      const SizedBox(height: 5),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            'Lluvia',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 28,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(height: 6),
                                          Text(
                                            '10.10 am',
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 5.0),
                              child: Divider(
                                color: Colors.white,
                              ),
                            ),
                            const Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(height: 5),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '🔥 ',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 28,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(height: 6),
                                          Text(
                                            '10.10 am',
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 45,
                                  ),
                                  Column(
                                    children: [
                                      SizedBox(height: 5),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '🥶',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 28,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          SizedBox(height: 6),
                                          Text(
                                            '10.10 am',
                                            style: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  } else if (state is WeatherError) {
                    return Center(
                      child: Text(
                        state.message,
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    );
                  } else {
                    return Center(
                      child: Text(
                        'No hay datos disponibles',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    );
                  }
                },
              ),
              Positioned(
                top: 10,
                right: 10,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Welcome(),
                      ),
                    );
                  },
                  child: Text('📍'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
