//
//  AppDelegate.swift
//  MvvmCWithCoreData
//
//  Created by Evren Yaşar on 6.05.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    private var coordinater: AppCoordinater?
    lazy var coreDataStack = CoreDataStack(containerName: "WordList")
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        //NavigationController
        let navigationController = UINavigationController()
        
        //SetupCoordinater
        coordinater = AppCoordinater(navigationController, coreDataStack: coreDataStack)
        coordinater!.start()
        
        // Set UIWindow
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = navigationController
        window!.makeKeyAndVisible()
        
        return true
    }

   


}

