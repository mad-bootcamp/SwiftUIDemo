//
//  Product+CoreDataProperties.swift
//  SwiftUIDemo
//
//  Created by user303027 on 9/18/26.
//
//

public import Foundation
public import CoreData


public typealias ProductCoreDataPropertiesSet = NSSet

extension Product {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
        return NSFetchRequest<Product>(entityName: "Product")
    }

    @NSManaged public var color: String?
    @NSManaged public var id: Int64
    @NSManaged public var listPrice: Double
    @NSManaged public var name: String?
    @NSManaged public var productNumber: String?

}

extension Product : Identifiable {

}
