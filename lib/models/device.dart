import 'package:flutter/cupertino.dart';

import 'device_type.dart';

abstract class Device<T> {
  final String id;
  final String name;
  final DeviceType type;
  final IconData icon;
  T status;

  Device(this.id, this.name, this.type, this.icon, this.status);

  void toggle();
  Future<void> updateStatus(T newStatus);
  String get statusText;
}