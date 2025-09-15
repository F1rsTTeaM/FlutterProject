import 'package:flutter/material.dart';

import 'device.dart';
import 'device_type.dart';

class Camera extends Device<bool> {
  Camera(String id, String name)
    : super(id, name, DeviceType.CAMERA, Icons.camera, false);

  @override
  void toggle() {
    status = !status;
  }

  @override
  Future<void> updateStatus(bool newStatus) async{
    await Future.delayed(Duration(microseconds: 100));
    status = newStatus;
  }

  @override
  String get statusText => status ? 'Запись' : 'Выкл';
}