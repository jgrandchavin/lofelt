import 'dart:async';

import 'package:flutter/services.dart';

class Lofelt {
  static const MethodChannel _channel = const MethodChannel('lofelt');

  /// Init Lofelt
  static Future<String> init() async {
    final String test = await _channel.invokeMethod('init');
    return test;
  }

  /// Load file contained in [path] in Lofelt
  ///
  /// After that the file is ready to play
  /// Throw [Error] if Lofelt not init or file does not exits or badly formatted
  static Future<void> load(String path) async {
    return _channel.invokeMethod('load', {'path': path});
  }

  /// Play file loaded in Lofelt
  ///
  /// After that the file is playing
  /// Throw [Error] if Lofelt not init or no file loaded in Lofelt
  static Future<void> play() async {
    return _channel.invokeMethod('play');
  }

  /// Stop playing file loaded in Lofelt
  ///
  /// After that the file is stopped
  /// Throw [Error] if Lofelt not init or no file loaded in Lofelt
  static Future<void> stop() async {
    return _channel.invokeMethod('stop');
  }
}
