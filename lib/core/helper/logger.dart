import 'package:logger/logger.dart';

var logger = Logger(printer: PrettyPrinter());

var loggerNoStack = Logger(
  printer: PrettyPrinter(methodCount: 0),
);

void loggerDebug(String message) => logger.d(message);
void loggerInfo(String message) => loggerNoStack.i(message);
void loggerWarning(String message) => loggerNoStack.w(message);
void loggerError(String message) => logger.e(message);
void loggerTrace(String message) => loggerNoStack.t(message);
