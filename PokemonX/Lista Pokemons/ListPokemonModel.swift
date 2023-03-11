//
//  PokemonListModel.swift
//  PokemonX
//
//  Created by Joel Ramirez on 09/03/23.
//

import Foundation

struct Pokemons: Codable {
    var results: [Pokemon]
    
    enum CodingKeys: String, CodingKey {
         case results
     }
}

struct Response<T:Codable>: Codable{
    let message:String?
    let success: Bool?
    let data: T?
}

struct PruebaPok: Codable {
    var name: String
    var image:String
}
