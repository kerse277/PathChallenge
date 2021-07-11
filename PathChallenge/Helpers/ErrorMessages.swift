//
//  ErrorMessages.swift
//  PathChallenge
//
//  Created by Mehmet Kerse on 10.07.2021.
//

import Foundation


class Errors {
    
    var messages: [String: PCError] = [:]
    
    private let unknownError : PCError = PCError(code: "-998",
                                                   message:  "Beklenmeyen bir hata ile karşılaşıldı.",
                                                   messageType: .error,
                                                   redirectLogin: false)
    
    init() {
 
        
    }
    
    public func get(withCode code: String) -> PCError? {
        if let msg  = messages[code] {
            return msg
        }
        return nil
    }
    
    public func getUnknownError() -> PCError {
        return unknownError
    }
    
    public func redirect(code: String) -> Bool {
        
        if let msgTuple = messages[code] {
            return msgTuple.redirectLogin
        }
        return false
    }
    
    public func checkForError(code : String? , message : String? ) -> PCError {
        if let errorMessage =  message , let kod = code {
            return PCError(code: kod , message: errorMessage , messageType: .error, redirectLogin: false)
        }else {
            return App.messages.getUnknownError()
        }
    }
    
    
}
