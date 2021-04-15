//
//  Guide.swift
//  guide
//
//  Created by Laptop on 2021-04-15.
//

import CoreData

@objc(Guides)
class Guides: NSManagedObject
{
    @NSManaged var id: NSNumber!
    @NSManaged var title: String!
    @NSManaged var desc: String!
    @NSManaged var deletedDate: Date?
}
