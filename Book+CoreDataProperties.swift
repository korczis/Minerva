//
//  Book+CoreDataProperties.swift
//  Minerva Eye
//
//  Created by Tomas Korcak on 4/28/20.
//  Copyright © 2020 Tomas Korcak. All rights reserved.
//
//

import Foundation
import CoreData


extension Book {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Book> {
        return NSFetchRequest<Book>(entityName: "Book")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var subtitle: String?
    @NSManaged public var isbn: String?
    @NSManaged public var desc: String?

}
