//
//  Unit+CoreDataProperties.swift
//  MvvmCWithCoreData
//
//  Created by Evren Yaşar on 6.05.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//
//

import Foundation
import CoreData


extension Unit {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Unit> {
        return NSFetchRequest<Unit>(entityName: "Unit")
    }

    @NSManaged public var name: String?
    @NSManaged public var lang: String?
    @NSManaged public var word: NSSet?

}

// MARK: Generated accessors for word
extension Unit {

    @objc(addWordObject:)
    @NSManaged public func addToWord(_ value: Word)

    @objc(removeWordObject:)
    @NSManaged public func removeFromWord(_ value: Word)

    @objc(addWord:)
    @NSManaged public func addToWord(_ values: NSSet)

    @objc(removeWord:)
    @NSManaged public func removeFromWord(_ values: NSSet)

}
