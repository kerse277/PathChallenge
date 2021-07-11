//
//  PCError.swift
//  PathChallenge
//
//  Created by Mehmet Kerse on 10.07.2021.
//

import Foundation
enum PCErrorType {
    case error
    case warning
    case info
    case success
}
enum PCServiceError {
    case network
    case server
    case warning
    case auth
}

struct PCError : Swift.Error {
    let code: String
    let message: String
    let messageType: PCErrorType
    let redirectLogin: Bool
    var type : PCServiceError? = nil
    
    
    
    init(code: String, message: String, messageType: PCErrorType,redirectLogin: Bool) {
        self.code = code
        self.message = message
        self.messageType = messageType
        self.redirectLogin = redirectLogin
    }
    
    var description : String{
        return code + " - " + message
    }
}

extension PCError {
    
    var tryWithTapMessage : String {
        return "\(checkForLastDot()) Tekrar denemek için buraya dokunun."
    }
    
    var tryLaterMessage : String {
        return "\(checkForLastDot()) Lütfen daha sonra tekrar deneyiniz."
    }
    
    var tryAgainMessage : String {
        return "\(checkForLastDot()) Lütfen deneyiniz."
    }
    
    
    private func checkForLastDot() -> String{
        let endsWithDot = message.last == "."
        if endsWithDot {
            return message
        }else {
            return "\(message)."
        }
    }
}
