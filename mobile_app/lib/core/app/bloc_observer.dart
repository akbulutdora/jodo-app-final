import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jodo_app/core/app_logging.dart';

/// [AppBlocObserver] is used to log the activity of the blocs.
class AppBlocObserver extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    if (kDebugMode) {
      print('Event added: $event');
    }
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    AppLogging.logger.e('Error', error, stackTrace);
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    if (!bloc.runtimeType.toString().toLowerCase().contains('bloc')) {
      AppLogging.logger.v('Current state: ${change.currentState}\n'
          'Next state: ${change.nextState}');
    }
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    if (!transition.event.toString().toLowerCase().contains('initialize()')) {
      AppLogging.logger.d('Current state: ${transition.currentState},\n'
          'Event: ${transition.event}\n'
          'Next state: ${transition.nextState}');
    }
  }
}
