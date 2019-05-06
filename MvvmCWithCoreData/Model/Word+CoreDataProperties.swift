//
//  Word+CoreDataProperties.swift
//  MvvmCWithCoreData
//
//  Created by Evren Yaşar on 6.05.2019.
//  Copyright © 2019 Evren Yaşar. All rights reserved.
//
//

import Foundation
import CoreData


extension Word {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Word> {
        return NSFetchRequest<Word>(entityName: "Word")
    }

    @NSManaged public var word: String?
    @NSManaged public var meaning: String?
    @NSManaged public var unit: Unit?

}
