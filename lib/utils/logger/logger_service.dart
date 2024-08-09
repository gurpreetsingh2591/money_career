import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

class Log {
  factory Log({bool excludeDebug = false, List<Level>? excludedLevels}) {
    if (kDebugMode) {
      _logger ??= Logger(
        filter: excludeDebug ? ExcludeByLevelLogFilter(excludedLevels: excludedLevels ?? <Level>[Level.debug]) : null,
        printer: PrettyPrinter(
          methodCount: 4, // number of method calls to be displayed
          errorMethodCount: 8, // number of method calls if stacktrace is provided
        ),
      );
    }
    return _instance;
  }

  Log._internal();

  static final Log _instance = Log._internal();

  static Log getInstance() => _instance;

  static Logger? _logger;
  static String _tag = 'default:';
  static set tag(String tag) => _tag = tag;

  void d([dynamic msg]) {
    _logger?.d(_messageWithTag(msg));
  }

  void v([dynamic msg]) {
    _logger?.v(_messageWithTag(msg));
  }

  void i([dynamic msg]) {
    _logger?.i(_messageWithTag(msg));
  }

  void w([dynamic msg]) {
    _logger?.w(_messageWithTag(msg));
  }

  void e([dynamic msg, StackTrace? stk]) {
    _logger?.e(_messageWithTag(msg), _messageWithTag(msg), stk);
  }

  void wtf([dynamic msg]) {
    _logger?.wtf(_messageWithTag(msg));
  }

  String _messageWithTag(dynamic msg) => '$_tag $msg';
}

class ExcludeByLevelLogFilter extends LogFilter {
  ExcludeByLevelLogFilter({this.excludedLevels});

  final List<Level>? excludedLevels;

  @override
  bool shouldLog(LogEvent event) => !(excludedLevels?.contains(event.level) ?? false);
}
