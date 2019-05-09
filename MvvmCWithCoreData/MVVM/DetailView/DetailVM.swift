//
//  DetailVM.swift
//  MvvmCWithCoreData
//
//  Created by Evren Yaşar on 6.05.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//

import Foundation
import CoreData
public protocol DetailVMDelegate: class {
    func detailVMError(_ error: NSError)
    func detailVMRefresh(indexPath: IndexPath, type: NSFetchedResultsChangeType)
}


final class DetailVM: NSObject{
    
    private let coreDataStack: CoreDataStack
    private let unit: Unit
    private var wordData: NSFetchedResultsController<Word>!
    public weak var delegate: DetailVMDelegate?
    
    init(coreDataStack: CoreDataStack, unit: Unit) {
        self.coreDataStack = coreDataStack
        self.unit = unit
    }
    
    public func createFetchController() {
        let fetchRequest = NSFetchRequest<Word>(entityName: "Word")
        fetchRequest.predicate = NSPredicate(format: "unit = %@", unit)
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "word", ascending: true)]
        do {
            wordData = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                  managedObjectContext: coreDataStack.managedContext,
                                                  sectionNameKeyPath: nil, cacheName: nil)
            wordData.delegate = self
            try wordData.performFetch()
        }catch let error as NSError {
            delegate?.detailVMError(error)
        }
    }
    
    public func dataCount() -> Int {
        return wordData.fetchedObjects?.count ?? 0
    }
    
    public func getObject(_ indexPath: IndexPath) -> Word? {
        return wordData.object(at: indexPath)
    }
    
    public func add(_ word:String, _ meaning: String) {
        let newWord = Word(entity: Word.entity(), insertInto: coreDataStack.managedContext)
        newWord.unit = unit
        newWord.word = word
        newWord.meaning = meaning
        coreDataStack.saveContext()
    }
}

extension DetailVM: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        guard let indexPath = indexPath  ?? (newIndexPath ?? nil) else {
            return
        }
        delegate?.detailVMRefresh(indexPath: indexPath, type: type)
    }
}

