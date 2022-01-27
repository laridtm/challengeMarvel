//
//  AppDelegate.swift
//  challangeMarvel
//
//  Created by Larissa Diniz on 28/07/20.
//  Copyright © 2020 Larissa Diniz. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let controller = CharactersListViewController()
        let nav = UINavigationController(rootViewController: controller)
        window?.rootViewController = nav
        let worker = CharactersListWorker()
        let presenter = CharactersListPresenter(view: controller)
        let interactor = CharactersListInteractor(presenter: presenter, worker: worker)
        controller.interactor = interactor
        window?.makeKeyAndVisible()
        return true
    }
    
}

