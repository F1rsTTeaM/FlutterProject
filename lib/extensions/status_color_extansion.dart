import '../models/device.dart';
import '../models/device_type.dart';
import '../models/light.dart';
import '../models/camera.dart';
import 'package:flutter/material.dart';

extension StatusColorExtansion on Device {
  Color get statusColor {
    switch (type) {
      case DeviceType.LIGHT:
        return (this as Light).status ? Colors.green : Colors.red;
      case DeviceType.THERMOSTAT:
        return Colors.blue;
      case DeviceType.CAMERA:
        return (this as Camera).status ? Colors.green : Colors.red;
      default:
        return Colors.grey;
    }
  }
}