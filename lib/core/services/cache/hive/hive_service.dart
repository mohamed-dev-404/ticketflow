import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:ticketflow/core/services/cache/hive/hive_keys.dart';
import 'package:ticketflow/core/logging/app_logger.dart';
import 'package:ticketflow/features/tickets/data/models/ticket_model.dart';
import 'package:ticketflow/hive_registrar.g.dart';

///! ===================================================
///! HiveService
///! ===================================================
///* This service is a pure infrastructure layer for Hive.
///* It initializes Hive, registers adapters, opens boxes,
///* and exposes them via strongly-typed getters.
class HiveService {
  static final HiveService instance = HiveService._internal();

  HiveService._internal();

  bool _isInitialized = false;

  late Box<TicketModel> _ticketsBox;
  late Box<dynamic> _settingsBox;

  /// Must be called once at app startup
  Future<void> init() async {
    if (_isInitialized) return;

    await Hive.initFlutter();

    // Register Adapters using generated registrar
    Hive.registerAdapters();

    // Open necessary boxes
    _ticketsBox = await Hive.openBox<TicketModel>(HiveKeys.ticketsBox);
    _settingsBox = await Hive.openBox<dynamic>(HiveKeys.settingsBox);

    _isInitialized = true;

    AppLogger.success(
      'HiveService initialized successfully',
      tag: 'HiveService',
    );
  }

  void _ensureInitialized() {
    if (!_isInitialized) {
      throw StateError(
        'HiveService.init() must be called before accessing boxes.',
      );
    }
  }

  //! ===============================
  //! Box Getters
  //! ===============================

  Box<TicketModel> get ticketsBox {
    _ensureInitialized();
    return _ticketsBox;
  }

  Box<dynamic> get settingsBox {
    _ensureInitialized();
    return _settingsBox;
  }

  //! ===============================
  //! Infrastructure Methods (Generic Helpers)
  //! ===============================

  /// Puts a value into the box for the specified key
  Future<void> put<T>(Box<T> box, dynamic key, T value) async {
    _ensureInitialized();
    await box.put(key, value);
    AppLogger.info(
      'Stored value for key: $key in box: ${box.name}',
      tag: 'HiveService',
    );
  }

  /// Gets a value from the box by its key
  T? get<T>(Box<T> box, dynamic key) {
    _ensureInitialized();
    return box.get(key);
  }

  /// Deletes a value from the box by its key
  Future<void> delete<T>(Box<T> box, dynamic key) async {
    _ensureInitialized();
    await box.delete(key);
    AppLogger.info(
      'Deleted value for key: $key from box: ${box.name}',
      tag: 'HiveService',
    );
  }

  /// Clears all entries from the box
  Future<void> clear<T>(Box<T> box) async {
    _ensureInitialized();
    await box.clear();
    AppLogger.info(
      'Cleared all entries from box: ${box.name}',
      tag: 'HiveService',
    );
  }

  /// Checks if the box contains a specific key
  bool containsKey<T>(Box<T> box, dynamic key) {
    _ensureInitialized();
    return box.containsKey(key);
  }

  /// Retrieves all values stored in the box
  List<T> getAll<T>(Box<T> box) {
    _ensureInitialized();
    return List<T>.unmodifiable(box.values);
  }

  /// Puts multiple entries into the box
  Future<void> putAll<T>(Box<T> box, Map<dynamic, T> entries) async {
    _ensureInitialized();
    await box.putAll(entries);
    AppLogger.info(
      'Stored ${entries.length} entries in box: ${box.name}',
      tag: 'HiveService',
    );
  }

  /// Closes all open Hive boxes
  Future<void> close() async {
    _ensureInitialized();
    await Hive.close();
    AppLogger.info('Closed all Hive boxes', tag: 'HiveService');
  }
}
