import 'package:flutter/material.dart';
import 'package:flutter_project/extensions/status_color_extansion.dart';
import '../models/device.dart';
import '../models/light.dart';
import '../models/thermostat.dart';
import '../models/camera.dart';


class DeviceCard extends StatelessWidget {
  final Device device;

  const DeviceCard({required this.device});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Icon(device.icon, color: device.statusColor),
        title: Text(device.name),
        subtitle: Text(device.statusText),
        trailing: _buildTrailingWidget(context),
        onTap: () {
          device.toggle();
          (context as Element).markNeedsBuild();
        },
      ),
    );
  }

  Widget? _buildTrailingWidget(BuildContext context) {
    if(device is Light) {
      return Switch(
        value: (device as Light).status,
        onChanged: (value) async{
          await device.updateStatus(value);
          (context as Element).markNeedsBuild();
        },
        activeColor: Colors.green,
      );
    } else if (device is Thermostat) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.remove, size: 20),
            onPressed: () async {
              final thermostat = device as Thermostat;
              await thermostat.updateStatus(thermostat.status - 1);
              (context as Element).markNeedsBuild();
            },
          ),

          Text('${(device as Thermostat).status.toInt()}°C',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)
          ),

          IconButton(
            icon: Icon(Icons.add, size: 20),
            onPressed: () async {
              final thermostat = device as Thermostat;
              await thermostat.updateStatus(thermostat.status + 1);
              (context as Element).markNeedsBuild();
            },
          ),
        ],
      );
    } else if (device is Camera) {
      return Switch(
        value: (device as Camera).status,
        onChanged: (value) async {
          await device.updateStatus(value);
          (context as Element).markNeedsBuild();
        },
        activeColor: Colors.green,
      );
    }
    return null;
  }
}