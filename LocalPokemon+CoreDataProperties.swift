//
//  LocalPokemon+CoreDataProperties.swift
//  PokemonX
//
//  Created by Joel Ramirez on 12/03/23.
//
//

import Foundation
import CoreData


extension LocalPokemon {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LocalPokemon> {
        return NSFetchRequest<LocalPokemon>(entityName: "LocalPokemon")
    }

    @NSManaged public var url: String?
    @NSManaged public var name: String?

}

extension LocalPokemon : Identifiable {

}
