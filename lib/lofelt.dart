import 'dart:async';

import 'package:flutter/services.dart';

class Lofelt {
  static const MethodChannel _channel = const MethodChannel('lofelt');

  static Future<String> init() async {
    final String test = await _channel.invokeMethod('init');
    return test;
  }

  static Future<void> load(String path) async {
    return _channel.invokeMethod('load', {'path': path});
  }

  static Future<void> play() async {
    return _channel.invokeMethod('play');
  }

  static Future<void> stop() async {
    return _channel.invokeMethod('stop');
  }
}
