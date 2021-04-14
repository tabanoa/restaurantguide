//
//  Restaurant.swift
//  restaurantGuide
//
//  Created by Laptop on 2021-04-14.
//

import CoreData

@objc(Restaurant)
class Restaurant: NSManagedObject
{
    @NSManaged var id: NSNumber!
    @NSManaged var title: String!
    @NSManaged var desc: String!
    @NSManaged var deletedDate:Date?
    
}
