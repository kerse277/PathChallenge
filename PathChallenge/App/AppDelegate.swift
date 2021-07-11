//
//  AppDelegate.swift
//  PathChallenge
//
//  Created by Mehmet Kerse on 10.07.2021.
//

import UIKit
import Foundation
import AlamofireNetworkActivityLogger
import Firebase

#if DEBUG
let isDebug = true
#else
let isDebug = false
#endif

typealias App = AppDelegate

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    static let localStorage: LocalStorege = LocalStorege()

    static var keychain: KeychainManager!
    static var config: Config!
    static var messages: Errors!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        configureApp()
        UIAppearance()
        if #available(iOS 13.0, *) {}else {
            appContainer.router.start()
        }
        
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }


}
extension AppDelegate {
   
    public func configureApp() {
        self.initApp()
        self.initWindow()
    }
    private func UIAppearance() {
        UITabBar.appearance().tintColor = Color.Tint.dark
        UITabBar.appearance().barTintColor = Color.white
        UINavigationBar.appearance().tintColor = Color.text
        UINavigationBar.appearance().barTintColor = Color.white
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    fileprivate func initApp() {
        App.config = Config.init()
        App.keychain = KeychainManager(config: App.config)
        App.messages = Errors.init()

        #if DEBUG
        NetworkActivityLogger.shared.level = .debug
        NetworkActivityLogger.shared.startLogging()
        #endif
        
    }
    
    fileprivate func initWindow() {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.9960784314, blue: 0.9960784314, alpha: 1)
        
        self.window?.makeKeyAndVisible()
        
        let navigationAppearance = UINavigationBar.appearance()
        navigationAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        navigationAppearance.isTranslucent = false
    }
    
    
}

