part of 'weather_bloc_bloc.dart';

sealed class WeatherBlocEvent extends Equatable {
  const WeatherBlocEvent();

  @override
  List<Object> get props => [];
}
class FetWeather extends WeatherBlocEvent {
  final Position position;
  const FetWeather(this.position);

 
  @override
  List<Object> get props =>[position];
  
}
