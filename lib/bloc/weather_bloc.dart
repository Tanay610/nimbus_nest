import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:nimbus_nest/data/repository/weather_repository.dart';
import 'package:nimbus_nest/models/weather_model.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepo weatherRepository;
  WeatherBloc(this.weatherRepository) : super(WeatherInitial()) {
      on<WeatherFetched>((_getCurrentWeather));
  }

  Future<void> _getCurrentWeather(WeatherFetched event,
    Emitter<WeatherState> emit) async {
      emit(WeatherLoading());
      try {
      final weather = await weatherRepository.getCurrentWeather();
      emit(WeatherSuccess(weatherModel: weather));
      } catch (e) {
        emit(WeatherFailure(e.toString()));
        
      }
    
  }
}
