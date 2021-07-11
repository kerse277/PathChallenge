//
//  KeychainManager.swift
//  PathChallenge
//
//  Created by Mehmet Kerse on 10.07.2021.
//

import Foundation
import KeychainAccess

class KeychainManager: NSObject {
    
    private var service: String!
    private var server: String!
    private var uniqueKey: String!
    private let PROTOCOL: ProtocolType = .https
    
    private let keychain: Keychain!
    
    init(config: Config) {
        self.server = config.getApiUrl()
        self.service = Bundle.main.bundleIdentifier!
        self.uniqueKey = config.getApiUrl()
        self.keychain = Keychain(server: self.service, protocolType: PROTOCOL)
    }
    
    public func save(_ key: String, value: String) throws {
        try keychain.set(value, key: key)
    }


    public func get(_ key: String) -> String? {
        return keychain[string: key]
    }


    public func remove(_ key: String) {
        keychain[string: key] = nil
    }

    

}
