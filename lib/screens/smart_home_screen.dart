import 'package:flutter/material.dart';
import 'dart:async';
import '../models/device.dart';
import '../models/light.dart';
import '../models/thermostat.dart';
import '../models/camera.dart';
import '../models/device_type.dart';
import '../widgets/device_card.dart';

class SmartHomeScreen extends StatefulWidget{
  @override
  _SmartHomeScreenState createState() => _SmartHomeScreenState();
}

class _SmartHomeScreenState extends State<SmartHomeScreen> {
  final List<Device> devices = [
    Light('l1', 'Гостиная'),
    Light('l2', 'Спальня'),
    Light('l3', 'Кухня'),
    Thermostat('t1', 'Термостат'),
    Camera('c1', 'Входная дверь'),
  ];

  Future<void> _toggleAllDevices() async {
    await Future.wait(devices.map((device) async {
      await Future.delayed(Duration(milliseconds: 150));
      device.toggle();
      return device;
    }));

    setState(() {});
  }

  List<Device<T>> _getDevicesByType<T>(DeviceType type) {
    return devices
        .where((device) => device.type == type)
        .toList()
        .cast<Device<T>>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Самый умный дом (нет)'),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: Icon(Icons.autorenew),
            onPressed: _toggleAllDevices,
            tooltip: 'Переключить все устройства',
          )
        ],
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Мои устройства',
                style: TextStyle(fontSize: 24, fontWeight:  FontWeight.bold),
              ),
              SizedBox(height: 20),

              Container(
                height: MediaQuery.of(context).size.height * 0.6,
                child: ListView.builder(
                  itemCount: devices.length,
                  itemBuilder: (context, index) {
                    final device = devices[index];
                    return DeviceCard(device: device);
                  },
                ),
              ),

              _buildStatisticsCard(),
            ],
        ),
      ),
    );
  }

  Widget _buildStatisticsCard() {
    return Card(
      color: Colors.blue[50],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Статистика устройств',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildStatItem('Всего', devices.length, Icons.devices),
                _buildStatItem('Лампы', _getDevicesByType<Light>(DeviceType.LIGHT).length, Icons.lightbulb_outline),
                _buildStatItem('Термостаты', _getDevicesByType<Thermostat>(DeviceType.THERMOSTAT).length, Icons.thermostat),
                _buildStatItem('Камеры', _getDevicesByType<Camera>(DeviceType.CAMERA).length, Icons.camera),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String title, int count, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 20, color: Colors.blue[700]),
        SizedBox(height: 4),
        Text(
          '$count',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.blue[900],
          ),
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }
}