import 'logger_service.dart';

class LoggerMessageBuilder {
  LoggerMessageBuilder([this.tag = '']) : _logMessage = StringBuffer();

  final String tag;
  final StringBuffer _logMessage;

  void writeLogMessage([List<String> msg = const <String>[], bool isLastNewLine = true]) {
    msg.asMap().forEach((int index, String el) {
      final String str = el.isEmpty ? el : '$tag $el';
      if (index == msg.length - 1) {
        if (isLastNewLine) {
          _logMessage.writeln(str);
        } else {
          _logMessage.write(str);
        }
      } else {
        _logMessage.writeln(str);
      }
    });
  }

  void log([bool isError = false]) {
    if (_logMessage.isEmpty) return;
    if (isError) {
      Log().e(_logMessage.toString());
    } else {
      Log().d(_logMessage.toString());
    }
    _logMessage.clear();
  }
}
