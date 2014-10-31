//
//  Logging.swift
//  Twitter
//
//  Created by Orestis Salinger on 31.10.14.
//  Copyright (c) 2014 Orestis Salinger. All rights reserved.

import Foundation

enum Level : Int {
    case None = 0
    case Error = 1
    case Warning = 2
    case Info = 3
    case Verbose = 4
}

var logLevel:  Level = Level.Verbose

func logVerbose(logString:  String) {
    println("\n\n\nLOGGING")
    
    log(.Verbose, logString)
    
    println("END OF LOGGING\n\n\n")
}

func logInfo(logString:  String) {
    log(.Info, logString)
}

func logWarning(logString:  String) {
    log(.Warning, logString)
}

func logError(logString:  String) {
    log(.Error, logString)
}

func ENTRY_LOG(functionName:  String = __FUNCTION__) {
    logVerbose("ENTRY " + functionName)
}

func EXIT_LOG(functionName:  String = __FUNCTION__) {
    logVerbose("EXIT " + functionName)
}

func log(logLevel:  Level, logString:  String) {
    
    let log = stringForLogLevel(logLevel) + " - " + logString
    let appLogLevel = logLevel.rawValue
    if (appLogLevel >= logLevel.rawValue) {
        NSLog(log)
    }
}

func stringForLogLevel(logLevel:  Level) -> String {
    switch logLevel {
    case .Verbose:
        return "VERBOSE"
    case .Info:
        return "INFO"
    case .Warning:
        return "WARNING"
    case .Error:
        return "ERROR"
    case .None:
        return "NONE"
    }
    
}
