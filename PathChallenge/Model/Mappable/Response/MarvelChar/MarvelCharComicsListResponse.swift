//
//  MarvelCharComicsListResponse.swift
//  PathChallenge
//
//  Created by Mehmet Kerse on 11.07.2021.
//

import Foundation
import ObjectMapper

final class MarvelCharComicsListDto : Page<MarvelCharComicsDto> {
    
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

class MarvelCharComicsDto : BaseDto{
    var id : Int?
    var name : String?
    var title : String?
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
        title                 <- map["title"]
        desc                 <- map["description"]
        thumbnail            <- map["thumbnail"]
        
    }
    
}

