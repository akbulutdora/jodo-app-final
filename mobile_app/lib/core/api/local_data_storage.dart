import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jodo_app/core/environment.dart';
import 'package:jodo_app/core/error/exception.dart';
import 'package:jodo_app/models/jodo/jodo.dart';
import 'package:rxdart/subjects.dart';

class LocalDataStorage {
  LocalDataStorage({
    required FlutterSecureStorage plugin,
  }) : _plugin = plugin {
    _init();
  }

  final FlutterSecureStorage _plugin;

  /// this stream controller is used to store the jodos in memory.
  final _jodoStreamController = BehaviorSubject<List<Jodo>>.seeded(const []);


  /// The getter and setters of the storage plugin.
  Future<String?> _getValue(String key) async => await _plugin.read(key: key);

  Future<void> _setValue(String key, String value) =>
      _plugin.write(key: key, value: value);

  Future<void> _deleteAll() => _plugin.deleteAll();

  Future<void> _init() async {
    final jodosJson = await _getValue(Environment.kJodosCollectionKey);
    if (jodosJson != null) {
      final jodos = List<Map<dynamic, dynamic>>.from(
        json.decode(jodosJson) as List,
      )
          .map((jsonMap) => Jodo.fromJson(Map<String, dynamic>.from(jsonMap)))
          .toList();
      _jodoStreamController.add(jodos);
    } else {
      _jodoStreamController.add(const []);
    }
  }

  Stream<List<Jodo>> getJodos() => _jodoStreamController.asBroadcastStream();

  Future<void> saveJodo(Jodo jodo) {
    debugPrint('saveJodo: $jodo');
    final jodos = [..._jodoStreamController.value];
    final jodoIndex = jodos.indexWhere((t) => t.id == jodo.id);
    if (jodoIndex >= 0) {
      jodos[jodoIndex] = jodo;
    } else {
      jodos.add(jodo);
    }

    _jodoStreamController.add(jodos);
    return _setValue(Environment.kJodosCollectionKey, json.encode(jodos));
  }

  Future<void> deleteJodo(int id) async {
    final jodos = [..._jodoStreamController.value];
    final jodoIndex = jodos.indexWhere((t) => t.id == id);
    if (jodoIndex == -1) {
      throw JodoNotFoundException();
    } else {
      jodos.removeAt(jodoIndex);
      _jodoStreamController.add(jodos);
      return _setValue(Environment.kJodosCollectionKey, json.encode(jodos));
    }
  }

  Future<int> clearCompleted() async {
    final jodos = [..._jodoStreamController.value];
    final completedJodosAmount =
        jodos.where((t) => (t.completedAt != null)).length;
    jodos.removeWhere((t) => (t.completedAt != null));
    _jodoStreamController.add(jodos);
    await _setValue(Environment.kJodosCollectionKey, json.encode(jodos));
    return completedJodosAmount;
  }

  // TODO: Delete
  // Future<int> completeAll({required bool completed}) async {
  //   final jodos = [..._jodoStreamController.value];
  //   final changedJodosAmount = jodos.where((t) => t.completed != completed).length;
  //   final newJodos = [for (final jodo in jodos) jodo.copyWith(completed: completed)];
  //   _jodoStreamController.add(newJodos);
  //   await _setValue(Environment.kJodosCollectionKey, json.encode(newJodos));
  //   return changedJodosAmount;
  // }

  Future<int?> getSessionId() async {
    final id = await _getValue(Environment.kSessionKey);
    if (id != null) {
      return int.parse(id);
    } else {
      return null;
    }
  }

  Future<void> saveJodos(List<Jodo> jodos) async {
    await _setValue(Environment.kJodosCollectionKey, json.encode(jodos));
    _jodoStreamController.add(jodos);
  }

  Future<void> deleteAll() async {
    await _deleteAll();
    _jodoStreamController.add(const []);
  }
}
