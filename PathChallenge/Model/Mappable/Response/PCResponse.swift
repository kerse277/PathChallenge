//
//  PCResponse.swift
//  PathChallenge
//
//  Created by Mehmet Kerse on 10.07.2021.
//


import Foundation
import ObjectMapper


class PCResponse : BaseDto {
 
    var code : Int?
    var status : String?
    var copyright : String?
    var attributionText : String?
    var attributionHTML : String?
    var etag : String?
    
    required init(map: Map) throws {
        try super.init(map: map)
        self.mapping(map: map)
    }
    required init() {
        super.init()
        
    }
    override func mapping(map: Map) {
        super.mapping(map: map)
        code               <- map["code"]
        status    <- map["status"]
        copyright        <- map["copyright"]
        attributionText        <- map["attributionText"]
        attributionHTML        <- map["attributionHTML"]
        etag        <- map["etag"]

    }
    
}
