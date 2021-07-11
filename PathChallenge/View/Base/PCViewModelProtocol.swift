//
//  PCViewModelProtocol.swift
//  PathChallenge
//
//  Created by Mehmet Kerse on 10.07.2021.
//

import Foundation


enum PCViewState : BusEvent {
    case inital
    case empty
    case loading
    case present
    case error(PCError)
    case networkError(PCError) 
    case warning(PCError)
    case authError(PCError)
}

protocol PCViewModelProtocol: class {
    func execute(command: PCViewState, data: AnyObject?) -> Void
}

