//
//  PageResponse.swift
//  PathChallenge
//
//  Created by Mehmet Kerse on 10.07.2021.
//

import Foundation
import ObjectMapper

class Page<T : BaseDto> : BaseDto {
    
    var results: [T]?
    var offset : Int?
    var limit : Int?
    var count : Int?
    var total : Int?

    
    required init(map: Map) throws {
        try super.init(map: map)
        self.mapping(map: map)
    }
    
    required init() {
        super.init()
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        results     <- map["results"]
        offset     <- map["offset"]
        limit     <- map["limit"]
        count     <- map["count"]
        total     <- map["total"]
        
    }
}

