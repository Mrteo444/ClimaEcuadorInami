class City{
  bool isSelected;
  final String city;
  final String country;
  final bool isDefault;

  City({required this.isSelected, required this.city, required this.country, required this.isDefault});

  //List of Cities data
  static List<City> citiesList = [
     City(
      isSelected: false,
      city: 'Esmeraldas',
      country: 'Ecuador',
      isDefault: true,
    ),
    City(
      isSelected: false,
      city: 'Santo Domingo',
      country: 'Ecuador',
      isDefault: false,
    ),
    City(
      isSelected: false,
      city: 'Quevedo',
      country: 'Ecuador',
      isDefault: false,
    ),
    City(
      isSelected: false,
      city: 'Manta',
      country: 'Ecuador',
      isDefault: false,
    ),
    City(
      isSelected: false,
      city: 'Guayaquil',
      country: 'Ecuador',
      isDefault: false,
    ),
    City(
      isSelected: false,
      city: 'Salinas',
      country: 'Ecuador',
      isDefault: false,
    ),
    City(
      isSelected: false,
      city: 'Sta. Rosa',
      country: 'Ecuador',
      isDefault: false,
    ),
    City(
      isSelected: false,
      city: 'Tulcán',
      country: 'Ecuador',
      isDefault: false,
    ),
    City(
      isSelected: false,
      city: 'Quito',
      country: 'Ecuador',
      isDefault: false,
    ),
    City(
      isSelected: false,
      city: 'Latacunga',
      country: 'Ecuador',
      isDefault: false,
    ),
    City(
      isSelected: false,
      city: 'Ambato',
      country: 'Ecuador',
      isDefault: false,
    ),
    City(
      isSelected: false,
      city: 'Riobamba',
      country: 'Ecuador',
      isDefault: false,
    ),
    City(
      isSelected: false,
      city: 'Cuenca',
      country: 'Ecuador',
      isDefault: false,
    ),
    City(
      isSelected: false,
      city: 'Loja',
      country: 'Ecuador',
      isDefault: false,
    ),
    City(
      isSelected: false,
      city: 'Nueva Loja',
      country: 'Ecuador',
      isDefault: false,
    ),
    City(
      isSelected: false,
      city: 'El Coca',
      country: 'Ecuador',
      isDefault: false,
    ),
    City(
      isSelected: false,
      city: 'Tena',
      country: 'Ecuador',
      isDefault: false,
    ),
    City(
      isSelected: false,
      city: 'Shell Mera',
      country: 'Ecuador',
      isDefault: false,
    ),
    City(
      isSelected: false,
      city: 'Macas',
      country: 'Ecuador',
      isDefault: false,
    ),
    City(
      isSelected: false,
      city: 'Zamora',
      country: 'Ecuador',
      isDefault: false,
    ),
    City(
      isSelected: false,
      city: 'San Cristobal',
      country: 'Ecuador',
      isDefault: false,
    ),
    City(
      isSelected: false,
      city: 'Baltra',
      country: 'Ecuador',
      isDefault: false,
    ),
  ];

  //Get the selected cities
  static List<City> getSelectedCities(){
    List<City> selectedCities = City.citiesList;
    return selectedCities
        .where((city) => city.isSelected == true)
        .toList();
  }
}