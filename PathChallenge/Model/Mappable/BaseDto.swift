//
//  BaseDto.swift
//  PathChallenge
//
//  Created by Mehmet Kerse on 10.07.2021.
//

import Foundation
import ObjectMapper

open class BaseDto : NSObject, ImmutableMappable {
    
    required public init(map: Map) throws {
        super.init()
    }
    
    
    required override public init() {
        super.init()
    }
    
    public func mapping(map: Map) {
    }
    
}
