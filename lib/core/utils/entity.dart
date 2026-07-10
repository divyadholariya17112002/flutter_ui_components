import 'package:equatable/equatable.dart';

/// Base class for domain entities.
///
/// Entities are pure business objects with no serialization or framework
/// dependencies. Extend this in feature `domain/entities` folders.
abstract base class Entity extends Equatable {
  const Entity();
}
