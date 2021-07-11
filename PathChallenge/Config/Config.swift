//
//  Config.swift
//  PathChallenge
//
//  Created by Mehmet Kerse on 10.07.2021.
//

import Foundation

class Config: NSObject {
    
    private static let PLIST_URL: String? = Bundle.main.path(forResource: "Config", ofType: "plist")
    
    fileprivate var apiUrl: String!
    fileprivate var apiKey: String!
    
    override init() {
        super.init()
        self.load()
    }
    
    fileprivate func load() {
        guard Config.PLIST_URL != nil else {
            print("Error: Config could not be loaded")
            return
        }
        
        guard let dict = NSDictionary(contentsOfFile: Config.PLIST_URL!) as? [String: AnyObject] else {
            print("Error: Dictionary is not available to use")
            return
        }
        
        self.apiUrl = dict["apiUrl"] as? String
        self.apiKey = dict["apiKey"] as? String
        
        
    }
    
    static func timeout() -> TimeInterval {
        if isDebug {
            return TimeInterval(30)
        } else {
            return TimeInterval(15)
        }
    }
    
    public func getApiUrl() -> String? {
        
        return self.apiUrl
        
    }
    
    public func getApiKey() -> String? {
        
        return self.apiKey
        
    }
    
}
