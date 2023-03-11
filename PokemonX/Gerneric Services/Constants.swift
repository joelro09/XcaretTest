//
//  Constants.swift
//  PokemonX
//
//  Created by Joel Ramirez on 06/03/23.
//

import Foundation

class Constants {
    
    
    static let listPokemonsPath = "https://pokeapi.co/api/v2/pokemon?limit=20"
    
    static func detailPathPok(id: Int) -> String {
        "https://pokeapi.co/api/v2/ability/\(id)/"
    }
    
    
}
