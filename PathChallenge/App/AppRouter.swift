//
//  AppRouter.swift
//  PathChallenge
//
//  Created by Mehmet Kerse on 10.07.2021.
//

import UIKit

final class AppRouter {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    func start() {

        appDelegate.window?.rootViewController = UINavigationController(rootViewController: MarvelCharListViewController())
        
    }
    
}
