//
//  MainVM.swift
//  MvvmCWithCoreData
//
//  Created by Evren Yaşar on 6.05.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import Foundation
import CoreData

public protocol MainVMDelegate: class {
    func mainVMLoadData(_ datas: [Unit])
    func mainVMError(_ error: NSError)
}


final class MainVM {
    
    private let coreDataStack: CoreDataStack
    public weak var delegate: MainVMDelegate?
    private let id = 1
    
    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
    }
    
    public func addNewUnit(_ name: String) {
        let unit = Unit(entity: Unit.entity(), insertInto: coreDataStack.managedContext)
        unit.name = name
        unit.lang = "En"
        coreDataStack.saveContext()
        fetchData()
    }
    
    public func fetchData() {
        let fetchRequest = NSFetchRequest<Unit>(entityName: "Unit")
        do {
            let data = try coreDataStack.managedContext.fetch(fetchRequest)
            delegate?.mainVMLoadData(data)
        }catch let error as NSError {
            delegate?.mainVMError(error)
        }
    }
}
