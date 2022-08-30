import 'package:logger/logger.dart';

// class CustomLog extends LogPrinter{

//   @override
//   void log(LogEvent event) {
//     println('${event.message}' );
//   }
// }

// class SimpleLogPrinter extends LogPrinter {
//   final String className;

//   SimpleLogPrinter(this.className);  
//   @override
//   void log(Level level, message, error, StackTrace stackTrace) {
//     var color = PrettyPrinter.levelColors[level];
//     var emoji = PrettyPrinter.levelEmojis[level];
//     println(color('$emoji $className - $message'));
//   }
// }

Logger getLogger() {
  return Logger(printer: PrettyPrinter(printTime: true));
}