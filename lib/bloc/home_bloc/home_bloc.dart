import 'package:bloc_rest/services/connectivity_services.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:bloc_rest/services/knowello_services.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final KnowelloService _knowelloService;
  final ConnectivityServices _connectivityServices;

  HomeBloc(this._knowelloService, this._connectivityServices)
      : super(HomeLoadingState()) {
    _connectivityServices.connectivityStream.stream.listen((event) {
      if (event == ConnectivityResult.none) {
        add(NoInternetEvent());
      } else {
        add(LoadApiEvent());
      }
    });
    on<LoadApiEvent>((event, emit) async {
      emit(HomeLoadingState());
      final data = await _knowelloService.getKnowelloGram();
      emit(HomeLoadedState(data));
    });

    on<NoInternetEvent>((event, emit) {
      emit(HomeNoInternetState());
    });
  }
}
