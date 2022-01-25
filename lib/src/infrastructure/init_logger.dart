// Copyright 2022 Fredrick Allan Grott. All rights reserved.
// Use of this source code is governed by a BSD-style
// license that can be found in the LICENSE file.


import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:logging/logging.dart';

import 'appenders.dart';
import 'formatters.dart';

late Logger appLogger;

// initLogger in main function either directly or as an IoC dependency service item
void initLogger(String appLoggerTitle) {
  appLogger = Logger(appLoggerTitle);

  if (kDebugMode) {
    // set to emit all levels
    recordStackTraceAtLevel = Level.ALL;

    Logger.root.onRecord.listen((record) {
      if (record.error != null && record.stackTrace != null) {
        log('${record.level.name}: ${record.loggerName}: ${record.time}: ${record.message}: ${record.error}: ${record.stackTrace}');

        log(
          // ignore: prefer-trailing-comma
          'level: ${record.level.name} loggerName: ${record.loggerName} time: ${record.time} message: ${record.message} error: ${record.error} exception: ${record.stackTrace}',
        );
      } else if (record.error != null) {
        log('level: ${record.level.name} loggerName: ${record.loggerName} time: ${record.time} message: ${record.message} error: ${record.error}');
      } else {
        log('level: ${record.level.name} loggerName: ${record.loggerName} time: ${record.time} message: ${record.message}');
      }
    });
    AppDevLogAppender(formatter: const AppDevLogRecordFormatter())
        .attachToLogger(Logger.root);
  }
  if (kReleaseMode) {
    recordStackTraceAtLevel = Level.ALL;

    Logger.root.onRecord.listen((record) {
      if (record.error != null && record.stackTrace != null) {
        log('${record.level.name}: ${record.loggerName}: ${record.time}: ${record.message}: ${record.error}: ${record.stackTrace}');

        log(
          'level: ${record.level.name} loggerName: ${record.loggerName} time: ${record.time} message: ${record.message} error: ${record.error} exception: ${record.stackTrace}',
        );
      } else if (record.error != null) {
        log('level: ${record.level.name} loggerName: ${record.loggerName} time: ${record.time} message: ${record.message} error: ${record.error}');
      } else {
        log('level: ${record.level.name} loggerName: ${record.loggerName} time: ${record.time} message: ${record.message}');
      }
    });

    AppReleaseLogAppender(formatter: const AppReleaseLogRecordFormatter())
        .attachToLogger(Logger.root);
  }
}
