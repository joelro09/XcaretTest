//
//  DetailPokemonModel.swift
//  PokemonX
//
//  Created by Joel Ramirez on 08/03/23.
//

import Foundation

struct Pokemon: Codable {
   var name: String?
   var url: URL
    
    var imageURL: URL {
        URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(url.lastPathComponent).png") ?? URL(string: "")!
        }
    
    init(){
        name = ""
        url = URL(string: "www.google.com")!
    }
}


struct Generation: Codable {
    var name: String
    var url: String
}

struct DetailPokemon: Codable {
    var id: Int
    var name: String
    var is_main_series: Bool
    var generation: Generation?
    var effect_entries: Effects?
    var pokemon: Pok?
    
    init(){
        id = 1
        name = "Default"
        is_main_series = true
        effect_entries = Effects()
        pokemon = Pok()
    }
}

struct Effects: Codable {
    var effect: String
    var short_effect: String
    
    init(){
        effect = "Default Effect Description"
        short_effect = "Default short"
    }
}

struct Pok: Codable {
    var is_hidden: Bool
    var slot: Int
    var pokemon: Pokemon
    
    init(){
        is_hidden = true
        slot = 1
        pokemon = Pokemon()
    }
}

struct PokemonD: Codable {
    let name: String
    let sprites: Sprites
}

struct Sprites: Codable {
    let frontDefault: URL
}
