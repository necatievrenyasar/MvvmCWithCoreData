//
//  AppCoordinater.swift
//  MvvmCWithCoreData
//
//  Created by Evren Yaşar on 6.05.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import UIKit
final class AppCoordinater {
    
    private let navigationController: UINavigationController
    private let coreDataStack: CoreDataStack
    private var mainVC: MainVC?
    
    
    init(_ navigationController: UINavigationController, coreDataStack: CoreDataStack) {
        self.navigationController = navigationController
        self.coreDataStack = coreDataStack
    }
    
    public func start() {
        addMainVC()
    }
    
}


// MARK: - MainVC
extension AppCoordinater {
    
    fileprivate func addMainVC() {
        let vm = MainVM(coreDataStack: coreDataStack)
        mainVC = MainVC(viewModel: vm)
        vm.delegate = mainVC
        navigationController.pushViewController(mainVC!, animated: true)
    }
    
}


// MARK: - DetailVC
extension AppCoordinater  {
    
    fileprivate func addDetailVC() {}
}
