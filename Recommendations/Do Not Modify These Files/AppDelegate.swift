//
//  AppDelegate.swift
//  Recommendations
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RecommendationsViewController")
        window.rootViewController = vc
        window.backgroundColor = .white
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }
}

