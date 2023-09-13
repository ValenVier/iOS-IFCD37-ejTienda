//
//  Producto+CoreDataProperties.swift
//  ejTienda
//
//  Created by AlumnoPro on 30/09/2021.
//
//

import Foundation
import CoreData


extension Producto {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Producto> {
        return NSFetchRequest<Producto>(entityName: "Producto")
    }

    @NSManaged public var nombre: String?
    @NSManaged public var precio: Float

}

extension Producto : Identifiable {

}
