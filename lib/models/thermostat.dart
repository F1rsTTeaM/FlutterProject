import 'package:flutter/material.dart';
import 'device.dart';
import 'device_type.dart';

class Thermostat extends Device<double> {
  Thermostat(String id, String name)
    : super(id, name, DeviceType.THERMOSTAT, Icons.thermostat, 22.0);

  @override
  void toggle() {
    status = status == 22.0 ? 24.0 : 22.0;
  }

  @override
  Future<void> updateStatus(double newTemperature) async {
    await Future.delayed(Duration(microseconds: 100));
    status = newTemperature;
  }

  @override
  String get statusText => '${status}°C';
}