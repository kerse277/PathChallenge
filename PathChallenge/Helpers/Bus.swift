//
//  RxBus.swift
//  PathChallenge
//
//  Created by Mehmet Kerse on 10.07.2021.
//

import Foundation

public protocol BusEvent {
    static var name: String { get }
}

public extension BusEvent {
    static var name: String {
        return "\(self)"
    }
}
