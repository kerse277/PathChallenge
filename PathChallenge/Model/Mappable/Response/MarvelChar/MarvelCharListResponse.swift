//
//  MarvelCharListResponse.swift
//  PathChallenge
//
//  Created by Mehmet Kerse on 10.07.2021.
//

import Foundation
import ObjectMapper

final class MarvelCharListDto : Page<MarvelCharDto> {
    
    required public init() {
        super.init()
        
    }
    
    required init(map: Map) throws {
        try super.init(map: map)
        self.mapping(map: map)
    }
    
    override func mapping(map: Map) {
        super.mapping(map: map)
        
    }
}

class MarvelCharDto : BaseDto{
    var id : Int?
    var name : String?
    var desc : String?
    var thumbnail : Thumbnail?
    
    required public init() {
        super.init()
        
    }
    
    required init(map: Map) throws {
        try super.init(map: map)
        self.mapping(map: map)
    }
    override func mapping(map: Map) {
        super.mapping(map: map)
        id                   <- map["id"]
        name                 <- map["name"]
        desc                 <- map["description"]
        thumbnail            <- map["thumbnail"]
        
    }
    
}
