import 'package:ecuador_clima/main.dart';
import 'package:ecuador_clima/models/city.dart';
import 'package:ecuador_clima/models/constants.dart';
import 'package:ecuador_clima/ui/home.dart';
import 'package:flutter/material.dart';

class Welcome extends StatefulWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  List<City> cities = [];

  @override
  void initState() {
    super.initState();
    fetchCities();
  }

  Future<void> fetchCities() async {
    try {
      List<City> apiCities = await City.fetchCitiesFromApi();
      setState(() {
        cities = apiCities;
      });
    } catch (e) {
      print('Error al cargar ciudades: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Constants myConstants = Constants();
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0), // Celeste oscuro
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: myConstants.secondaryColor,
        title: const Text('Ciudades Disponibles', style: TextStyle(color: Color.fromARGB(255, 126, 11, 11))),
        actions: [
          IconButton(
            icon: const Icon(Icons.home, color: Color.fromARGB(255, 35, 72, 167)),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => MyApp()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: cities.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: const EdgeInsets.only(left: 10, top: 20, right: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: size.height * .08,
            width: size.width,
            decoration: BoxDecoration(
              border: cities[index].isSelected == true
                  ? Border.all(color: myConstants.secondaryColor.withOpacity(.6), width: 2)
                  : Border.all(color: const Color.fromARGB(255, 10, 10, 10)),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  color: myConstants.primaryColor.withOpacity(.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                )
              ],
            ),
            child: Row(
              children: [
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      cities[index].city,
                      style: TextStyle(
                        fontSize: 16,
                        color: cities[index].isSelected ? myConstants.primaryColor : Colors.white, // Blanco o Celeste
                      ),
                    ),
                    Text(
                      'Máx: ${cities[index].tmpMax ?? 'N/A'}°C / Mín: ${cities[index].tmpMin ?? 'N/A'}°C',
                      style: const TextStyle(color: Color.fromARGB(255, 158, 158, 158)), // Gris suave
                    ),
                  ],
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.add, color: Colors.cyan), // Celeste para el icono
                  onPressed: () {
                    // Muestra la alerta con los datos climáticos
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          backgroundColor: Colors.black, // Fondo de la alerta negro
                          title: Center( // Centrar el título
                            child: Text(
                              cities[index].city,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: myConstants.primaryColor, // Celeste
                              ),
                            ),
                          ),
                          content: SingleChildScrollView(
                            child: ListBody(
                              children: [
                                Text(
                                  'Temperaturas:',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.white, // Blanco para texto principal
                                  ),
                                ),
                                Text('Máx: ${cities[index].tmpMax ?? 'N/A'}°C', style: TextStyle(color: Colors.white)),
                                Text('Mín: ${cities[index].tmpMin ?? 'N/A'}°C', style: TextStyle(color: Colors.white)),
                                if (cities[index].condClimMorning != null) ...[
                                  const SizedBox(height: 10),
                                  Text(
                                    'Condición de la mañana:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                      color: Colors.white, // Blanco
                                    ),
                                  ),
                                  Text('${cities[index].condClimMorning!.name}', style: TextStyle(color: Colors.white)),
                                  Text('${cities[index].condClimMorning!.description}', style: TextStyle(color: Colors.white)),
                                ],
                              ],
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'Cerrar',
                                style: TextStyle(
                                  color: Colors.cyan, // Celeste
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
