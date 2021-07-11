//
//  Thumbnail.swift
//  PathChallenge
//
//  Created by Mehmet Kerse on 11.07.2021.
//
import Foundation
import ObjectMapper

class Thumbnail : BaseDto{
    var path : String?
    var ext : String?
    
    required public init() {
        super.init()
        
    }
    
    required init(map: Map) throws {
        try super.init(map: map)
        self.mapping(map: map)
    }
    override func mapping(map: Map) {
        super.mapping(map: map)
        path                   <- map["path"]
        ext                 <- map["extension"]
        
    }
    
}
