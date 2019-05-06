//
//  CoreDataStack.swift
//  MvvmCWithCoreData
//
//  Created by Evren Yaşar on 6.05.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import Foundation
import CoreData

final class CoreDataStack {
    
    private let containerName: String
    
    init(containerName: String) {
        self.containerName = containerName
    }
    
    lazy var managedContext: NSManagedObjectContext = {
        return self.storeContainer.viewContext
    }()
    
    private lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: self.containerName)
        container.loadPersistentStores(completionHandler: { (desc, error) in
            if let error = error as NSError? {
                print("Container Error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    public func saveContext() {
        if !managedContext.hasChanges {return}
        do {
            try managedContext.save()
        }catch let error as NSError {
            print("Saved Error \(error) \(error.userInfo)")
        }
    }
}
