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
    private var detailVC: DetailVC?
    
    init(_ navigationController: UINavigationController, coreDataStack: CoreDataStack) {
        self.navigationController = navigationController
        self.coreDataStack = coreDataStack
    }
    
    public func start() {
        addMainVC()
    }
    
}


// MARK: - MainVC
extension AppCoordinater: MainVCDelegate {
    
    fileprivate func addMainVC() {
        let vm = MainVM(coreDataStack: coreDataStack)
        mainVC = MainVC(viewModel: vm)
        vm.delegate = mainVC!
        mainVC!.delegate = self
        navigationController.pushViewController(mainVC!, animated: true)
    }
 
    func mainVCOpenDetailVC(_ unit: Unit) {
        addDetailVC(unit: unit)
    }
}


// MARK: - DetailVC
extension AppCoordinater  {
    
    fileprivate func addDetailVC(unit: Unit) {
        let vm = DetailVM(coreDataStack: coreDataStack, unit: unit)
        detailVC = DetailVC(viewModel: vm)
        vm.delegate = detailVC!
        vm.createFetchController()
        navigationController.pushViewController(detailVC!, animated: true)
    }
}
