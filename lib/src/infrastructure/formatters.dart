// Copyright 2022 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.

import 'package:logging/logging.dart';
import 'package:logging_appenders/logging_appenders.dart';

LogRecordFormatter defaultLogRecordFormatter() =>
    const DefaultLogRecordFormatter();

LogRecordFormatter defaultReleaseLogRecordFormatter() =>
    const DefaultLogRecordFormatter();


class AppDevLogRecordFormatter extends LogRecordFormatter {
  const AppDevLogRecordFormatter();
  @override
  StringBuffer formatToStringBuffer(
    LogRecord rec,
    StringBuffer sb,
  ) {
    sb.write(
      '${rec.time} ${rec.level.name} ${rec.zone} '
      '${rec.loggerName} - ${rec.message}',
    );

    if (rec.error != null) {
      sb.writeln();
      sb.write('### ${rec.error?.runtimeType}: ');
      sb.write(rec.error);
    }
    // ignore: avoid_as
    final stackTrace = rec.stackTrace ??
        // ignore: cast_nullable_to_non_nullable
        (rec.error is Error ? (rec.error as Error).stackTrace : null);
    if (stackTrace != null) {
      sb.writeln();
      sb.write(stackTrace);
    }

    return sb;
  }
}

class AppReleaseLogRecordFormatter extends LogRecordFormatter {
  const AppReleaseLogRecordFormatter();
  @override
  StringBuffer formatToStringBuffer(
    LogRecord rec,
    StringBuffer sb,
  ) {
    sb.write(
      '${rec.time} ${rec.level.name}  '
      '${rec.loggerName} - ${rec.message}',
    );

    if (rec.error != null) {
      sb.writeln();
      sb.write('### ${rec.error?.runtimeType}: ');
      sb.write(rec.error);
    }
    // ignore: avoid_as
    final stackTrace = rec.stackTrace ??
        // ignore: cast_nullable_to_non_nullable
        (rec.error is Error ? (rec.error as Error).stackTrace : null);
    if (stackTrace != null) {
      sb.writeln();
      sb.write(stackTrace);
    }

    return sb;
  }
}
