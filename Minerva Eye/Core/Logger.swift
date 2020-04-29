//
//  Logger.swift
//  Minerva Eye
//
//  Created by Tomas Korcak on 4/29/20.
//  Copyright © 2020 Tomas Korcak. All rights reserved.
//

import Combine
import Foundation

class Logger  {
    static private var _instance: Logger = Logger()
    
    private var lastMessage: String = ""
    
    static func instance() -> Logger {
        return Logger._instance
    }
    
    static func log(msg: String) {
        Logger.instance().log(msg: msg)
    }
    
    func log(msg: String) {
        self.lastMessage = msg
        print(msg)
    }
}

extension Logger {
    struct Publisher: Combine.Publisher {
        func receive<S>(subscriber: S) where S : Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
            let _ = print("Received data")
        }
        
        typealias Output = String
        typealias Failure = Never
        
        init(logger: Logger, message: String, object: Any? = nil) {
            // Initialize publisher
            print("Initializer Combine.Publisher for Logger")
        }
    }
}
