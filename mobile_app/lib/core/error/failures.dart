import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  // If the subclasses have some properties, they'll get passed to this constructor
  // so that Equatable can perform value comparison.
  // const Failure([List properties = const <dynamic>[]]) : super(properties);
  const Failure([List properties = const <dynamic>[]]);

  @override
  List<Object> get props => [];
}

// General failures
class ServerFailure extends Failure {
  final Response? response;

  const ServerFailure({this.response});

  @override
  String toString() {
    return response != null
        ? newMapFailureToStringList(failure: this)
        : 'There was a problem with the server';
  }
}

class CacheFailure extends Failure {
  final Response? response;

  const CacheFailure({this.response});

  @override
  String toString() {
    //FIXME: A BETTER NAMING FOR UNNAMED CACHE FAILURE MESSAGES
    return response != null
        ? newMapFailureToStringList(failure: this)
        : 'There was a problem with the local cache';
  }
}

class ConnectionFailure extends Failure {
  final Response? response;

  const ConnectionFailure({this.response});

  @override
  String toString() {
    return response != null
        ? newMapFailureToStringList(failure: this)
        : 'No connection';
  }
}

class OtherFailure extends Failure {
  final String? message;
  const OtherFailure({this.message});

  @override
  String toString() {
    return message != null
        ? newMapFailureToStringList(failure: this)
        : 'An error occurred';
  }
}

List<String> mapFailureToStringList({required Failure failure}) {
  List<String> result = [];
  if (failure is CacheFailure) {
    //TODO: IMPLEMENT CACHE FAILURE MAPS
    result.add(failure.toString());
  } else if (failure is ConnectionFailure) {
    //TODO: IMPLEMENT CONNECTION FAILURE MAPS
    result.add(failure.toString());
  } else if (failure is ServerFailure) {
    // print('RESPONSE:');
    // print(failure.response);
    // print(failure.response.runtimeType);
    //FIXME: TRY CATCH HERE IS SOLELY TEMPORARY, REMOVE IT AFTER RESPONSES ARE STANDARDIZED
    try {
      final Map<String, dynamic> list = failure.response!.data['errors'];
      list.forEach((key, value) {
        //this is for casting purposes
        if (value.runtimeType == List) {
          for (value in value) {
            result.add(value);
          }
        }
        if (value.runtimeType == String) {
          result.add(value);
        }
      });
    } catch (_) {
      return <String>[failure.response.toString()];
    }
  }
  return result;
}

String newMapFailureToStringList({required Failure failure}) {
  List<String> result = [];
  if (failure is CacheFailure) {
    //TODO: IMPLEMENT CACHE FAILURE MAPS
    result.add(failure.toString());
  } else if (failure is ConnectionFailure) {
    //TODO: IMPLEMENT CONNECTION FAILURE MAPS
    result.add(failure.toString());
  } else if (failure is ServerFailure) {
    // print('RESPONSE:');
    // print(failure.response);
    // print(failure.response.runtimeType);
    //FIXME: TRY CATCH HERE IS SOLELY TEMPORARY, REMOVE IT AFTER RESPONSES ARE STANDARDIZED
    try {
      final Map<String, dynamic> list =
          failure.response!.data['errors'] ?? failure.response!.data['error'];
      list.forEach((key, value) {
        //this is for casting purposes
        if (value.runtimeType == List) {
          for (value in value) {
            if (key == 'detail' || key == 'details') {
              result.add(value);
            } else if (key == 'entity') {
              result.add('user $value');
            } else {
              result.add('$key $value');
            }
          }
        } else if (value.runtimeType == String) {
          if (key == 'detail' || key == 'details') {
            result.add(value);
          } else if (key == 'entity') {
            result.add('user $value');
          } else {
            result.add('$key $value');
          }
        } else {
          // if it is map
          if (key == 'detail' || key == 'details') {
            recursionToString(value).forEach((value) {
              result.add(value);
            });
          } else if (key == 'entity') {
            recursionToString(value).forEach((value) {
              result.add('user $value');
            });
          } else {
            recursionToString(value).forEach((value) {
              result.add('$key $value');
            });
          }
        }
      });
    } catch (_) {
      return failure.response.toString();
    }
  }
  return result.join('\n');
}

//it is used to turn maps into string list
List<String> recursionToString(Map<String, dynamic> response) {
  List<String> result = [];
  response.forEach((key, value) {
    //this is for casting purposes
    if (value.runtimeType == List) {
      for (value in value) {
        if (key == 'detail' || key == 'details') {
          result.add(value);
        } else if (key == 'entity') {
          result.add('user $value');
        } else {
          result.add('$key $value');
        }
      }
    } else if (value.runtimeType == String) {
      if (key == 'detail' || key == 'details') {
        result.add(value);
      } else if (key == 'entity') {
        result.add('user $value');
      } else {
        result.add('$key $value');
      }
    } else {
      // if it is a map
      if (key == 'detail' || key == 'details') {
        // do nothing
      } else if (key == 'entity') {
        result.add('');
      } else {
        result.add(key);
      }
      result.addAll(recursionToString(value));
    }
  });
  return result;
}
