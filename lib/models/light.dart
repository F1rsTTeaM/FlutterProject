import 'device_type.dart';
import 'device.dart';
import 'package:flutter/material.dart';

class Light extends Device<bool> {
  Light(String id, String name)
    : super(id, name, DeviceType.LIGHT, Icons.lightbulb_outline, false);

  @override
  void toggle() {
    status = !status;
  }

  @override
  Future<void> updateStatus(bool newStatus) async {
    await Future.delayed(Duration(microseconds: 100));
    status = newStatus;
  }

  @override
  String get statusText => status ? 'ВКЛ' : 'ВЫКЛ';
}